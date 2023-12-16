import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsDetailsScreen extends StatelessWidget {
  String? headline, author, content, url;
  NewsDetailsScreen({this.headline, this.author, this.content, this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(headline.toString(), style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10.0),
                const Text('Josh Starkey'),
                const SizedBox(height: 10.0),
                Container(
                  width: Get.width,
                  height: Get.height * .4,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(18.0), topLeft: Radius.circular(18.0)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: url != null
                          ? NetworkImage(url.toString())
                          : const NetworkImage('https://via.placeholder.com/300x200.png?text=No+Image+Found'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: content != null
                      ? Text(content.toString(), style: Theme.of(context).textTheme.bodyLarge)
                      : const Center(child: Text('No data found')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
