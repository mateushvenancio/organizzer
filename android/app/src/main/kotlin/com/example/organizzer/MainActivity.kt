package com.example.organizzer

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "CANAL"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            Log.d("VenancioChannel", "Passou aqui: ${call.method}")
            if (call.method == "UpdateTarefasWidget") {
                updateTarefasWidget()
                result.success(true)
            }
            if (call.method == "InitialParam") {
                val extra = intent.extras
                val teste = extra?.getString("origem")
                Log.d("VenancioChannel", "Passou extra: $extra Teste: $teste")
                if (extra != null) {
                    result.success("")
                }
            }
            result.success("")
        }
    }

    private fun updateTarefasWidget() {
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val ids = appWidgetManager.getAppWidgetIds(
            ComponentName(context, TarefasHomeWidget::class.java)
        )

        val intent = Intent(context, TarefasHomeWidget::class.java)
        intent.action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
        intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
        context.sendBroadcast(intent)
    }
}
