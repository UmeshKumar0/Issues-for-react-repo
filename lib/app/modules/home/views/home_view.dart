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
        title: const Text('Issues for react repo'),
        centerTitle: true,
      ),
      body: Center(child: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => controller.getData(),
                child: GetBuilder<HomeController>(
                  builder: (controller) => ListView.builder(
                    itemCount: controller.repoDataList.length,
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
