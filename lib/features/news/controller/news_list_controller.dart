import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/data/repository/news_list_repository.dart';
import 'package:news_app_task/features/news/model/news_list_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NewsListController extends GetxController with GetSingleTickerProviderStateMixin {
  final RxBool _isLoading1 = false.obs;
  final RxBool _isLoading2 = false.obs;

  final RxInt noOfItems = 10.obs;

  final _newsList = NewsListModel().obs;
  final _techNewsList = NewsListModel().obs;

  final _apiServices = NewsListRepository();
  late Database _database;

  late TabController tabController;

  RxBool get isLoading1 => _isLoading1;
  RxBool get isLoading2 => _isLoading2;

  Rx<NewsListModel> get newsList => _newsList;
  Rx<NewsListModel> get techNewsList => _techNewsList;

  void setLoading1(bool value) => _isLoading1.value = value;
  void setLoading2(bool value) => _isLoading2.value = value;

  void setNewsList(NewsListModel newsListModel) => _newsList.value = newsListModel;
  void setTechNewsList(NewsListModel newsListModel) => _techNewsList.value = newsListModel;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    fetchNewsList();
    fetchTechNews();
    initDatabase();
    super.onInit();
  }

  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), 'news_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE seen_articles1 (id INTEGER PRIMARY KEY, news_id TEXT)''').then((value) {
          print('Created');
        }).onError((error, stackTrace) {
          print(error);
        });
        await db.execute('''CREATE TABLE seen_articles2 (id INTEGER PRIMARY KEY, news_id TEXT)''');
      },
    );
  }

  Future<void> markAsSeen(String tableName, String newsId) async {
    await _database.insert(tableName, {'news_id': newsId});

    // refresing the list in order to mark the news item as seen
    noOfItems.refresh();
  }

  Future<bool> isNewsSeen(String tableName, int newsId) async {
    List<Map<String, dynamic>> result = await _database.query(
      tableName,
      where: 'news_id = ?',
      whereArgs: [newsId],
    );
    return result.isNotEmpty;
  }

  void fetchNewsList() {
    setLoading1(true);
    _apiServices.getNews().then((value) async {
      setNewsList(value);
      setLoading1(false);
    }).onError((error, stackTrace) {
      setLoading1(false);
    });
  }

  void fetchTechNews() {
    setLoading2(true);
    _apiServices.getTechNews().then((value) async {
      setTechNewsList(value);
      setLoading2(false);
    }).onError((error, stackTrace) {
      setLoading2(false);
    });
  }
}
