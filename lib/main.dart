import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/features/news/view/news_list_screen.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent),
      ),
      home: const NewsListScreen(),
    );
  }
}
