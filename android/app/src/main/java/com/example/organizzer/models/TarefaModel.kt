package com.example.organizzer.models

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize


@Parcelize
data class TarefaModel(
    val id: String,
    val nome: String,
    val done: Boolean,
    val createdAt: String,
) : Parcelable
