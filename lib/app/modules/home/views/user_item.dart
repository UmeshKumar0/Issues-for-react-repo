import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../models/repo_model.dart';

class UserItem extends StatefulWidget {
  UserItem({
    super.key,
    required this.user,
  });
  RepoModel user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool showPassword = false;
  final dashboardController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        InkWell(
          onTap: () => FlutterWebBrowser.openWebPage(
            url: widget.user.url ?? "",
          ),
          onLongPress: () {
            Get.generalDialog(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("Back"),
                        ),
                      ],
                      contentPadding:
                          const EdgeInsets.only(left: 25, right: 25),
                      title: Center(child: Text(widget.user.title ?? "")),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      content: SizedBox(
                        height: 200,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              Text(widget.user.body ?? ""),
                            ],
                          ),
                        ),
                      ),
                    ));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.user.labels?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(int.parse(
                                "0xff${widget.user.labels?[index].color}" ??
                                    "000000 ")),
                          ),
                          child: Text(widget.user.labels?[index].name ?? ""),
                        ),
                      );
                    },
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(widget.user.labels[0].description ?? " "),
                // ),
                const SizedBox(
                  height: 5,
                ),

                Text(widget.user.title.toString(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                    "#${widget.user.number} opened ${dashboardController.openedAt(widget.user.createdAt ?? "")} by ${widget.user.user?.login}",
                    style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        )
      ],
    );
  }
}

openBrowserTab(String url) async {
  await FlutterWebBrowser.openWebPage(
    url: url,
  );
}
