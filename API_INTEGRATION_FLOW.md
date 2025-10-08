# 🔄 دليل ربط API مع UI - Future App

## 📐 البنية المعمارية

```
Feature/
├── data/
│   ├── models/
│   │   ├── {endpoint}_request_model.dart
│   │   └── {endpoint}_response_model.dart
│   └── repos/
│       └── {endpoint}_repo.dart
├── logic/
│   └── cubit/
│       ├── {endpoint}_cubit.dart
│       ├── {endpoint}_state.dart
│       └── {endpoint}_state.freezed.dart
└── presentation/
    ├── screens/
    │   └── {feature}_screen.dart
    └── widgets/
        └── {custom_widgets}.dart
```

---

## 🎯 الخطوات التفصيلية (Step by Step)

### مثال عملي: Blog Posts API

سنقوم بإنشاء feature كامل لعرض قائمة المقالات (Blog Posts)

---

## 📝 Step 1: إضافة Endpoint في API Constants

**المسار**: `lib/core/network/api_constants.dart`

```dart
class ApiConstants {
  static const int apiKey = 5551;
  static const String apiBaseUrl = "https://future-academy-courses.com/api/development/";
  
  // Auth endpoints
  static const String login = "login";
  static const String logout = "logout";
  static const String registerStep1 = "register/step/1";
  static const String registerStep2 = "register/step/2";
  
  // 👇 إضافة endpoint جديد
  static const String getPosts = "posts";
  static const String getPostDetail = "posts"; // posts/{id}
}
```

**الـ Endpoint المطلوب**:
```
GET /posts
GET /posts/{id}
```

---

## 📦 Step 2: إنشاء Models (Request & Response)

### 2.1 - Response Model

**المسار**: `lib/features/blog/data/models/get_posts_response_model.dart`

```dart
import 'package:json_annotation/json_annotation.dart';

part 'get_posts_response_model.g.dart';

@JsonSerializable()
class GetPostsResponseModel {
  final bool success;
  final String? message;
  final List<PostData>? posts;

  GetPostsResponseModel({
    required this.success,
    this.message,
    this.posts,
  });

  factory GetPostsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostsResponseModelToJson(this);
}

@JsonSerializable()
class PostData {
  final String id;
  final String title;
  final String content;
  final String excerpt;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  final String author;
  final List<String>? tags;
  @JsonKey(name: 'viewsCount')
  final int viewsCount;
  @JsonKey(name: 'publishedAt')
  final String publishedAt;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  PostData({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    this.imageUrl,
    required this.author,
    this.tags,
    required this.viewsCount,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}
```

### 2.2 - Request Model (لو فيه parameters)

**المسار**: `lib/features/blog/data/models/get_post_detail_request_model.dart`

```dart
import 'package:json_annotation/json_annotation.dart';

part 'get_post_detail_request_model.g.dart';

@JsonSerializable()
class GetPostDetailRequestModel {
  @JsonKey(name: 'post_id')
  final String postId;

  GetPostDetailRequestModel({
    required this.postId,
  });

  factory GetPostDetailRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostDetailRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostDetailRequestModelToJson(this);
}
```

### 2.3 - Generate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🔌 Step 3: إضافة Service في API Service

**المسار**: `lib/core/network/api_service.dart`

```dart
import 'package:dio/dio.dart';
import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/features/blog/data/models/get_posts_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  // Auth endpoints (موجودين مسبقاً)
  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(
    @Body() LoginRequestModel request,
    @Header('x-api-key') int apiKey,
  );

  // 👇 إضافة Blog endpoints
  @GET(ApiConstants.getPosts)
  Future<GetPostsResponseModel> getPosts(
    @Header('x-api-key') int apiKey,
    @Queries() Map<String, dynamic>? queries, // للـ pagination
  );

  @GET("${ApiConstants.getPostDetail}/{id}")
  Future<GetPostsResponseModel> getPostDetail(
    @Path('id') String postId,
    @Header('x-api-key') int apiKey,
  );
}
```

### ثم Generate الكود:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 📚 Step 4: إنشاء Repository

**المسار**: `lib/features/blog/data/repos/blog_repo.dart`

```dart
import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_result.dart';
import 'package:future_app/core/network/api_service.dart';
import 'package:future_app/features/blog/data/models/get_posts_response_model.dart';
import 'dart:developer';

class BlogRepo {
  final ApiService _apiService;
  
  BlogRepo(this._apiService);

  // Get all posts
  Future<ApiResult<GetPostsResponseModel>> getPosts({
    int? page,
    int? limit,
  }) async {
    try {
      final queries = <String, dynamic>{};
      if (page != null) queries['page'] = page;
      if (limit != null) queries['limit'] = limit;

      final response = await _apiService.getPosts(
        ApiConstants.apiKey,
        queries.isEmpty ? null : queries,
      );
      
      return ApiResult.success(response);
    } catch (e) {
      log('Error in getPosts: $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // Get single post
  Future<ApiResult<GetPostsResponseModel>> getPostDetail(String postId) async {
    try {
      final response = await _apiService.getPostDetail(
        postId,
        ApiConstants.apiKey,
      );
      
      return ApiResult.success(response);
    } catch (e) {
      log('Error in getPostDetail: $e');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
```

---

## 🎛️ Step 5: إنشاء Cubit & States

### 5.1 - States

**المسار**: `lib/features/blog/logic/cubit/blog_state.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/blog/data/models/get_posts_response_model.dart';

part 'blog_state.freezed.dart';

@freezed
class BlogState with _$BlogState {
  const factory BlogState.initial() = _Initial;
  
  // Get Posts States
  const factory BlogState.postsLoading() = PostsLoading;
  const factory BlogState.postsSuccess(GetPostsResponseModel response) = PostsSuccess;
  const factory BlogState.postsError(ApiErrorModel error) = PostsError;
  
  // Get Post Detail States
  const factory BlogState.postDetailLoading() = PostDetailLoading;
  const factory BlogState.postDetailSuccess(GetPostsResponseModel response) = PostDetailSuccess;
  const factory BlogState.postDetailError(ApiErrorModel error) = PostDetailError;
}
```

### 5.2 - Cubit

**المسار**: `lib/features/blog/logic/cubit/blog_cubit.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/blog/data/repos/blog_repo.dart';
import 'package:future_app/features/blog/logic/cubit/blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final BlogRepo _blogRepo;
  
  BlogCubit(this._blogRepo) : super(const BlogState.initial());

  // Get all posts
  Future<void> getPosts({int? page, int? limit}) async {
    emit(const BlogState.postsLoading());
    
    final result = await _blogRepo.getPosts(page: page, limit: limit);
    
    result.when(
      success: (response) {
        emit(BlogState.postsSuccess(response));
      },
      failure: (error) {
        emit(BlogState.postsError(error));
      },
    );
  }

  // Get single post
  Future<void> getPostDetail(String postId) async {
    emit(const BlogState.postDetailLoading());
    
    final result = await _blogRepo.getPostDetail(postId);
    
    result.when(
      success: (response) {
        emit(BlogState.postDetailSuccess(response));
      },
      failure: (error) {
        emit(BlogState.postDetailError(error));
      },
    );
  }
}
```

### 5.3 - Generate Freezed Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🔧 Step 6: تسجيل في Dependency Injection

**المسار**: `lib/core/di/di.dart`

```dart
import 'package:dio/dio.dart';
import 'package:future_app/core/network/api_service.dart';
import 'package:future_app/core/network/dio_factory.dart';
import 'package:future_app/features/auth/data/repos/auth_repo.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/features/blog/data/repos/blog_repo.dart';
import 'package:future_app/features/blog/logic/cubit/blog_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Auth Feature
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  // 👇 Blog Feature
  getIt.registerLazySingleton<BlogRepo>(() => BlogRepo(getIt()));
  getIt.registerFactory<BlogCubit>(() => BlogCubit(getIt()));
}
```

---

## 🎨 Step 7: ربط Cubit مع UI

### 7.1 - إضافة BlocProvider في main.dart

**المسار**: `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/features/blog/logic/cubit/blog_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await setupGetIt();
  
  runApp(const FutureApp());
}

class FutureApp extends StatelessWidget {
  const FutureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        // 👇 إضافة BlogCubit
        BlocProvider(create: (_) => getIt<BlogCubit>()),
      ],
      child: MaterialApp(
        // ... rest of app config
      ),
    );
  }
}
```

### 7.2 - استخدام Cubit في Screen

**المسار**: `lib/features/blog/presentation/screens/blog_list_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/blog/logic/cubit/blog_cubit.dart';
import 'package:future_app/features/blog/logic/cubit/blog_state.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  @override
  void initState() {
    super.initState();
    // 👇 استدعاء API عند فتح الشاشة
    context.read<BlogCubit>().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المدونة')),
      body: BlocBuilder<BlogCubit, BlogState>(
        buildWhen: (previous, current) =>
            current is PostsLoading ||
            current is PostsSuccess ||
            current is PostsError,
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            
            // 👇 حالة التحميل
            postsLoading: () => const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFd4af37),
              ),
            ),
            
            // 👇 حالة النجاح
            postsSuccess: (response) {
              if (response.posts == null || response.posts!.isEmpty) {
                return const Center(
                  child: Text('لا توجد مقالات'),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: response.posts!.length,
                itemBuilder: (context, index) {
                  final post = response.posts![index];
                  return _buildPostCard(post);
                },
              );
            },
            
            // 👇 حالة الخطأ
            postsError: (error) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    error.message ?? 'حدث خطأ',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BlogCubit>().getPosts();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
            
            // Other states
            postDetailLoading: () => const SizedBox.shrink(),
            postDetailSuccess: (_) => const SizedBox.shrink(),
            postDetailError: (_) => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildPostCard(PostData post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: post.imageUrl != null
            ? Image.network(
                post.imageUrl!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.article),
        title: Text(post.title),
        subtitle: Text(
          post.excerpt,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detail screen
          context.read<BlogCubit>().getPostDetail(post.id);
        },
      ),
    );
  }
}
```

### 7.3 - استخدام BlocListener للتفاعل مع الأحداث

```dart
BlocListener<BlogCubit, BlogState>(
  listenWhen: (previous, current) =>
      current is PostsSuccess ||
      current is PostsError,
  listener: (context, state) {
    state.whenOrNull(
      postsSuccess: (response) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تحميل المقالات بنجاح'),
            backgroundColor: Color(0xFFd4af37),
          ),
        );
      },
      postsError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'حدث خطأ'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  },
  child: BlocBuilder<BlogCubit, BlogState>(
    builder: (context, state) {
      // Your UI here
    },
  ),
)
```

---

## 🗂️ Step 8: نقل الـ Feature للمكان الصحيح

### الهيكل النهائي:

```
lib/
├── features/
│   ├── auth/                    ✅ موجود
│   │   ├── data/
│   │   ├── logic/
│   │   └── presentation/
│   │
│   └── blog/                    👈 Feature جديد
│       ├── data/
│       │   ├── models/
│       │   │   ├── get_posts_response_model.dart
│       │   │   ├── get_posts_response_model.g.dart
│       │   │   ├── get_post_detail_request_model.dart
│       │   │   └── get_post_detail_request_model.g.dart
│       │   └── repos/
│       │       └── blog_repo.dart
│       │
│       ├── logic/
│       │   └── cubit/
│       │       ├── blog_cubit.dart
│       │       ├── blog_state.dart
│       │       └── blog_state.freezed.dart
│       │
│       └── presentation/
│           ├── screens/
│           │   ├── blog_list_screen.dart
│           │   └── blog_detail_screen.dart
│           └── widgets/
│               ├── blog_card_widget.dart
│               └── blog_shimmer_widget.dart
```

---

## 📋 Checklist للتأكد من كل شيء

### ✅ Step 1: API Constants
- [ ] أضفت الـ endpoint في `api_constants.dart`
- [ ] تأكدت من اسم الـ endpoint صحيح

### ✅ Step 2: Models
- [ ] عملت Request Model (لو محتاج)
- [ ] عملت Response Model
- [ ] استخدمت `@JsonSerializable()`
- [ ] رانت `build_runner`
- [ ] الـ `.g.dart` files اتعملت

### ✅ Step 3: API Service
- [ ] أضفت الـ method في `api_service.dart`
- [ ] استخدمت الـ decorator الصحيح (`@GET`, `@POST`, etc.)
- [ ] أضفت `x-api-key` header
- [ ] رانت `build_runner`

### ✅ Step 4: Repository
- [ ] عملت الـ repo file
- [ ] استخدمت `ApiResult<T>` للـ response
- [ ] عملت try-catch handling
- [ ] استخدمت `ApiErrorHandler.handle()`

### ✅ Step 5: Cubit & States
- [ ] عملت States باستخدام `freezed`
- [ ] عملت الـ Cubit
- [ ] كل method بتعمل emit للـ states الصحيحة
- [ ] رانت `build_runner`

### ✅ Step 6: Dependency Injection
- [ ] سجلت الـ Repo في `di.dart`
- [ ] سجلت الـ Cubit في `di.dart`
- [ ] استخدمت `registerLazySingleton` للـ Repo
- [ ] استخدمت `registerFactory` للـ Cubit

### ✅ Step 7: UI Connection
- [ ] أضفت `BlocProvider` في `main.dart`
- [ ] استخدمت `BlocBuilder` في الـ Screen
- [ ] عملت handling للـ states المختلفة
- [ ] أضفت `BlocListener` (لو محتاج)

### ✅ Step 8: Organization
- [ ] الـ feature في `lib/features/`
- [ ] الهيكل منظم: data, logic, presentation
- [ ] الملفات في المكان الصحيح

---

## 🎯 مثال سريع لـ API تاني: Get Courses

### 1. API Constant
```dart
static const String getCourses = "courses";
```

### 2. Models
```dart
// get_courses_response_model.dart
@JsonSerializable()
class GetCoursesResponseModel {
  final List<CourseData>? data;
  // ...
}
```

### 3. API Service
```dart
@GET(ApiConstants.getCourses)
Future<GetCoursesResponseModel> getCourses(
  @Header('x-api-key') int apiKey,
  @Queries() Map<String, dynamic>? queries,
);
```

### 4. Repo
```dart
class CourseRepo {
  Future<ApiResult<GetCoursesResponseModel>> getCourses() async {
    // implementation
  }
}
```

### 5. Cubit
```dart
class CourseCubit extends Cubit<CourseState> {
  void getCourses() async {
    // implementation
  }
}
```

### 6. DI
```dart
getIt.registerLazySingleton<CourseRepo>(() => CourseRepo(getIt()));
getIt.registerFactory<CourseCubit>(() => CourseCubit(getIt()));
```

### 7. UI
```dart
BlocProvider(create: (_) => getIt<CourseCubit>()),
```

---

## 🚀 Commands للتشغيل

```bash
# 1. Generate code بعد كل تعديل على Models/API Service
flutter pub run build_runner build --delete-conflicting-outputs

# 2. لو عاوز watch mode (auto-generate)
flutter pub run build_runner watch --delete-conflicting-outputs

# 3. Clean و Re-generate
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 💡 Tips & Best Practices

### 1. **Naming Convention**
```
✅ Good:
- get_posts_response_model.dart
- blog_cubit.dart
- blog_state.dart

❌ Bad:
- postsResponse.dart
- blogCubit.dart
- BlogState.dart
```

### 2. **Error Handling**
```dart
// ✅ Always use try-catch in repo
try {
  final response = await _apiService.getPosts();
  return ApiResult.success(response);
} catch (e) {
  log('Error: $e');
  return ApiResult.failure(ApiErrorHandler.handle(e));
}
```

### 3. **Loading States**
```dart
// ✅ Emit loading before API call
emit(const BlogState.postsLoading());
final result = await _blogRepo.getPosts();
```

### 4. **BlocBuilder vs BlocListener**
```dart
// BlocBuilder: للـ UI changes
BlocBuilder<BlogCubit, BlogState>(...)

// BlocListener: للـ Side effects (SnackBar, Navigation)
BlocListener<BlogCubit, BlogState>(...)

// Both: BlocConsumer
BlocConsumer<BlogCubit, BlogState>(...)
```

---

## 🔄 الـ Flow الكامل (Summary)

```
User Action (Button Click)
    ↓
UI calls → context.read<BlogCubit>().getPosts()
    ↓
Cubit → emit(Loading) → calls BlogRepo.getPosts()
    ↓
Repo → calls ApiService.getPosts()
    ↓
ApiService → makes HTTP request to Backend
    ↓
Backend → returns JSON response
    ↓
ApiService → converts JSON to GetPostsResponseModel
    ↓
Repo → wraps in ApiResult.success() or .failure()
    ↓
Cubit → receives result → emit(Success/Error)
    ↓
UI (BlocBuilder) → rebuilds based on new state
    ↓
User sees the result!
```

---

## 📞 الخلاصة

هذا الـ Flow يضمن:
- ✅ Clean Code
- ✅ Separation of Concerns
- ✅ Easy Testing
- ✅ Scalable Architecture
- ✅ Type Safety

**تابع هذه الخطوات لكل API جديد!** 🎯

---

**تاريخ الإنشاء**: October 7, 2025  
**الإصدار**: 1.0  
**المؤلف**: AI Assistant

