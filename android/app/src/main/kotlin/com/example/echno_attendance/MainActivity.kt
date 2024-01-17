package com.example.echno_attendance

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode

class MainActivity : FlutterFragmentActivity() {

    companion object {
        // Constants for channel names
        const val LOCATION_PERMISSION_CHANNEL = "locationPermissionPlatform"
        const val LOCATION_EVENT_CHANNEL = "com.example.locationconnectivity"
    }

    // List of required permissions
    private val requiredPermissions = mutableListOf(
        android.Manifest.permission.ACCESS_FINE_LOCATION,
        android.Manifest.permission.ACCESS_COARSE_LOCATION
    ).apply {

        // Add POST_NOTIFICATIONS permission for Android TIRAMISU and higher
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            add(android.Manifest.permission.POST_NOTIFICATIONS)
        }
    }.toTypedArray()

    // Variable to hold the result of method channel calls
    private lateinit var methodChannelResult: MethodChannel.Result

    // Activity result launcher for requesting multiple permissions
    private val requestPermissionLauncher =
        registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { isGranted ->
            if (isGranted.containsValue(false)) {
                handlePermissionDenied()
            } else {
                handleGrantedPermissions()
            }
        }

    // Activity result launcher for requesting background location permission
    private val requestBackgroundPermission =
        registerForActivityResult(ActivityResultContracts.RequestPermission()) { isGranted ->
            if (isGranted) {
                methodChannelResult.success(true)
            } else {
                showToast("Background Permission Denied...!")
                methodChannelResult.success(false)
            }
        }

    // EventSink to send events to Flutter
    private var attachEvent: EventChannel.EventSink? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Create notification channel if Android version is Oreo or higher
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createNotificationChannel()
        }

        // Register the activity as an EventBus subscriber
        EventBus.getDefault().register(this)
    }

    override fun onDestroy() {
        super.onDestroy()

        // Unregister the activity as an EventBus subscriber
        EventBus.getDefault().unregister(this)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createNotificationChannel() {
        try {

            // Create a notification channel with low importance
            val channel = NotificationChannel(
                "location",
                "Location",
                NotificationManager.IMPORTANCE_LOW
            )
            val notificationManager =
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        } catch (e: Exception) {
            Log.e("NotificationChannel", "Error creating notification channel", e)
        }
    }

    // Event listener for GeofenceEnterExitEvent
    @Subscribe(threadMode = ThreadMode.MAIN)
    fun onGeofenceEnter(event: GeofenceEnterExitEvent) {
        val data = event.data
        showToast(data)
        attachEvent?.success(data)
        Log.i("GeofenceEnter", data)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Register a custom Flutter view factory for map views
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "EchnoMapView",
                MapViewFactory(this, messenger = flutterEngine.dartExecutor.binaryMessenger)
            )

        // Set up MethodChannel for requesting location permissions
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            LOCATION_PERMISSION_CHANNEL
        ).setMethodCallHandler { call, result ->
            methodChannelResult = result
            when (call.method) {
                "getLocationPermission" -> {
                    requestPermissionLauncher.launch(requiredPermissions)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        // Set up EventChannel for sending location events to Flutter
        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            LOCATION_EVENT_CHANNEL
        ).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    attachEvent = events
                    Log.w("Event Channel", "Adding Listener...")
                }

                override fun onCancel(arguments: Any?) {
                    attachEvent = null
                    Log.w("Event Channel", "Cancelling Listener...")
                }
            }
        )
    }

    private fun handlePermissionDenied() {
        showToast("Permission Denied...!")
        methodChannelResult.success(false)
    }

    private fun handleGrantedPermissions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            // Request background location permission for Android Q and higher
            requestBackgroundPermission.launch(android.Manifest.permission.ACCESS_BACKGROUND_LOCATION)
        } else {
            // Continue with the success result if not Android Q or higher
            methodChannelResult.success(true)
        }
    }

    private fun showToast(message: String) {
        // Display a Toast message with the given text
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }
}

