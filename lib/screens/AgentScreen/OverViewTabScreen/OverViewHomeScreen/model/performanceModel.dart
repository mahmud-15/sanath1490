class PerformanceModel {
  final String totalViews;
  final String newEnquiries;

  const PerformanceModel({
    required this.totalViews,
    required this.newEnquiries,
  });
}

class EnquiryModel {
  final String name;
  final String subtitle;
  final String timeAgo;
  final bool isNew;

  const EnquiryModel({
    required this.name,
    required this.subtitle,
    required this.timeAgo,
    required this.isNew,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }
}