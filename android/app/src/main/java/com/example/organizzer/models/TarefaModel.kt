package com.example.organizzer.models

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize


@Parcelize
data class TarefaModel(
    @SerializedName("id")
    val id: String,
    @SerializedName("nome")
    val nome: String,
    @SerializedName("done")
    val done: Boolean,
    @SerializedName("createdAt")
    val createdAt: String,
) : Parcelable
