package com.example.echno_attendance

import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.android.gms.location.LocationServices
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach

class LocationService(): Service(){
    // Coroutine scope for handling location updates asynchronously
    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private lateinit var locationClient: LocationClient

    // Binder for clients to communicate with the service
    private val binder = LocalBinder()
    private var locationCallback: LocationCallback? = null

    inner class LocalBinder : Binder() {
        fun getService(): LocationService = this@LocationService
    }

    override fun onBind(intent: Intent?): IBinder? {
        return binder
    }

    // Set the location callback to receive updates
    fun setLocationCallback(callback: LocationCallback) {
        locationCallback = callback
    }

    // Initialize the locationClient
    override fun onCreate() {
        super.onCreate()
        locationClient = DefaultLocationClient(
            applicationContext,
            LocationServices.getFusedLocationProviderClient(applicationContext)
        )
    }

    // Handle start and stop commands based on the received intent
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when(intent?.action){
            ACTION_START -> start()
            ACTION_STOP -> stop()
        }
        return super.onStartCommand(intent, flags, startId)
    }

    // Start the service to track location
    private fun start(){
        val notification = NotificationCompat.Builder(this,"location")
            .setContentTitle("Tracking Location...")
            .setContentText("Location: null")
            .setSmallIcon(R.drawable.launch_background)
            .setOngoing(true)

        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        // Start receiving location updates
        locationClient.getLocationUpdates(10000L)
            .catch { e -> e.printStackTrace() }
            .onEach { location ->
                val lat = location.latitude
                val long = location.longitude

                // Log and notify location updates
                Log.i("datais","lat lang ${lat} ${long}")
                locationCallback?.onLocationUpdated(lat, long)
//                callback?onDataReceived("lat lang ${lat} ${long}")

//                attachEvent?.success("lat lang ${lat} ${long}")
                // Update the notification with the current location
                val updatedNotification = notification.setContentText("Location: ($lat, $long)")
                notificationManager.notify(1, updatedNotification.build())
            }.launchIn(serviceScope)

        startForeground(1, notification.build())
    }

    // Stop the location tracking service
    private fun stop(){
//        callback?.onDataStopped()
        if(android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU){
            // Do something for Android 10 and above versions
            stopForeground(STOP_FOREGROUND_DETACH)
        }else {
            stopForeground(true)
        }
//        attachEvent?.endOfStram()
//        attachEvent = null
        stopSelf()
    }

    // Cancel the coroutine scope when the service is destroyed
    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel()
    }

    companion object {
        const val ACTION_START = "ACTION_START"
        const val ACTION_STOP = "ACTION_STOP"
    }
}