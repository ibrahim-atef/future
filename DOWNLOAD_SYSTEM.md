# نظام تحميل الفيديوهات - Future App

## نظرة عامة

تم تطبيق نظام تحميل الفيديوهات المأخوذ من تطبيق Anmka-Creation مع بعض التحسينات. يتيح هذا النظام للمستخدمين تحميل الفيديوهات ومشاهدتها بدون إنترنت.

## المكونات الرئيسية

### 1. DownloadManager (`lib/core/services/download_manager.dart`)
مدير التحميل الأساسي المسؤول عن:
- تحميل الملفات باستخدام Dio
- التخزين في `ApplicationSupportDirectory` (ملفات التطبيق الداخلية)
- البحث عن الملفات المحملة
- حذف الملفات

#### الدوال الرئيسية:
```dart
// تحميل ملف
DownloadManager.download(
  String url,
  name: String fileName,
  onDownload: (progress) { },
  authToken: String? token,
);

// البحث عن ملف محمل
DownloadManager.findFile(directory, fileName);

// حذف ملف
DownloadManager.deleteFile(fileName);

// الحصول على مسار ملف محلي
DownloadManager.getLocalFilePath(fileName);
```

### 2. DownloadService (`lib/features/downloads/data/service/download_service.dart`)
خدمة التحميل التي توفر:
- إدارة قاعدة بيانات SQLite للفيديوهات المحملة
- طلب صلاحيات التخزين
- تحميل الفيديوهات من API
- الحصول على قائمة الفيديوهات المحملة

#### الدوال الرئيسية:
```dart
// تحميل فيديو باستخدام DownloadManager
downloadVideoWithManager({
  required String videoUrl,
  required String lessonId,
  required String courseId,
  required String title,
  ...
});

// الحصول على الفيديوهات المحملة
getDownloadedVideosWithManager();

// التحقق من وجود ملف محلي
checkLocalVideoFile(String lessonId);
```

### 3. DownloadCubit (`lib/features/downloads/logic/cubit/download_cubit.dart`)
إدارة الحالة للتحميلات:

```dart
// تحميل درس
downloadLessonWithManager(String lessonId);

// تحميل فيديو تجريبي
downloadSpecificVideoWithManager();

// الحصول على الفيديوهات المحملة
getDownloadedVideosWithManager();
```

## كيفية الاستخدام

### 1. تحميل فيديو

```dart
// من UI
context.read<DownloadCubit>().downloadLessonWithManager('42');

// أو تحميل مباشر
await DownloadService().downloadVideoWithManager(
  videoUrl: 'https://example.com/video.mp4',
  lessonId: '42',
  courseId: '38',
  title: 'عنوان الفيديو',
  description: 'وصف الفيديو',
  fileSizeMb: 22.59,
  durationText: '2 دقيقة',
  videoSource: 'server',
);
```

### 2. عرض الفيديوهات المحملة

```dart
// في الـ UI
BlocBuilder<DownloadCubit, DownloadState>(
  builder: (context, state) {
    if (state is GetDownloadedVideosSuccess) {
      return ListView.builder(
        itemCount: state.videos.length,
        itemBuilder: (context, index) {
          final video = state.videos[index];
          return ListTile(
            title: Text(video.title),
            subtitle: Text(video.durationText),
            onTap: () {
              // تشغيل الفيديو
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DownloadedVideoPlayer(
                    videoPath: video.localPath,
                    videoTitle: video.title,
                  ),
                ),
              );
            },
          );
        },
      );
    }
    return CircularProgressIndicator();
  },
);
```

### 3. تشغيل فيديو محمل

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DownloadedVideoPlayer(
      videoPath: video.localPath,
      videoTitle: video.title,
    ),
  ),
);
```

## صفحات Offline

تم إنشاء ثلاث صفحات للوصول للمحتوى بدون اتصال:

### 1. OfflineListCoursePage
- عرض قائمة الكورسات المحملة محلياً
- المسار: `/offline-list-course`

### 2. OfflineSingleCoursePage
- عرض تفاصيل كورس محمل
- عرض قائمة الدروس والمحتوى

### 3. OfflineSingleContentPage
- عرض محتوى درس محمل (فيديو/PDF)
- تشغيل الفيديوهات من التخزين المحلي

## مسار التخزين

الفيديوهات يتم تخزينها في:
```
ApplicationSupportDirectory/video_[lessonId]_[timestamp].mp4
```

هذا المسار:
- ✅ خاص بالتطبيق فقط
- ✅ لا يظهر في معرض الصور
- ✅ يتم حذفه عند حذف التطبيق
- ✅ لا يحتاج صلاحيات خاصة على iOS
- ✅ يعمل مع صلاحيات محدودة على Android 13+

## قاعدة البيانات

تخزين معلومات الفيديوهات في SQLite:

```sql
CREATE TABLE downloaded_videos(
  id TEXT PRIMARY KEY,
  lesson_id TEXT,
  course_id TEXT,
  title TEXT,
  description TEXT,
  video_url TEXT,
  local_path TEXT,
  file_size INTEGER,
  file_size_mb REAL,
  file_type TEXT,
  duration INTEGER,
  duration_text TEXT,
  video_source TEXT,
  downloaded_at TEXT,
  thumbnail_path TEXT
)
```

## الصلاحيات المطلوبة

### Android
- Android 13+: `videos`, `photos`, `audio`
- Android 11-12: `manageExternalStorage` أو `storage`
- Android 10 وأقل: `storage`

### iOS
- لا حاجة لصلاحيات خاصة (التخزين في مجلد التطبيق)

## الفرق بين النظامين

### flutter_downloader (القديم)
- ❌ معقد في الإعداد
- ❌ يحتاج WorkManager
- ❌ مشاكل مع الصلاحيات
- ✅ إدارة تلقائية للتحميل في الخلفية

### DownloadManager (الجديد - من Anmka-Creation)
- ✅ بسيط وسهل الاستخدام
- ✅ تحكم كامل في التحميل
- ✅ يعمل بشكل موثوق
- ✅ أقل مشاكل مع الصلاحيات
- ⚠️ التحميل يتوقف عند إغلاق التطبيق

## استكشاف الأخطاء

### الفيديو لا يتم تحميله
1. تحقق من الصلاحيات: `checkStoragePermissions()`
2. تحقق من رابط الفيديو
3. راجع logs في Console

### الفيديو المحمل لا يظهر
1. تحقق من قاعدة البيانات
2. تحقق من وجود الملف في المسار
3. استخدم `getDownloadedVideosWithManager()` لإعادة تحميل القائمة

### الفيديو لا يعمل
1. تحقق من صيغة الفيديو (يجب أن تكون mp4)
2. تحقق من حجم الملف
3. جرب إعادة تحميل الفيديو

## الاختبار

### تحميل فيديو تجريبي
```dart
context.read<DownloadCubit>().downloadSpecificVideoWithManager();
```

هذا سيحمل فيديو تجريبي من السيرفر للاختبار.

## الخلاصة

النظام الجديد يوفر:
- ✅ تحميل موثوق للفيديوهات
- ✅ تخزين آمن في مجلد التطبيق
- ✅ مشاهدة بدون إنترنت
- ✅ إدارة سهلة للملفات
- ✅ واجهة مستخدم جذابة
- ✅ دعم كامل للغة العربية وRTL

