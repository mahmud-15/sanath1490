import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';

class InfoRepository {
  InfoRepository._privateConstructor();
  static final InfoRepository _instance = InfoRepository._privateConstructor();
  static InfoRepository get instance => _instance;

  final _api = ApiServices.instance;

  Future<String?> fetchAbout() async {
    final res = await _api.getServices(AppApiUrl.instance.about);
    if (res == null) return null;
    return res['data']?['content'] as String?;
  }

  Future<String?> fetchPrivacy() async {
    final res = await _api.getServices(AppApiUrl.instance.privacy);
    if (res == null) return null;
    return res['data']?['content'] as String?;
  }

  Future<String?> fetchTerms() async {
    final res = await _api.getServices(AppApiUrl.instance.terms);
    if (res == null) return null;
    return res['data']?['content'] as String?;
  }

  Future<List<FaqItemModel>?> fetchFaqs() async {
    final res = await _api.getServices(AppApiUrl.instance.faqs);
    if (res == null) return null;
    final list = res['data'] as List<dynamic>?;
    return list?.map((e) => FaqItemModel.fromJson(e)).toList();
  }
}

class FaqItemModel {
  final String id;
  final String question;
  final String answer;

  FaqItemModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqItemModel.fromJson(Map<String, dynamic> json) => FaqItemModel(
    id: json['_id'] ?? '',
    question: json['question'] ?? '',
    answer: json['answer'] ?? '',
  );
}