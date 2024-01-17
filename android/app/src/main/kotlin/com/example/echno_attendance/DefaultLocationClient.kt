package com.example.echno_attendance

import android.annotation.SuppressLint
import android.content.Context
import android.location.Location
import android.location.LocationManager
import android.os.Looper
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.Priority
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.launch
class DefaultLocationClient(
    private val context: Context,
    private val client: FusedLocationProviderClient
) : LocationClient {
    @SuppressLint("MissingPermission")
    override fun getLocationUpdates(interval: Long): Flow<Location> {
        return callbackFlow {

            // Function to get location updates as a Flow
            if(!context.hasLocationPermission()){
                throw LocationClient.LocationClientException("Location Permission Not Granted!")
            }

            // Check if either GPS or network location services are enabled
            val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            val isGpsEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
            val isNetworkEnabled = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
            if(!isGpsEnabled && !isNetworkEnabled){
                throw LocationClient.LocationClientException("GPS Services Disabled")
            }

            // Creating LocationRequest for location updates
            val request = LocationRequest.Builder(Priority.PRIORITY_HIGH_ACCURACY, interval)
                .setWaitForAccurateLocation(false)
                .setMinUpdateIntervalMillis(2000)
                .setMaxUpdateDelayMillis(interval)
                .build()

            // Creating LocationCallback to handle location updates
            val locationCallback = object: LocationCallback(){
                override fun onLocationResult(result: LocationResult){
                    super.onLocationResult(result)
                    result.locations.lastOrNull()?.let {location ->
                        launch { send(location) }
                    }
                }
            }
            // Request location updates from Fused Location Provider
            client.requestLocationUpdates(
                request,
                locationCallback,
                Looper.getMainLooper()
            )

            // Suspending function that is called when the flow is no longer being collected
            awaitClose {
                // Remove location updates when the flow is closed
                client.removeLocationUpdates(locationCallback)
            }


        }
    }
}