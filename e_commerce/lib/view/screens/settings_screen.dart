import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/settings/dark_mode_widget.dart';
import 'package:e_commerce/view/widgets/text.utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // ProfileImage(),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Get.isDarkMode ? Colors.white : Colors.grey,
            thickness: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          TextUtils(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            text: "GENERAL",
            color: Get.isDarkMode ? pinkClr : mainColor,
            underLine: TextDecoration.none,
          ),
          const SizedBox(
            height: 20,
          ),
          DarkModeWidget(),
          const SizedBox(
            height: 20,
          ),
          // LanguageWidget(),
          const SizedBox(
            height: 20,
          ),
          // LogOutWidget(),
        ],
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextButton(
      //         onPressed: () {
      //           ThemeController().changesTheme();
      //         },
      //         child: Text(
      //           "Dark Mode",
      //           style: TextStyle(
      //             color: Get.isDarkMode ? Colors.white : Colors.black,
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       GetBuilder<AuthController>(
      //         builder: (controller) {
      //           return TextButton(
      //             onPressed: () {
      //               Get.defaultDialog(
      //                 title: "Logout From App",
      //                 titleStyle: TextStyle(
      //                   fontSize: 18,
      //                   color: Colors.black,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //                 middleText: "Are you sure you need to logout",
      //                 middleTextStyle: TextStyle(
      //                   fontSize: 18,
      //                   color: Colors.black,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //                 backgroundColor: Colors.grey,
      //                 radius: 10,
      //                 textCancel: "NO",
      //                 cancelTextColor: Colors.white,
      //                 textConfirm: "YES",
      //                 confirmTextColor: Colors.white,
      //                 onCancel: () {
      //                   Get.back();
      //                 },
      //                 onConfirm: () {
      //                   controller.signOutFromApp();
      //                 },
      //                 buttonColor: Get.isDarkMode ? pinkClr : mainColor,
      //               );
      //             },
      //             child: Text(
      //               "LogOut",
      //               style: TextStyle(
      //                 color: Get.isDarkMode ? Colors.white : Colors.black,
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
