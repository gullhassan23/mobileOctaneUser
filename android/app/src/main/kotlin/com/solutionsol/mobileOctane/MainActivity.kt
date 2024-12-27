// package com.solutionsol.mobileOctane

// import io.flutter.embedding.android.FlutterActivity



// import io.flutter.embedding.android.FlutterFragmentActivity

 // class MainActivity: FlutterFragmentActivity() {

// private val CHANNEL = "flutter.native/helper"
// override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    //    super.configureFlutterEngine(flutterEngine)

       
  //  }
// }


package com.solutionsol.mobileOctane
import android.content.Intent

import android.content.Context
import android.widget.Toast
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "flutter.native/helper"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "nativeMethod") {
                    // Show a Toast message in Android
                    showToast("Hello from Native Code!")

                    // You can still use result.success() if needed
                    val message = "Method executed successfully."
                    result.success(message)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun showToast(message: String) {
        val context: Context = applicationContext
        val duration = Toast.LENGTH_SHORT

        val toast = Toast.makeText(context, message, duration)
        toast.show()

   val intent = Intent(this, MainActivity::class.java)
     startActivity(intent)
    }
}
