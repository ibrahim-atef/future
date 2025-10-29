# ================================
# Android 14+ BackEvent Fix
# ================================
-keep class android.window.BackEvent { *; }
-keep class android.window.BackAnimationController { *; }
-dontwarn android.window.BackEvent
-dontwarn android.window.BackAnimationController
-dontwarn android.window.**

# ================================
# Flutter Core
# ================================
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# ================================
# Flutter InAppWebView
# ================================
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-keep class io.flutter.plugins.webviewflutter.** { *; }

# Fix R8 BackEvent issue (Android 14+)
-dontwarn android.window.**
-keep class android.window.** { *; }

# ================================
# Firebase & Google Services
# ================================
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# ================================
# Syncfusion PDF
# ================================
-keep class com.syncfusion.** { *; }
-dontwarn com.syncfusion.**

# ================================
# Video Player
# ================================
-keep class io.flutter.plugins.videoplayer.** { *; }

# ================================
# Gson (for JSON serialization)
# ================================
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# ================================
# Retrofit & OkHttp
# ================================
-keepattributes Signature, InnerClasses, EnclosingMethod
-keepattributes RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations
-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-dontwarn javax.annotation.**
-dontwarn kotlin.Unit
-dontwarn retrofit2.KotlinExtensions
-dontwarn retrofit2.KotlinExtensions$*
-if interface * { @retrofit2.http.* <methods>; }
-keep,allowobfuscation interface <1>

# OkHttp
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

# ================================
# Enums, Models, & General Keep Rules
# ================================
-keep class * extends java.lang.Enum { *; }
-keepattributes *Annotation*
-keepattributes InnerClasses
-keepattributes EnclosingMethod
