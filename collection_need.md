# احتياجات API Collections للتطبيق - Future App

## نظرة عامة
هذا الملف يحتوي على جميع الـ API Endpoints المطلوبة لإكمال التطبيق بشكل كامل وجاهز للعمل.

---

## 1️⃣ Authentication APIs (المصادقة والتسجيل)

### ✅ متوفرة حالياً:
- `POST /login` - تسجيل الدخول
- `POST /logout` - تسجيل الخروج
- `POST /register/step/1` - التسجيل خطوة 1
- `POST /register/step/2` - التسجيل خطوة 2 (التحقق من الكود)

### ❌ مطلوبة:
- `POST /forget-password` - نسيت كلمة المرور
- `POST /reset-password/{token}` - إعادة تعيين كلمة المرور
- `POST /verification` - التحقق من الكود

**البيانات المطلوبة:**
```json
// Login Request
{
  "username": "string (email or mobile)",
  "password": "string",
  "device_id": "string"
}

// Login Response
{
  "success": true,
  "token": "string",
  "user": {
    "id": "string",
    "full_name": "string",
    "email": "string",
    "mobile": "string",
    "role_name": "string",
    "avatar": "string (url)",
    "cover": "string (url)"
  }
}

// Forgot Password Request
{
  "email": "string"
}

// Reset Password Request
{
  "password": "string",
  "password_confirmation": "string"
}

// Verify Code Request
{
  "code": "string",
  "mobile": "string"
}
```

---

## 2️⃣ Configuration APIs (الإعدادات العامة)

### ❌ مطلوبة بالكامل:
- `GET /config` - إعدادات التطبيق العامة
- `GET /config/register/{type}` - إعدادات التسجيل حسب النوع
- `GET /regions/countries/code` - أكواد الدول
- `GET /currency/list` - قائمة العملات

**البيانات المطلوبة:**
```json
// App Config Response
{
  "app_config": {
    "app_name": "Future App",
    "app_version": "1.0.0",
    "min_version": "1.0.0",
    "maintenance_mode": false,
    "maintenance_message": "string"
  }
}

// Register Config Response
{
  "type": "student",
  "required_fields": ["full_name", "email", "mobile", "password"],
  "optional_fields": ["bio", "about"],
  "validation": {
    "mobile": "regex pattern",
    "password": "min:8"
  }
}

// Country Codes Response
[
  {
    "code": "+20",
    "name": "مصر",
    "flag": "url"
  }
]

// Currency List Response
[
  {
    "code": "EGP",
    "name": "جنيه مصري",
    "symbol": "ج.م",
    "rate": 1.0
  }
]
```

---

## 3️⃣ Courses APIs (الكورسات)

### ❌ مطلوبة بالكامل:
- `GET /courses` - قائمة الكورسات (مع pagination)
- `GET /courses/{id}` - تفاصيل كورس معين
- `GET /courses/{id}/content` - محتوى الكورس (المحاضرات)
- `GET /courses/{id}/quizzes` - اختبارات الكورس
- `GET /courses/{id}/certificates` - شهادات الكورس
- `POST /courses/{id}/report` - الإبلاغ عن كورس
- `POST /courses/{webinarId}/toggle` - تفعيل/إيقاف حالة التعلم
- `GET /search/courses` - البحث في الكورسات

**البيانات المطلوبة:**
```json
// Get Courses Request (Query Parameters)
{
  "page": 1,
  "limit": 10
}

// Get Courses Response
{
  "data": [
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "teacherName": "string",
      "imageUrl": "string (url)",
      "level": "string (الفرقة - أولى، ثانية، ثالثة، رابعة)",
      "language": "العربية",
      "totalHours": 40,
      "rating": 4.5,
      "studentsCount": 150,
      "isFree": false,
      "price": 500.0,
      "tags": ["قانون", "مدني"],
      "createdAt": "2024-01-01T00:00:00Z",
      "updatedAt": "2024-01-01T00:00:00Z"
    }
  ],
  "pagination": {
    "current_page": 1,
    "total_pages": 10,
    "total_items": 100
  }
}

// Get Course Detail Response
{
  "id": "string",
  "title": "string",
  "description": "string",
  "teacherName": "string",
  "imageUrl": "string",
  "level": "أولى",
  "language": "العربية",
  "totalHours": 40,
  "rating": 4.5,
  "studentsCount": 150,
  "isFree": false,
  "price": 500.0,
  "tags": ["قانون", "مدني"],
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z"
}

// Get Course Content Response
{
  "lectures": [
    {
      "id": "string",
      "courseId": "string",
      "title": "string",
      "description": "string",
      "type": "video|pdf|audio",
      "videoUrl": "string (url or youtube url)",
      "pdfUrl": "string (url)",
      "audioUrl": "string (url)",
      "thumbnailUrl": "string (url)",
      "duration": 3600,
      "order": 1,
      "week": "الأسبوع الأول",
      "module": "الوحدة الأولى",
      "isFree": false,
      "isDownloadable": true,
      "createdAt": "2024-01-01T00:00:00Z",
      "updatedAt": "2024-01-01T00:00:00Z"
    }
  ]
}

// Report Course Request
{
  "reason": "string",
  "message": "string"
}

// Search Courses Request (Query Parameters)
{
  "search": "string",
  "category_id": "string"
}
```

---

## 4️⃣ Quizzes APIs (الاختبارات)

### ❌ مطلوبة بالكامل:
- `GET /panel/quizzes/results/my-results` - نتائج اختباراتي
- `GET /panel/quizzes/{id}/start` - بدء اختبار
- `POST /panel/quizzes/{id}/store-result` - حفظ نتيجة الاختبار

**البيانات المطلوبة:**
```json
// Get Course Quizzes Response
{
  "quizzes": [
    {
      "id": "string",
      "course_id": "string",
      "title": "string",
      "description": "string",
      "time_limit": 60,
      "total_questions": 20,
      "passing_score": 70,
      "is_active": true,
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    }
  ]
}

// Start Quiz Response
{
  "id": "string",
  "course_id": "string",
  "title": "string",
  "questions": [
    {
      "id": "string",
      "quiz_id": "string",
      "question": "string",
      "type": "multiple_choice|true_false|text",
      "options": [
        {
          "id": "string",
          "text": "string",
          "is_correct": false
        }
      ],
      "points": 5,
      "order": 1
    }
  ]
}

// Submit Quiz Result Request
{
  "answers": {
    "question_id_1": "answer",
    "question_id_2": "answer"
  },
  "time_spent": 3600
}

// Submit Quiz Result Response
{
  "id": "string",
  "quiz_id": "string",
  "user_id": "string",
  "score": 85,
  "total_questions": 20,
  "correct_answers": 17,
  "wrong_answers": 3,
  "percentage": 85.0,
  "passed": true,
  "time_spent": 3600,
  "completed_at": "2024-01-01T00:00:00Z",
  "created_at": "2024-01-01T00:00:00Z"
}

// My Quiz Results Response
{
  "results": [
    {
      "id": "string",
      "quiz_id": "string",
      "user_id": "string",
      "score": 85,
      "total_questions": 20,
      "correct_answers": 17,
      "wrong_answers": 3,
      "percentage": 85.0,
      "passed": true,
      "time_spent": 3600,
      "completed_at": "2024-01-01T00:00:00Z",
      "created_at": "2024-01-01T00:00:00Z"
    }
  ]
}
```

---

## 5️⃣ Blog APIs (المدونة)

### ❌ مطلوبة بالكامل:
- `GET /posts` - قائمة مقالات المدونة
- `GET /posts/{id}` - تفاصيل مقال معين

**البيانات المطلوبة:**
```json
// Get Blog Posts Response
{
  "posts": [
    {
      "id": "string",
      "title": "string",
      "content": "string (HTML content)",
      "excerpt": "string",
      "imageUrl": "string (url)",
      "author": "string",
      "tags": ["تعليمي", "نصائح"],
      "viewsCount": 150,
      "publishedAt": "2024-01-01T00:00:00Z",
      "createdAt": "2024-01-01T00:00:00Z",
      "updatedAt": "2024-01-01T00:00:00Z"
    }
  ]
}

// Get Single Post Response
{
  "id": "string",
  "title": "string",
  "content": "string (Full HTML content)",
  "excerpt": "string",
  "imageUrl": "string (url)",
  "author": "string",
  "tags": ["تعليمي", "نصائح"],
  "viewsCount": 150,
  "publishedAt": "2024-01-01T00:00:00Z",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z"
}
```

---

## 6️⃣ Profile & Settings APIs (الملف الشخصي والإعدادات)

### ❌ مطلوبة بالكامل:
- `GET /panel/profile-setting` - جلب بيانات الملف الشخصي
- `PUT /panel/profile-setting` - تحديث الملف الشخصي
- `PUT /panel/profile-setting/password` - تحديث كلمة المرور
- `POST /panel/profile-setting/images` - رفع صور الملف الشخصي
- `PUT /panel/users/fcm` - تحديث FCM Token للإشعارات

**البيانات المطلوبة:**
```json
// Get Profile Settings Response
{
  "id": "string",
  "full_name": "string",
  "email": "string",
  "mobile": "string",
  "bio": "string",
  "about": "string",
  "avatar": "string (url)",
  "cover": "string (url)",
  "role_name": "student|teacher|admin",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z"
}

// Update Profile Request
{
  "full_name": "string",
  "mobile": "string",
  "bio": "string",
  "about": "string"
}

// Update Password Request
{
  "current_password": "string",
  "new_password": "string",
  "new_password_confirmation": "string"
}

// Update Profile Images Request (FormData)
{
  "avatar": "file (image)",
  "cover": "file (image)"
}

// Update FCM Token Request
{
  "fcm_id": "string"
}
```

---

## 7️⃣ Users & Providers APIs (المستخدمين والمدرسين)

### ❌ مطلوبة بالكامل:
- `GET /providers/instructors` - قائمة المدرسين
- `GET /providers/organizations` - قائمة المنظمات
- `GET /users/{id}/profile` - ملف شخصي لمستخدم
- `POST /users/{id}/send-message` - إرسال رسالة لمستخدم

**البيانات المطلوبة:**
```json
// Get Instructors Response
{
  "instructors": [
    {
      "id": "string",
      "full_name": "string",
      "email": "string",
      "bio": "string",
      "avatar": "string (url)",
      "role_name": "teacher"
    }
  ]
}

// Get Organizations Response
{
  "organizations": [
    {
      "id": "string",
      "full_name": "string",
      "email": "string",
      "bio": "string",
      "avatar": "string (url)",
      "role_name": "organization"
    }
  ]
}

// Send Message Request
{
  "message": "string"
}
```

---

## 8️⃣ Notifications APIs (الإشعارات)

### ❌ مطلوبة بالكامل:
- `GET /users/{userId}/notifications` - قائمة الإشعارات
- `PUT /notifications/{id}/read` - تعليم إشعار كمقروء
- `DELETE /notifications/{id}` - حذف إشعار

**البيانات المطلوبة:**
```json
// Get Notifications Response
{
  "notifications": [
    {
      "id": "string",
      "userId": "string",
      "title": "string",
      "message": "string",
      "type": "course|blog|system|download",
      "relatedId": "string (courseId or postId)",
      "imageUrl": "string (url)",
      "isRead": false,
      "createdAt": "2024-01-01T00:00:00Z"
    }
  ]
}
```

---

## 9️⃣ Regions APIs (المناطق الجغرافية)

### ❌ مطلوبة بالكامل:
- `GET /regions/countries` - قائمة الدول
- `GET /regions/provinces/{countryId}` - المحافظات حسب الدولة
- `GET /regions/cities/{provinceId}` - المدن حسب المحافظة
- `GET /regions/districts/{cityId}` - الأحياء حسب المدينة

**البيانات المطلوبة:**
```json
// Get Countries Response
{
  "countries": [
    {
      "id": "string",
      "name": "مصر",
      "code": "EG",
      "flag": "url",
      "is_active": true
    }
  ]
}

// Get Provinces Response
{
  "provinces": [
    {
      "id": "string",
      "country_id": "string",
      "name": "القاهرة",
      "code": "CAI",
      "is_active": true
    }
  ]
}

// Get Cities Response
{
  "cities": [
    {
      "id": "string",
      "province_id": "string",
      "name": "مدينة نصر",
      "code": "NSR",
      "is_active": true
    }
  ]
}

// Get Districts Response
{
  "districts": [
    {
      "id": "string",
      "city_id": "string",
      "name": "الحي الأول",
      "code": "D01",
      "is_active": true
    }
  ]
}
```

---

## 🔟 Cart & Purchases APIs (السلة والمشتريات)

### ❌ مطلوبة بالكامل:
- `GET /panel/cart` - جلب السلة
- `POST /panel/cart/store` - إضافة عنصر للسلة
- `DELETE /panel/cart/{itemId}` - حذف عنصر من السلة
- `POST /panel/cart/coupon/validate` - التحقق من كوبون خصم
- `POST /panel/cart/checkout` - إتمام عملية الشراء
- `GET /panel/purchases` - قائمة المشتريات

**البيانات المطلوبة:**
```json
// Get Cart Response
{
  "id": "string",
  "user_id": "string",
  "items": [
    {
      "id": "string",
      "item_id": "string",
      "item_name": "webinar|bundle|course",
      "item_type": "course",
      "title": "string",
      "price": 500.0,
      "image_url": "string (url)",
      "added_at": "2024-01-01T00:00:00Z"
    }
  ],
  "subtotal": 1500.0,
  "discount": 150.0,
  "total": 1350.0,
  "coupon_code": "SAVE10",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z"
}

// Add to Cart Request
{
  "item_id": "string",
  "item_name": "webinar|bundle|course"
}

// Validate Coupon Request
{
  "coupon": "string"
}

// Validate Coupon Response
{
  "valid": true,
  "message": "تم تطبيق الكوبون بنجاح",
  "discount": 10.0,
  "discount_type": "percentage|fixed"
}

// Checkout Request
{
  "gateway": "stripe|paypal|paymob|fawry",
  "coupon": "string (optional)"
}

// Checkout Response
{
  "success": true,
  "payment_url": "string (url to payment gateway)",
  "transaction_id": "string",
  "message": "تم إنشاء عملية الدفع بنجاح"
}

// Get Purchases Response
{
  "purchases": [
    {
      "id": "string",
      "course_id": "string",
      "course_title": "string",
      "amount": 500.0,
      "status": "completed|pending|failed",
      "purchased_at": "2024-01-01T00:00:00Z"
    }
  ]
}
```

---

## 1️⃣1️⃣ College Section APIs (قسم الكلية)

### ❌ مطلوبة بالكامل:
- `GET /college/recordings` - تسجيلات الكلية
- `GET /college/books` - الكتب والمذكرات
- `GET /college/schedules` - جداول الشرح والامتحانات
- `GET /college/levels` - الفرق الدراسية (أولى، ثانية، ثالثة، رابعة)

**البيانات المطلوبة:**
```json
// Get College Recordings Response
{
  "recordings": [
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "audioUrl": "string (url)",
      "duration": 3600,
      "level": "أولى",
      "subject": "قانون مدني",
      "uploadedAt": "2024-01-01T00:00:00Z"
    }
  ]
}

// Get College Books Response
{
  "books": [
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "pdfUrl": "string (url)",
      "coverUrl": "string (url)",
      "level": "أولى",
      "subject": "قانون مدني",
      "pages": 250,
      "uploadedAt": "2024-01-01T00:00:00Z"
    }
  ]
}

// Get College Schedules Response
{
  "schedules": [
    {
      "id": "string",
      "type": "lecture|exam",
      "title": "string",
      "subject": "قانون مدني",
      "level": "أولى",
      "date": "2024-01-01",
      "time": "10:00 AM",
      "location": "قاعة 101",
      "instructor": "د. أحمد محمد"
    }
  ]
}

// Get College Levels Response
{
  "levels": [
    {
      "id": "string",
      "name": "أولى",
      "code": "level_1",
      "description": "الفرقة الأولى"
    },
    {
      "id": "string",
      "name": "ثانية",
      "code": "level_2",
      "description": "الفرقة الثانية"
    },
    {
      "id": "string",
      "name": "ثالثة",
      "code": "level_3",
      "description": "الفرقة الثالثة"
    },
    {
      "id": "string",
      "name": "رابعة",
      "code": "level_4",
      "description": "الفرقة الرابعة"
    }
  ]
}
```

---

## 1️⃣2️⃣ Downloads APIs (التحميلات)

### ❌ مطلوبة بالكامل:
- `GET /panel/downloads` - قائمة التحميلات المتاحة
- `GET /panel/downloads/my-downloads` - تحميلاتي
- `POST /panel/downloads/{lectureId}/track` - تتبع التحميل

**البيانات المطلوبة:**
```json
// Get Available Downloads Response
{
  "downloads": [
    {
      "id": "string",
      "lecture_id": "string",
      "title": "string",
      "type": "video|pdf|audio",
      "url": "string (direct download url)",
      "size": "100 MB",
      "duration": 3600,
      "isDownloaded": false
    }
  ]
}

// Get My Downloads Response
{
  "downloads": [
    {
      "id": "string",
      "lecture_id": "string",
      "title": "string",
      "type": "video|pdf|audio",
      "localPath": "string (local file path)",
      "size": "100 MB",
      "downloadedAt": "2024-01-01T00:00:00Z"
    }
  ]
}

// Track Download Request
{
  "lecture_id": "string",
  "status": "started|completed|failed"
}
```

---

## 1️⃣3️⃣ Home Screen Banners APIs (سلايدات الصفحة الرئيسية)

### ❌ مطلوبة:
- `GET /banners` - جلب البانرات/السلايدات

**البيانات المطلوبة:**
```json
// Get Banners Response
{
  "banners": [
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "imageUrl": "string (url)",
      "linkUrl": "string (url to course/post/external link)",
      "type": "course|blog|external",
      "order": 1,
      "isActive": true
    }
  ]
}
```

---

## 📝 ملاحظات مهمة

### Headers مطلوبة في جميع الطلبات:
```
Content-Type: application/json
Accept: application/json
x-api-key: 5551
X-App-Source: future_academy_app
Authorization: Bearer {token} (للطلبات المحمية)
```

### Authentication:
- جميع الـ endpoints التي تبدأ بـ `/panel/` تحتاج authentication token
- يجب إرسال الـ token في الـ Header كـ `Authorization: Bearer {token}`

### Pagination:
- الصفحات التي تدعم pagination تستخدم:
  - `page`: رقم الصفحة (default: 1)
  - `limit`: عدد العناصر في الصفحة (default: 10)

### Error Responses:
جميع الأخطاء يجب أن تكون بالصيغة التالية:
```json
{
  "success": false,
  "message": "رسالة الخطأ بالعربية",
  "errors": {
    "field_name": ["Error message 1", "Error message 2"]
  }
}
```

### Success Responses:
```json
{
  "success": true,
  "message": "رسالة النجاح بالعربية",
  "data": {}
}
```

---

## 🎯 الأولويات

### أولوية عالية (High Priority):
1. **Authentication APIs** - حتى يتمكن المستخدمون من التسجيل والدخول
2. **Courses APIs** - المحتوى الرئيسي للتطبيق
3. **Profile APIs** - لإدارة الحسابات
4. **Blog APIs** - للمحتوى التعليمي

### أولوية متوسطة (Medium Priority):
5. **Quizzes APIs** - للاختبارات والتقييم
6. **College APIs** - محتوى الكلية
7. **Notifications APIs** - للتواصل مع المستخدمين
8. **Cart & Purchases APIs** - لنظام الدفع

### أولوية منخفضة (Low Priority):
9. **Regions APIs** - للمناطق الجغرافية
10. **Downloads Tracking APIs** - لتتبع التحميلات
11. **Banners APIs** - للإعلانات

---

## 🔐 Security Considerations

1. **Rate Limiting**: يُفضل إضافة rate limiting على جميع الـ endpoints
2. **Input Validation**: التحقق من جميع المدخلات
3. **SQL Injection Protection**: استخدام prepared statements
4. **XSS Protection**: تنظيف المحتوى المُدخل من المستخدمين
5. **CORS**: تفعيل CORS بشكل صحيح
6. **HTTPS**: استخدام HTTPS فقط في production

---

## 📱 Special Notes for Mobile App

1. **Images**: يُفضل إرسال صور بأحجام متعددة (thumbnail, medium, large)
2. **Videos**: دعم YouTube URLs و Direct URLs
3. **PDFs**: إرسال direct download links
4. **Offline Support**: الـ app يحتاج caching للمحتوى
5. **Push Notifications**: دعم FCM للإشعارات

---

## 🚀 Next Steps

1. إنشاء الـ API endpoints المذكورة أعلاه
2. إنشاء documentation كامل لكل endpoint
3. إنشاء Postman Collection للتجربة
4. إعداد staging environment للاختبار
5. إعداد production environment

---

## 📑 ملخص سريع - جميع الـ Endpoints المطلوبة

### 🔐 Authentication & User Management (15 endpoint)
```
❌ POST   /forget-password
❌ POST   /reset-password/{token}
❌ POST   /verification
✅ POST   /login
✅ POST   /logout
✅ POST   /register/step/1
✅ POST   /register/step/2
❌ GET    /panel/profile-setting
❌ PUT    /panel/profile-setting
❌ PUT    /panel/profile-setting/password
❌ POST   /panel/profile-setting/images
❌ PUT    /panel/users/fcm
❌ GET    /users/{id}/profile
❌ POST   /users/{id}/send-message
❌ GET    /users/{userId}/notifications
```

### ⚙️ Configuration & Settings (4 endpoints)
```
❌ GET    /config
❌ GET    /config/register/{type}
❌ GET    /regions/countries/code
❌ GET    /currency/list
```

### 📚 Courses & Content (8 endpoints)
```
❌ GET    /courses
❌ GET    /courses/{id}
❌ GET    /courses/{id}/content
❌ GET    /courses/{id}/quizzes
❌ GET    /courses/{id}/certificates
❌ POST   /courses/{id}/report
❌ POST   /courses/{webinarId}/toggle
❌ GET    /search/courses
```

### 📝 Quizzes & Results (3 endpoints)
```
❌ GET    /panel/quizzes/results/my-results
❌ GET    /panel/quizzes/{id}/start
❌ POST   /panel/quizzes/{id}/store-result
```

### 📰 Blog & Posts (2 endpoints)
```
❌ GET    /posts
❌ GET    /posts/{id}
```

### 👥 Providers & Instructors (2 endpoints)
```
❌ GET    /providers/instructors
❌ GET    /providers/organizations
```

### 🌍 Regions (4 endpoints)
```
❌ GET    /regions/countries
❌ GET    /regions/provinces/{countryId}
❌ GET    /regions/cities/{provinceId}
❌ GET    /regions/districts/{cityId}
```

### 🛒 Cart & Purchases (6 endpoints)
```
❌ GET    /panel/cart
❌ POST   /panel/cart/store
❌ DELETE /panel/cart/{itemId}
❌ POST   /panel/cart/coupon/validate
❌ POST   /panel/cart/checkout
❌ GET    /panel/purchases
```

### 🏫 College Section (4 endpoints)
```
❌ GET    /college/recordings
❌ GET    /college/books
❌ GET    /college/schedules
❌ GET    /college/levels
```

### 📥 Downloads (3 endpoints)
```
❌ GET    /panel/downloads
❌ GET    /panel/downloads/my-downloads
❌ POST   /panel/downloads/{lectureId}/track
```

### 🎨 Home & Banners (1 endpoint)
```
❌ GET    /banners
```

### 🔔 Notifications (2 endpoints)
```
❌ PUT    /notifications/{id}/read
❌ DELETE /notifications/{id}
```

---

## 📊 إحصائيات الـ APIs

| الحالة | العدد | النسبة |
|--------|------|---------|
| ✅ **متوفر** | 4 | 7% |
| ❌ **مطلوب** | 50 | 93% |
| **الإجمالي** | **54** | **100%** |

---

## 🎯 قائمة الـ Endpoints بالترتيب (54 endpoint)

### متوفرة حالياً ✅ (4):
1. `POST /login`
2. `POST /logout`
3. `POST /register/step/1`
4. `POST /register/step/2`

### مطلوبة ❌ (50):
5. `POST /forget-password`
6. `POST /reset-password/{token}`
7. `POST /verification`
8. `GET /config`
9. `GET /config/register/{type}`
10. `GET /regions/countries/code`
11. `GET /currency/list`
12. `GET /courses`
13. `GET /courses/{id}`
14. `GET /courses/{id}/content`
15. `GET /courses/{id}/quizzes`
16. `GET /courses/{id}/certificates`
17. `POST /courses/{id}/report`
18. `POST /courses/{webinarId}/toggle`
19. `GET /search/courses`
20. `GET /panel/quizzes/results/my-results`
21. `GET /panel/quizzes/{id}/start`
22. `POST /panel/quizzes/{id}/store-result`
23. `GET /posts`
24. `GET /posts/{id}`
25. `GET /panel/profile-setting`
26. `PUT /panel/profile-setting`
27. `PUT /panel/profile-setting/password`
28. `POST /panel/profile-setting/images`
29. `PUT /panel/users/fcm`
30. `GET /providers/instructors`
31. `GET /providers/organizations`
32. `GET /users/{id}/profile`
33. `POST /users/{id}/send-message`
34. `GET /users/{userId}/notifications`
35. `PUT /notifications/{id}/read`
36. `DELETE /notifications/{id}`
37. `GET /regions/countries`
38. `GET /regions/provinces/{countryId}`
39. `GET /regions/cities/{provinceId}`
40. `GET /regions/districts/{cityId}`
41. `GET /panel/cart`
42. `POST /panel/cart/store`
43. `DELETE /panel/cart/{itemId}`
44. `POST /panel/cart/coupon/validate`
45. `POST /panel/cart/checkout`
46. `GET /panel/purchases`
47. `GET /college/recordings`
48. `GET /college/books`
49. `GET /college/schedules`
50. `GET /college/levels`
51. `GET /panel/downloads`
52. `GET /panel/downloads/my-downloads`
53. `POST /panel/downloads/{lectureId}/track`
54. `GET /banners`

---

## ⚡ Quick Copy List (للنسخ السريع)

```
POST   /forget-password
POST   /reset-password/{token}
POST   /verification
GET    /config
GET    /config/register/{type}
GET    /regions/countries/code
GET    /currency/list
GET    /courses
GET    /courses/{id}
GET    /courses/{id}/content
GET    /courses/{id}/quizzes
GET    /courses/{id}/certificates
POST   /courses/{id}/report
POST   /courses/{webinarId}/toggle
GET    /search/courses
GET    /panel/quizzes/results/my-results
GET    /panel/quizzes/{id}/start
POST   /panel/quizzes/{id}/store-result
GET    /posts
GET    /posts/{id}
GET    /panel/profile-setting
PUT    /panel/profile-setting
PUT    /panel/profile-setting/password
POST   /panel/profile-setting/images
PUT    /panel/users/fcm
GET    /providers/instructors
GET    /providers/organizations
GET    /users/{id}/profile
POST   /users/{id}/send-message
GET    /users/{userId}/notifications
PUT    /notifications/{id}/read
DELETE /notifications/{id}
GET    /regions/countries
GET    /regions/provinces/{countryId}
GET    /regions/cities/{provinceId}
GET    /regions/districts/{cityId}
GET    /panel/cart
POST   /panel/cart/store
DELETE /panel/cart/{itemId}
POST   /panel/cart/coupon/validate
POST   /panel/cart/checkout
GET    /panel/purchases
GET    /college/recordings
GET    /college/books
GET    /college/schedules
GET    /college/levels
GET    /panel/downloads
GET    /panel/downloads/my-downloads
POST   /panel/downloads/{lectureId}/track
GET    /banners
```
