import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text.utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutWidget extends StatelessWidget {
  LogOutWidget({Key? key}) : super(key: key);

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (_) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.defaultDialog(
              title: "Logout From App",
              titleStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              middleText: "Are you sure you need to logout",
              middleTextStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.grey,
              radius: 10,
              textCancel: "NO",
              cancelTextColor: Colors.white,
              textConfirm: "YES",
              confirmTextColor: Colors.white,
              onCancel: () {
                Get.back();
              },
              onConfirm: () {
                controller.signOutFromApp();
              },
              buttonColor: Get.isDarkMode ? pinkClr : mainColor,
            );
          },
          splashColor: Get.isDarkMode ? Colors.pink[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(12),
          customBorder: const StadiumBorder(),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: logOutSettings,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              TextUtils(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                text: "Logout",
                color: Get.isDarkMode ? Colors.white : Colors.black,
                underLine: TextDecoration.none,
              ),
            ],
          ),
        ),
      ),
    );
  }
}