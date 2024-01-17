package com.example.echno_attendance

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.android.gms.location.Geofence
import com.google.android.gms.location.GeofenceStatusCodes
import com.google.android.gms.location.GeofencingEvent
import org.greenrobot.eventbus.EventBus


class GeofenceBroadcastReceiver : BroadcastReceiver(){

    @SuppressLint("MissingPermission")
    override fun onReceive(context: Context?, intent: Intent?) {

        // Getting the GeofencingEvent from the incoming intent
        val geofencingEvent = intent?.let { GeofencingEvent.fromIntent(it) }

        // Checking for errors in the geofencing event
        if (geofencingEvent?.hasError() == true){
            val errorMessage = GeofenceStatusCodes.getStatusCodeString(geofencingEvent.errorCode)
            Log.e("Geofence", errorMessage)
            return
        }

        // Handling geofence transitions
        when(val geofenceTransition = geofencingEvent?.geofenceTransition){
            // If the user is entering the geofence
            Geofence.GEOFENCE_TRANSITION_ENTER ->{

                // Posting the event using EventBus for entering the geofence
                EventBus.getDefault().post(GeofenceEnterExitEvent("Entered Geofence"))

                // Create notification for entering the geofence
                val notificationBuilder = context?.let{
                    NotificationCompat.Builder(it, "location")
                        .setSmallIcon(R.drawable.launch_background)
                        .setContentTitle("Geofence")
                        .setContentText("Entered Geofence")
                        .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                }
                Log.i("Geofence", "Entered Geofence") // Log the geofence entry

                // Displaying the notification
                val notificationManager = context?.let{ NotificationManagerCompat.from(it) }
                notificationBuilder?.build()?.let { notificationManager?.notify(2, it) }
            }

            // If the user is exiting the geofence
            Geofence.GEOFENCE_TRANSITION_EXIT ->{

                // Posting the event using EventBus for exiting the geofence
                EventBus.getDefault().post(GeofenceEnterExitEvent("Exited Geofence"))

                // Create notification for exiting the geofence
                val notificationBuilder = context?.let{
                    NotificationCompat.Builder(it, "location")
                        .setSmallIcon(R.drawable.launch_background)
                        .setContentTitle("Geofence")
                        .setContentText("Exited Geofence")
                        .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                }
                Log.i("Geofence", "Exited Geofence") // Log the geofence exit

                // Displaying the notification
                val notificationManager = context?.let{ NotificationManagerCompat.from(it) }
                notificationBuilder?.build()?.let { notificationManager?.notify(3, it) }
            }
            else -> {
                // Log other geofence transitions if any
                Log.e("Geofence", geofenceTransition.toString())
            }
        }
    }
}