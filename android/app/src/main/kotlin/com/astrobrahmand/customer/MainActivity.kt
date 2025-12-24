package com.astrobrahmand.customer

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import io.flutter.embedding.engine.dart.DartExecutor

class MainActivity : FlutterActivity() {

    companion object {
        private const val FLUTTER_ENGINE_NAME = "flutter_engine"
        private const val CHAT_CHANNEL_NAME = "Chat notifications"
        private const val ALERT_CHANNEL_NAME = "Alert notifications"
    }

    private var latestNotificationData: Map<String, Any?>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Ensure Flutter engine is initialized only once
//        if (FlutterEngineCache.getInstance().get(FLUTTER_ENGINE_NAME) == null) {
//            val flutterEngine = FlutterEngine(this)
//            FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_NAME, flutterEngine)
//        }

        // Extract notification data from intent
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent) // Update intent for future reference
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent?) {
        intent?.extras?.let { extras ->
            latestNotificationData = extras.keySet().associateWith { key -> extras.get(key) }
        }
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        var flutterEngine = FlutterEngineCache.getInstance().get(FLUTTER_ENGINE_NAME)
        if (flutterEngine == null) {
            flutterEngine = FlutterEngine(context)
            flutterEngine.navigationChannel.setInitialRoute("/")
            flutterEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
            FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_NAME, flutterEngine)
        }
        return flutterEngine
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up MethodChannel communication
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHAT_CHANNEL_NAME).setMethodCallHandler { call, result ->
            when (call.method) {
                "notificationData" -> {
                    if (latestNotificationData != null) {
                        println("Sending notification data: $latestNotificationData")
                        result.success(latestNotificationData)
                    } else {
                        result.error("NO_DATA", "No notification data available", null)
                    }
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ALERT_CHANNEL_NAME).setMethodCallHandler { call, result ->
            when (call.method) {
                "alertNotificationData" -> {
                    if (latestNotificationData != null) {
                        println("Sending alert notification data: $latestNotificationData")
                        result.success(latestNotificationData)
                    } else {
                        result.error("NO_ALERT_DATA", "No alert notification data available", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}