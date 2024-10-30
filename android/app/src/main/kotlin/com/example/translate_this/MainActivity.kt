package com.example.translate_this

import android.speech.tts.TextToSpeech
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.w3c.dom.Text
import java.util.*

class MainActivity: FlutterActivity(), TextToSpeech.OnInitListener {

//    private val tts: TextToSpeech by lazy {
//        TextToSpeech(this,
//            TextToSpeech.OnInitListener { status ->
//                if (status == TextToSpeech.SUCCESS) {
//                    tts.language = Locale.UK
//                }
//            })
//    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val tts: TextToSpeech = TextToSpeech(this,this)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "translate.this.channel")
        channel.setMethodCallHandler { call, result ->
            if (call.method.equals("speak")) {
                val answer = call.arguments as String
                tts.speak(answer, TextToSpeech.QUEUE_FLUSH, null)
            }
        }
    }

    override fun onInit(status: Int) {

    }
}
