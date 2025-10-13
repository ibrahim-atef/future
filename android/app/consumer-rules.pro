# Flutter InAppWebView - Android BackEvent
# The BackEvent class is only available in Android API 34+
-dontwarn android.window.**
-ignorewarnings

# Flutter embedding
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.android.**

# InAppWebView
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-dontwarn com.pichillilorenzo.flutter_inappwebview.**

