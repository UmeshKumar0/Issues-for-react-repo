import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../network/api_service.dart';
import '../models/repo_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;

  late ApiService _apiService;
  RxList<RepoModel> repoDataList = <RepoModel>[].obs;

  @override
  void onInit() {
    _apiService = ApiService();
    getData();
    super.onInit();
  }

  Future<List<RepoModel>> getData() async {
    isLoading(true);
    var res = await _apiService
        .getCall("https://api.github.com/repos/facebook/react/issues");
    var response = res;

    if (!response.status.hasError) {
      repoDataList.clear();
      Get.snackbar('Data Fetched Successfully', '',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1));
      if (response.body.length > 0) {
        response.body.forEach((e) {
          repoDataList.add(RepoModel.fromJson(e));
        });
        refresh();
        repoDataList.refresh();
      }
      isLoading(false);
      return repoDataList;
    } else {
      Get.snackbar("Error", response.body.toString());
      isLoading(false);
      throw Exception("Failed to load data");
    }
  }

  String openedAt(String date) {
    if (DateTime.now().difference(DateTime.parse(date)).inDays < 1) {
      return DateTime.now()
              .difference(DateTime.parse(date))
              .inHours
              .toString() +
          " hours ago";
    } else {
      return DateTime.now().difference(DateTime.parse(date)).inDays.toString() +
          " days ago";
    }
  }
}
