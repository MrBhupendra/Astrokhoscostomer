package com.astrokhosh.customer

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.app.NotificationManager
import android.app.ActivityManager
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat


class CallOngoingTimeNotificationReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null || intent == null) return

        when (intent.action) {
            "com.astrokhosh.customer.START_CALL_NOTIFICATION" -> {
                if (CallTimerService.instance?.isRunning != true) {
                    val serviceIntent = Intent(context, CallTimerService::class.java)
                    serviceIntent.putExtra("initial_seconds", intent.getIntExtra("call_duration_seconds", 0))
                    Handler(Looper.getMainLooper()).postDelayed({
                        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                            context.startForegroundService(serviceIntent)
                        } else {
                            context.startService(serviceIntent)
                        }
                    }, 500)
                }
            }

            "com.astrokhosh.customer.START_MICROPHONE_NOTIFICATION" -> {
                val isForeground = isAppInForeground(context)

        val hasRecordAudioPermission =
          ContextCompat.checkSelfPermission(context, android.Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED

        if (!hasRecordAudioPermission) {
          Log.w("CallNotificationReceiver", "Skipped mic service start — RECORD_AUDIO not granted")
          return
        }

        // Android 12+ restricts starting foreground services from background for sensitive types (like microphone).
        // We skip instead of crashing; voice call will continue via other components.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && !isForeground) {
          Log.w("CallNotificationReceiver", "Skipped mic service start — Android 12+ + app not foreground")
                    return
                }

                val foregroundServiceIntent = Intent(context, CallForegroundService::class.java)
                Handler(Looper.getMainLooper()).postDelayed({
                    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                        context.startForegroundService(foregroundServiceIntent)
                    } else {
                        context.startService(foregroundServiceIntent)
                    }
                }, 500)
            }

            "com.astrokhosh.customer.UPDATE_CALL_NOTIFICATION" -> {
                val duration = intent.getIntExtra("call_duration_seconds", 0)
                Log.d("CallNotificationReceiver", "Updating call notification: $duration seconds")
                if (CallTimerService.instance != null && CallTimerService.instance?.isRunning == true) {
                    CallTimerService.updateCallDuration(duration)
                } else {
                    Log.d("CallNotificationReceiver", "Service is not running, skipping update")
                    val stopIntent = Intent(context, CallTimerService::class.java)
                    context.stopService(stopIntent)
                    val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                    notificationManager.cancel(CallTimerService.CALL_NOTIFICATION_ID)
                }
            }

            "com.astrokhosh.customer.STOP_CALL_NOTIFICATION" -> {
                Log.d("CallNotificationReceiver", "STOP_CALL_NOTIFICATION received in BroadcastReceiver")

                val stopIntent = Intent(context, CallTimerService::class.java).apply {
                    action = "ACTION_CANCEL_ONGOING_CALL_NOTIFICATION"
                }
                context.stopService(stopIntent)
//                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//                    Log.d("CallNotificationReceiver", "Using startForegroundService for stopIntent")
//                    context.startForegroundService(stopIntent)  // Ensure intent process na ho jaye drop
//                } else {
//                    Log.d("CallNotificationReceiver", "Using startService for stopIntent")
//                    context.startService(stopIntent)
//                }
//                try {
//                    context.unregisterReceiver(this)
//                } catch (Exception e) {
//                    Log.e("CallNotificationReceiver", "Receiver already unregistered or error: ${e.message}")
//                }
                val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                notificationManager.cancel(CallTimerService.CALL_NOTIFICATION_ID)
//                val stopIntent = Intent(context, CallTimerService::class.java)
//                context.stopService(stopIntent)
//                val serviceStopped = context.stopService(stopIntent)
//
//                if (serviceStopped) {
//                    Log.d("CallNotificationReceiver", "CallTimerService stopped successfully")
//                    CallTimerService.instance = null
//                } else {
//                    Log.d("CallNotificationReceiver", "Failed to stop CallTimerService")
//                }
            }

            "com.astrokhosh.customer.STOP_MIC_NOTIFICATION" -> {
                val micServiceIntent = Intent(context, CallForegroundService::class.java)
                context.stopService(micServiceIntent)
            }
        }
    }

    private fun isAppInForeground(context: Context): Boolean {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val appProcesses = activityManager.runningAppProcesses ?: return false
        val packageName = context.packageName
        for (appProcess in appProcesses) {
            if (appProcess.importance == ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND
                && appProcess.processName == packageName) {
                return true
            }
        }
        return false
    }
}