package com.example.organizzer

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Context.MODE_PRIVATE
import android.content.Intent
import android.util.Log
import android.widget.*
import com.example.organizzer.models.TarefaModel
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

/**
 * Implementation of App Widget functionality.
 */
class TarefasHomeWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        super.onUpdate(context, appWidgetManager, appWidgetIds)

        Log.d("VenancioChannel", "passou no update!")

        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }

        appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetIds,R.id.itensLista )
    }

    override fun onEnabled(context: Context) {
        Log.d("VenancioChannel", "passou no onEnabled!")
    }

    override fun onDisabled(context: Context) {
        Log.d("VenancioChannel", "passou no onDisables!")
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        Log.d("VenancioChannel", "passou no onReceive!")
        super.onReceive(context, intent)
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val tarefas = getTarefas(context).toList()
    Log.d("MateusVenancio", "Tarefas: $tarefas")

    val intent = Intent(context, TarefasWidgetService::class.java)

    val views = RemoteViews(context.packageName, R.layout.tarefas_home_widget)
    views.setTextViewText(R.id.tituloLista, "Tarefas (${tarefas.size})")
    views.setRemoteAdapter(R.id.itensLista, intent)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}

private fun getTarefas(context: Context): Array<TarefaModel> {
    val conteudo = context.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
    val resultado = conteudo.getString("flutter.TAREFAS_DB", "[]") ?: "[]"
    Log.d("MateusVenancio", "Resultado SharPrefs: $resultado")
    val tipo = object : TypeToken<List<TarefaModel>>() {}.type
    return Gson().fromJson<List<TarefaModel>>(resultado, tipo).toTypedArray()
}

class TarefasAdaptador(
    private val context: Context,
    intent: Intent,
) : RemoteViewsService.RemoteViewsFactory {

    private var tarefas: List<TarefaModel> = emptyList()

    init {
        Log.d("MateusVenancio", "Chamou no construtor")
        tarefas = getTarefas(context).toList()
    }

    override fun getViewAt(position: Int): RemoteViews {
        Log.d("MateusVenancio", "Construiu view: $position")
        val view = RemoteViews(context.packageName, R.layout.lista_item)

        val tarefa = tarefas[position]

        // val formatter = DateTimeFormatter.ofPattern("MM d")
        // val criadoEm = LocalDate.parse(tarefa.createdAt).format(formatter)

        view.setTextViewText(R.id.listaItemLabel, "• ${tarefa.nome}")
        view.setTextViewText(R.id.listaItemDate, "")

        return view
    }

    override fun getLoadingView(): RemoteViews? = null

    override fun getViewTypeCount(): Int = 1

    override fun getItemId(position: Int): Long = position.toLong()

    override fun hasStableIds(): Boolean = false

    override fun getCount(): Int = tarefas.size // items.size

    override fun onCreate() {
        Log.d("MateusVenancio", "onCreate Adaptador")
        tarefas = getTarefas(context).toList()
        Log.d("MateusVenancio", "Depois: onCreate Adaptador")
    }

    override fun onDataSetChanged() {
        Log.d("MateusVenancio", "dataSetChanged Adaptador")
        tarefas = getTarefas(context).toList()
        Log.d("MateusVenancio", "Depois: dataSetChanged Adaptador")
    }

    override fun onDestroy() {}

}

class TarefasWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        // val conteudo = this.applicationContext.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
        // val resultado = conteudo.getString("flutter.TAREFAS_DB", "[]") ?: "[]"
        // val tipo = object : TypeToken<List<TarefaModel>>() {}.type
        // val tarefas = Gson().fromJson<List<TarefaModel>>(resultado, tipo).toTypedArray()


        return TarefasAdaptador(this.applicationContext, intent)
    }
}


















