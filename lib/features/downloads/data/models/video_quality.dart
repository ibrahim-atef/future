// Video quality options for downloads
enum VideoQuality {
  low, // Small file size, lower quality
  medium, // Balanced size and quality
  high, // Larger file size, higher quality
  original // Original quality from server
}

// Quality data model
class QualityData {
  final String url;
  final int fileSize;
  final double fileSizeMb;
  final String qualityLabel;

  const QualityData({
    required this.url,
    required this.fileSize,
    required this.fileSizeMb,
    required this.qualityLabel,
  });
}

// Extension to get quality display name
extension VideoQualityExtension on VideoQuality {
  String get displayName {
    switch (this) {
      case VideoQuality.low:
        return 'جودة منخفضة';
      case VideoQuality.medium:
        return 'جودة متوسطة';
      case VideoQuality.high:
        return 'جودة عالية';
      case VideoQuality.original:
        return 'الجودة الأصلية';
    }
  }

  String get description {
    switch (this) {
      case VideoQuality.low:
        return 'حجم صغير - توفير 60% من المساحة';
      case VideoQuality.medium:
        return 'حجم متوازن - توفير 30% من المساحة';
      case VideoQuality.high:
        return 'جودة عالية - توفير 10% من المساحة';
      case VideoQuality.original:
        return 'الجودة الأصلية - بدون توفير مساحة';
    }
  }
}
