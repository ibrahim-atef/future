class ApiConstants {
  static const int apiKey = 5551;
  static const String appSource = "future_academy_app";
  static const String apiBaseUrl =
      "https://future-team-law.com/wp-json/tutor-api/v1/";
  static const String login = "login";
  static const String logout = "logout";
  static const String registerStep1 = "register";
  static const String registerStep2 = "register/step/2";
  static const String banners = "banners";
  static const String courses = "courses";
  static const String posts = "posts";

  // Get single course by ID
  static String getSingleCourse(String id) => "courses/$id";

  // Notifications endpoints
  static String getUserNotifications(String userId) =>
      "users/$userId/notifications";
  static String markNotificationAsRead(String notificationId) =>
      "notifications/$notificationId/read";
  static String deleteNotification(String notificationId) =>
      "notifications/$notificationId";

  // Blog/Posts endpoints
  static String getPostDetails(String postId) => "posts/$postId";
}
