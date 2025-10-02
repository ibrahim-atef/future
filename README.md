# Future App (فيوتشر)

A comprehensive Arabic RTL Flutter application designed for e-learning and content delivery.

## Project Overview

This project is a feature-rich mobile application built with Flutter, targeting both Android and iOS, with web support. It's designed with a focus on a great user experience for Arabic-speaking users, featuring a full Right-to-Left (RTL) interface. The application serves as a platform for online courses, blogs, and other educational content.

### Key Features

*   **Authentication:** Secure user registration and login (email/password), with options for password recovery.
*   **Course Management:** Browse, enroll, and watch video lectures. Supports different video sources like YouTube.
*   **Offline Access:** Download course materials for offline viewing.
*   **User Profile:** View and edit user profile information.
*   **Blog:** Read articles and posts.
*   **Quizzes:** Participate in quizzes and view results.
*   **Notifications:** Receive important updates and announcements.
*   **RTL Support:** Fully optimized for Arabic language and right-to-left layout.

## Project Structure

The project follows a clean and organized structure:

```
lib/
├── core/
│   ├── constants/      # Application constants
│   ├── models/         # Data models
│   ├── routes/         # Navigation routes
│   ├── services/       # API, storage, and other services
│   └── theme/          # App theme, colors, and typography
├── providers/          # State management providers
├── screens/            # UI screens for different features
└── widgets/            # Reusable UI components
```

## How to Use

### Prerequisites
*   Flutter SDK installed.
*   An editor like VS Code or Android Studio.
*   A configured emulator or a physical device.

### Running the Application
1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd future
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

## Package Details and Usage

Here is a more detailed look at the key packages used in this project:

### State Management

*   **`provider`**: A dependency injection and state management solution.
    *   **Usage**: The app uses `MultiProvider` in `main.dart` to make state objects like `AuthProvider` and `CourseProvider` available throughout the widget tree. Widgets can then listen to changes in these providers and automatically update.
    *   **Example**:
        ```dart
        // Accessing the AuthProvider in a widget
        var authProvider = Provider.of<AuthProvider>(context);

        // Building UI based on login state
        if (authProvider.isLoggedIn) {
          return ProfileScreen();
        } else {
          return LoginScreen();
        }
        ```

### Backend & Networking

*   **`dio`**: A powerful HTTP client for making requests to the backend API.
    *   **Usage**: The `ApiService` class is built around `dio`. It configures a `dio` instance with a base URL, headers, and interceptors to automatically add the authentication token to requests and handle errors.
    *   **Example** (from `ApiService`):
        ```dart
        Future<ApiResponse<List<CourseModel>>> getCourses() async {
          try {
            final response = await _dio.get('/courses');
            // ... parsing logic
          } on DioException catch (e) {
            // ... error handling
          }
        }
        ```

### UI & UX

*   **`carousel_slider`**: Creates beautiful and customizable carousel sliders.
    *   **Usage**: Likely used on the `HomeScreen` to showcase featured courses or blog posts in an interactive, sliding hero section.
    *   **Example**:
        ```dart
        CarouselSlider(
          options: CarouselOptions(autoPlay: true, aspectRatio: 16/9),
          items: featuredItems.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(item.imageUrl, fit: BoxFit.cover);
              },
            );
          }).toList(),
        )
        ```

*   **`cached_network_image`**: Displays images from the internet and caches them.
    *   **Usage**: Used everywhere an image is loaded from a URL (e.g., user avatars, course thumbnails). This improves performance by avoiding re-downloading images and provides placeholder/error widgets.
    *   **Example**:
        ```dart
        CachedNetworkImage(
          imageUrl: course.thumbnailUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        ```

*   **`video_player` & `youtube_player_flutter`**: For video playback.
    *   **Usage**: The `LecturePlayerScreen` uses these to play course videos. It can dynamically choose the right player based on whether the video URL is a direct link or a YouTube link.
    *   **Example** (youtube_player_flutter):
        ```dart
        YoutubePlayerController _controller = YoutubePlayerController(
            initialVideoId: 'YOUR_VIDEO_ID',
            flags: YoutubePlayerFlags(autoPlay: true),
        );
        YoutubePlayer(controller: _controller);
        ```

### Local Storage & Downloads

*   **`hive` / `hive_flutter`**: A fast, lightweight key-value database.
    *   **Usage**: Initialized in `main.dart` and used by `StorageService` to persist critical data like the user's authentication token, ensuring they stay logged in between sessions.
    *   **Example** (`StorageService`):
        ```dart
        static Future<void> saveToken(String token) async {
          var box = await Hive.openBox('auth');
          await box.put('token', token);
        }
        ```

*   **`flutter_downloader`**, **`path_provider`**, **`permission_handler`**: A trio for managing file downloads.
    *   **Usage**: The "Downloads" feature relies on these. `permission_handler` requests storage access, `path_provider` finds a suitable directory, and `flutter_downloader` manages the download task in the background, even when the app is closed.

### Utilities

*   **`url_launcher`**: Launches URLs to be handled by the operating system.
    *   **Usage**: Used in the `HomeScreen` to open WhatsApp support chats via `https://wa.me/...` links. It can also open web pages or other custom URL schemes.
    *   **Example**:
        ```dart
        final Uri url = Uri.parse('https://wa.me/201234567890');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
        ```

*   **`share_plus`**: Opens the native platform share dialog.
    *   **Usage**: Allows users to easily share a link to a course or blog post with other apps like WhatsApp, Twitter, or email.
    *   **Example**:
        ```dart
        Share.share('Check out this amazing course! https://futureapp.com/courses/123');
        ```
