# دليل صلاحيات التخزين - Storage Permissions Guide

## نظرة عامة
تم إضافة صلاحيات التخزين الكاملة للتطبيق لدعم تحميل الفيديوهات على جميع إصدارات Android.

## الصلاحيات المضافة

### Android Manifest (AndroidManifest.xml)
```xml
<!-- Storage permissions for downloads -->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

<!-- Android 13+ media permissions -->
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />

<!-- Download manager permissions -->
<uses-permission android:name="android.permission.DOWNLOAD_WITHOUT_NOTIFICATION" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
```

### خدمات التحميل
```xml
<!-- Download service for flutter_downloader -->
<service
    android:name="vn.hunghd.flutterdownloader.DownloadWorker"
    android:exported="false" />

<!-- Download receiver for flutter_downloader -->
<receiver android:exported="false" android:name="vn.hunghd.flutterdownloader.DownloadBroadcastReceiver" />
```

## إدارة الصلاحيات في الكود

### التحقق من إصدار Android
```dart
final androidInfo = await DeviceInfoPlugin().androidInfo;

if (androidInfo.version.sdkInt >= 33) {
    // Android 13+ - Request media permissions
    final videoStatus = await Permission.videos.request();
    final audioStatus = await Permission.audio.request();
    final photoStatus = await Permission.photos.request();
} else if (androidInfo.version.sdkInt >= 30) {
    // Android 11-12 - Request manage external storage
    final manageStorageStatus = await Permission.manageExternalStorage.request();
} else {
    // Android 10 and below - Request storage permission
    final storageStatus = await Permission.storage.request();
}
```

### طلب الصلاحيات
- **Android 13+**: يطلب صلاحيات الوسائط (فيديو، صوت، صور)
- **Android 11-12**: يطلب صلاحية إدارة التخزين الخارجي
- **Android 10 وأقل**: يطلب صلاحية التخزين التقليدية

## الميزات الجديدة

### 1. التحقق التلقائي من الصلاحيات
- فحص الصلاحيات قبل بدء التحميل
- طلب الصلاحيات إذا لم تكن متاحة
- رسائل خطأ واضحة للمستخدم

### 2. زر فحص الصلاحيات
- زر أمان في شريط الأدوات العلوي
- فحص حالة الصلاحيات الحالية
- إرشاد المستخدم لإعدادات التطبيق

### 3. معالجة الأخطاء المحسنة
- رسائل خطأ باللغة العربية
- إرشادات واضحة لحل المشاكل
- إمكانية فتح إعدادات التطبيق مباشرة

## كيفية الاستخدام

### للمطورين
1. استخدم `hasStoragePermission()` للتحقق من الصلاحيات
2. استخدم `requestPermission()` لطلب الصلاحيات
3. استخدم `checkStoragePermissions()` من الكوبيت

### للمستخدمين
1. اضغط على زر الأمان (🔒) في صفحة التحميلات
2. اتبع الإرشادات إذا لم تكن الصلاحيات متاحة
3. اذهب لإعدادات التطبيق ومنح الصلاحيات المطلوبة

## استكشاف الأخطاء

### مشاكل شائعة
1. **الصلاحيات مرفوضة**
   - اذهب لإعدادات التطبيق
   - ابحث عن "صلاحيات التطبيق" أو "App Permissions"
   - فعل صلاحيات التخزين أو الوسائط

2. **لا يعمل التحميل**
   - تحقق من اتصال الإنترنت
   - تأكد من وجود مساحة كافية
   - أعد تشغيل التطبيق

3. **مشاكل في Android 13+**
   - تأكد من منح صلاحية الوسائط
   - قد تحتاج صلاحية إدارة التخزين الخارجي
   - تحقق من إعدادات الخصوصية

### رسائل الخطأ
- `يجب منح صلاحيات التخزين لتحميل الفيديوهات`
- `تم منح جميع الصلاحيات المطلوبة للتحميل`
- `يجب منح صلاحيات التخزين لتحميل الفيديوهات`

## التوافق

### إصدارات Android المدعومة
- **Android 10 (API 29)**: صلاحيات التخزين التقليدية
- **Android 11-12 (API 30-32)**: إدارة التخزين الخارجي
- **Android 13+ (API 33+)**: صلاحيات الوسائط الجديدة

### الأجهزة المدعومة
- جميع أجهزة Android
- أجهزة بمساحة تخزين كافية
- أجهزة تدعم flutter_downloader

## الأمان والخصوصية

### حماية البيانات
- الفيديوهات محفوظة في مجلد خاص بالتطبيق
- لا يمكن للتطبيقات الأخرى الوصول للفيديوهات
- تشفير البيانات في قاعدة البيانات المحلية

### الصلاحيات المطلوبة فقط
- لا يتم طلب صلاحيات غير ضرورية
- الصلاحيات مطلوبة فقط عند الحاجة
- يمكن للمستخدم رفض الصلاحيات في أي وقت

## التطوير المستقبلي

### ميزات مخططة
- دعم iOS (عند إضافة مجلد iOS)
- تحسين طلب الصلاحيات
- إضافة صلاحيات الشبكة
- دعم التحميل المتعدد

### تحسينات الأداء
- تحسين سرعة طلب الصلاحيات
- تقليل استهلاك الذاكرة
- تحسين معالجة الأخطاء

## الدعم التقني

للمساعدة أو الإبلاغ عن مشاكل متعلقة بالصلاحيات، يرجى التواصل مع فريق التطوير مع ذكر:
- إصدار Android
- نوع الجهاز
- رسالة الخطأ (إن وجدت)
- خطوات إعادة إنتاج المشكلة
