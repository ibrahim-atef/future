# R8 Configuration
-ignorewarnings

# Flutter InAppWebView - Android BackEvent
# The BackEvent class is only available in Android API 34+
-keep class android.window.BackEvent { *; }
-keep class android.window.BackAnimationController { *; }
-keep class android.window.** { *; }
-dontwarn android.window.**

# Flutter embedding
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.android.**

# InAppWebView - Comprehensive Rules
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-dontwarn com.pichillilorenzo.flutter_inappwebview.**

# WebView classes
-keep class android.webkit.** { *; }
-dontwarn android.webkit.**

# JavaScript interfaces
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# WebView subclasses
-keep class * extends android.webkit.WebViewClient {
    public *;
}

-keep class * extends android.webkit.WebChromeClient {
    public *;
}

# Keep JavaScript interface implementations
-keep @android.webkit.JavascriptInterface interface * {
    *;
}

# Keep ValueCallback implementations
-keep class * implements android.webkit.ValueCallback { *; }

# Keep DownloadListener
-keep class * implements android.webkit.DownloadListener {
    public *;
}

