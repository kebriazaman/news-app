import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app_task/features/news/view/news_details_screen.dart';

import '../../controller/news_list_controller.dart';

class TabItem1 extends StatelessWidget {
  const TabItem1({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsListController controller = Get.find<NewsListController>();
    return Obx(
      () => controller.isLoading1.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.noOfItems.value,
                itemBuilder: (context, index) {
                  int newsId = index;
                  DateTime? dateTime =
                      DateTime.parse(controller.newsList.value.articles![index].publishedAt.toString());
                  String yearMonth = DateFormat('yyyy-MM-dd').format(dateTime);
                  return FutureBuilder(
                    future: controller.isNewsSeen('seen_articles1', newsId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        bool isSeen = snapshot.data ?? false;
                        return InkWell(
                          onTap: isSeen
                              ? null
                              : () {
                                  // controller.emptyTable('seen_articles1');
                                  controller.markAsSeen('seen_articles1', newsId.toString());
                                  Get.to(() => NewsDetailsScreen(
                                        headline: controller.newsList.value.articles![index].title,
                                        author: controller.newsList.value.articles![index].author,
                                        url: controller.newsList.value.articles![index].urlToImage,
                                        content: controller.newsList.value.articles![index].content,
                                      ));
                                },
                          child: Card(
                            color: isSeen ? Colors.grey.shade300 : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * 0.2,
                                    height: Get.height * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: controller.newsList.value.articles![index].urlToImage != null
                                            ? NetworkImage(
                                                controller.newsList.value.articles![index].urlToImage.toString())
                                            : const NetworkImage(
                                                'https://via.placeholder.com/300x200.png?text=No+Image+Found'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.newsList.value.articles![index].title.toString(),
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                          maxLines: 4,
                                        ),
                                        SizedBox(height: Get.height * 0.05),
                                        Text(yearMonth),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
    );
  }
}
