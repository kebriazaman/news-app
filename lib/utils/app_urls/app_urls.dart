import 'package:news_app_task/utils/constants/app_constants.dart';

class AppUrls {
  AppUrls._();
  static const String baseUrl = 'https://newsapi.org';
  static const String newsApi = '$baseUrl/v2/top-headlines?country=us&category=business&apiKey=${AppConstants.apiKey}';
  static const String techNewsApi = '$baseUrl/v2/top-headlines?sources=techcrunch&apiKey=${AppConstants.apiKey}';
}
