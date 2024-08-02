package com.example.homedocorapp

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.BatteryManager
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "battery_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "startBatteryMonitor") {
                    startBatteryMonitor()
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun startBatteryMonitor() {
        val ifilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        val batteryReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                val level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)

                val batteryPct = level / scale.toFloat() * 100

                if (status == BatteryManager.BATTERY_STATUS_CHARGING && batteryPct >= 90) {
                    // Play a ringtone
                    val notification: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
                    val ringtone: Ringtone = RingtoneManager.getRingtone(applicationContext, notification)
                    ringtone.play()

                    // Show a toast message
                    Toast.makeText(applicationContext, "Battery is at ${batteryPct.toInt()}%", Toast.LENGTH_LONG).show()
                }
            }
        }
        registerReceiver(batteryReceiver, ifilter)
    }
}
