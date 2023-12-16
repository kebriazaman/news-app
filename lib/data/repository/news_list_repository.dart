import 'package:news_app_task/data/services/network_api_services.dart';
import 'package:news_app_task/utils/app_urls/app_urls.dart';

import '../../features/news/model/news_list_model.dart';

class NewsListRepository {
  NetworkApiServices networkApiServices = NetworkApiServices();
  Future<NewsListModel> getNews() async {
    final response = await networkApiServices.getApi(AppUrls.newsApi);
    return NewsListModel.fromJson(response);
  }

  Future<NewsListModel> getTechNews() async {
    final response = await networkApiServices.getApi(AppUrls.techNewsApi);
    return NewsListModel.fromJson(response);
  }
}
