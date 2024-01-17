package com.example.echno_attendance

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.graphics.Color
import android.location.LocationManager
import android.os.IBinder
import android.provider.Settings
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.Toast
import com.google.android.gms.location.Geofence
import com.google.android.gms.location.GeofencingClient
import com.google.android.gms.location.GeofencingRequest
import com.google.android.gms.location.LocationServices
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.model.CircleOptions
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.Marker
import com.google.android.gms.maps.model.MarkerOptions
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import java.util.UUID

class EchnoMapView(
    private val context: Context,
    messenger: BinaryMessenger,
    id: Int,
    creationParams: Map<String?, Any?>?,
    private val activity: FlutterFragmentActivity) : PlatformView, OnMapReadyCallback, LocationCallback {

        // UI Components
        private val linearLayout: LinearLayout = LinearLayout(context)
        private var mapview: MapView

        // Google Map & Geofencing
        private var mMap: GoogleMap? = null
        private var currentMarker: Marker? = null
        private val radiusInMeters = 800.0
        private val geofenceLatLng = LatLng(-33.8482439, 150.9319747)
        private val circleOptions = CircleOptions()
            .center(geofenceLatLng)
            .radius(radiusInMeters)
            .fillColor(Color.argb(70,255,0,0))
            .strokeColor(Color.RED)

        private val geofence = Geofence.Builder()
            .setRequestId(UUID.randomUUID().toString())
            .setCircularRegion(
                geofenceLatLng.latitude,
                geofenceLatLng.longitude,
                radiusInMeters.toFloat())
            .setTransitionTypes(Geofence.GEOFENCE_TRANSITION_ENTER or Geofence.GEOFENCE_TRANSITION_EXIT)
            .setExpirationDuration(Geofence.NEVER_EXPIRE)
            .build()
        private val geofencingRequest = GeofencingRequest.Builder()
            .setInitialTrigger(GeofencingRequest.INITIAL_TRIGGER_ENTER)
            .addGeofence(geofence)
            .build()
        private var geofencingClient: GeofencingClient

        // Location Services
        private var locationService: LocationService? = null
        private var isServiceBound = false
        private val serviceConnection = object : ServiceConnection {

            // Service Connection Callbacks
            override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
                val binder = service as LocationService.LocalBinder
                locationService = binder.getService()
                isServiceBound = true
                locationService?.setLocationCallback(this@EchnoMapView)
            }

            override fun onServiceDisconnected(name: ComponentName?) {
                locationService = null
                isServiceBound = false
            }
        }

        // Initialize the map and location services
        private fun getLocation(){
            val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            val isEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) || locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
            if (isEnabled){
                val serviceIntent = Intent(context, LocationService::class.java).apply {
                    action = LocationService.ACTION_START
                }
                context.startService(serviceIntent)
                context.bindService(serviceIntent, serviceConnection, Context.BIND_AUTO_CREATE)
            } else{
                val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
                context.startActivity(intent)
                Toast.makeText(context, "Please enable location services", Toast.LENGTH_LONG).show()
            }
        }

        // Geofence PendingIntent
        private val geofencePendingIntent: PendingIntent by lazy {
            val intent = Intent(context, GeofenceBroadcastReceiver::class.java)

            PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE)
        }

        override fun getView(): View {
            return linearLayout
        }

        override fun dispose() {
            geofencingClient.removeGeofences(geofencePendingIntent).run{
                addOnSuccessListener {
                    Toast.makeText(context, "Geofence Removed Successfully...", Toast.LENGTH_LONG).show()
                }
                addOnFailureListener {
                    Toast.makeText(context, "Geofence Removal Failed...", Toast.LENGTH_LONG).show()
                }
            }
            mapview.onDestroy()
        }

        // Constructors and initialization
        init {
            getLocation()
            geofencingClient = LocationServices.getGeofencingClient(context)

            // Setting up LinearLayout
            val layoutParams: ViewGroup.LayoutParams = ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
            linearLayout.layoutParams = layoutParams

            // Initializing MapView
            mapview = MapView(context)
            mapview.layoutParams = layoutParams
            linearLayout.addView(mapview)
            mapview.onCreate(null)
            mapview.getMapAsync(this)
        }

        // MapView lifecycle callbacks
        override fun onFlutterViewAttached(flutterView: View) {
            super.onFlutterViewAttached(flutterView)
            mapview.onResume()
        }

        override fun onFlutterViewDetached() {
            super.onFlutterViewDetached()
            mapview.onPause()
        }

        // Map ready callback
        @SuppressLint("MissingPermission")
        override fun onMapReady(googleMap: GoogleMap){
            mMap = googleMap

            // Adding geofence and circle to the map
            geofencingClient.addGeofences(geofencingRequest, geofencePendingIntent).run{
                addOnSuccessListener {
                    mMap?.addCircle(circleOptions)
                    Toast.makeText(context, "Geofence Added Successfully...", Toast.LENGTH_LONG).show()
                }
                addOnFailureListener {
                    Toast.makeText(context, "Geofence Addition Failed...", Toast.LENGTH_LONG).show()
                    Log.i("Geofence", "${it.message} ${it.cause} ${it}}")
                }
            }
        }

        // Location Update Callback
        override fun onLocationUpdated(latitude: Double, longitude: Double) {
            activity.runOnUiThread{
                if(mMap != null){
                    val myLocation = LatLng(latitude, longitude)
                    if (currentMarker != null){
                        currentMarker?.remove()
                    }
                    currentMarker = mMap?.addMarker(MarkerOptions().position(myLocation).title("Current Location"))
                    mMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(myLocation,10f))
                }
            }
        }
    }