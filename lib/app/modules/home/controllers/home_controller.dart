import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../network/api_service.dart';
import '../models/repo_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;

  late ApiService _apiService;
  RxList<RepoModel> repoDataList =
      <RepoModel>[].obs; // RxList is used to update the list

  @override
  void onInit() {
    // onInit is called when the controller is initialized
    _apiService = ApiService(); // ApiService is used to make the API call
    getData(); // getData is used to fetch the data from the API
    super.onInit();
  }

  Future<List<RepoModel>> getData() async {
    // getData is used to fetch the data from the API
    isLoading(true);
    var res = await _apiService
        .getCall("https://api.github.com/repos/facebook/react/issues"); // API call 
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
        refresh(); // refresh is used to update the list
        repoDataList.refresh();
      }
      isLoading(false);
      return repoDataList;
    } else {
      Get.snackbar("Error",
          response.body.toString()); // show a snackbar if the API call fails
      isLoading(false);
      return repoDataList;
    }
  }

  String openedAt(String date) { // This function is used to show the time difference between the current time and the time when the issue was created
    if (DateTime.now().difference(DateTime.parse(date)).inDays < 1) {
      return "${DateTime.now().difference(DateTime.parse(date)).inHours} hours ago";
    } else {
      return "${DateTime.now().difference(DateTime.parse(date)).inDays} days ago";
    }
  }
}
