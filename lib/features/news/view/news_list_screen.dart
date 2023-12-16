import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/features/news/controller/news_list_controller.dart';
import 'package:news_app_task/features/news/view/widgets/tab_item1.dart';
import 'package:news_app_task/features/news/view/widgets/tab_item2.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late final NewsListController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NewsListController());

    // in order to refresh the data
    controller.tabController.addListener(() {
      if (controller.tabController.index == 0) {
        controller.fetchNewsList();
      } else {
        controller.fetchTechNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('News App'),
        bottom: TabBar(
          controller: controller.tabController,
          tabs: const [
            Tab(text: 'Business News'),
            Tab(text: 'TechCrunch News'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: controller.tabController,
          children: const [
            TabItem1(),
            TabItem2(),
          ],
        ),
      ),
    );
  }
}
