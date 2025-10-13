# Flutter Secure Storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# Device Info Plus
-keep class dev.fluttercommunity.plus.deviceinfo.** { *; }

# Keep native methods
-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}

# Flutter InAppWebView - Android BackEvent
# The BackEvent class is only available in Android API 34+
# We need to suppress warnings for backward compatibility
-dontwarn android.window.**
-ignorewarnings

# Flutter embedding - keep all classes to avoid R8 issues
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep interface io.flutter.** { *; }
-dontwarn io.flutter.embedding.android.**

# InAppWebView
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-dontwarn com.pichillilorenzo.flutter_inappwebview.**