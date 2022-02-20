import 'dart:async';

import 'package:e_commerce/logic/controllers/auth_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:e_commerce/view/widgets/text.utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckWidget extends StatelessWidget {
  CheckWidget({Key? key}) : super(key: key);

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (_) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                controller.checkBox();
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: controller.isCheckBox
                    ? Get.isDarkMode
                        ? Image.asset('assets/images/check.png')
                        : const Icon(
                            Icons.done,
                            color: pinkClr,
                          )
                    : Container(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                TextUtils(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  text: "I accept ",
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                  underLine: TextDecoration.none,
                ),
                TextUtils(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  text: "term & conditions",
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                  underLine: TextDecoration.underline,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
