package com.astrobrahmand.customer

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import android.content.pm.ServiceInfo
import android.util.Log

class CallForegroundService : Service() {

    companion object {
        private const val NOTIFICATION_ID = 2
        private const val CHANNEL_ID = "call_service_channel"
    }

    override fun onCreate() {
        super.onCreate()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Call Service",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }
    }

    private fun getNotification(): Notification {
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_notification)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
//            .setSilent(true)
            .setCategory(NotificationCompat.CATEGORY_SERVICE)
            .build()
    }

    private fun startForegroundServiceProperly() {
        val notification = getNotification()
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                val serviceTypes = (ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE or
                        ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK).toInt()
                startForeground(NOTIFICATION_ID, notification, serviceTypes)
            } else {
                startForeground(NOTIFICATION_ID, notification)
            }
        } catch (se: SecurityException) {
            // If permissions/state are not eligible for microphone FG service (Android 12+), avoid crashing the app.
            Log.e("CallForegroundService", "Unable to start foreground service", se)
            stopSelf()
        } catch (t: Throwable) {
            Log.e("CallForegroundService", "Unexpected error while starting foreground", t)
            stopSelf()
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        createNotificationChannel()
        startForegroundServiceProperly()
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
//            stopForeground(STOP_FOREGROUND_REMOVE)
//        } else {
//            stopForeground(true)
//        }
//        stopSelf()
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
}