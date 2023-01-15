import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'user_item.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text(
          'Issues for react repo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(child: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                color: Colors.grey,
                //  RefreshIndicator is used to refresh the list
                onRefresh: () => controller.getData(),
                child: GetBuilder<HomeController>(
                  // GetBuilder is used to update the list
                  builder: (controller) => ListView.builder(
                    itemCount: controller
                        .repoDataList.length, // Get the length of the list
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.green,
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: UserItem(
                            // Created a new widget for the list item
                            user: controller.repoDataList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
      })),
    );
  }
}
