import 'package:e_commerce/utils/my_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  var switchValue = false.obs;
  var storage = GetStorage();
  var langLocal = eng;

  String capitalize(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(" ");
  }

  // Language

  @override
  void onInit() async {
    super.onInit();

    langLocal = await getLanguage;
  }

  void saveLanguage(String lang) async {
    await storage.write("lang", lang);
  }

  Future<String> get getLanguage async {
    return await storage.read("lang");
  }

  void changeLanguage(String langType) {
    saveLanguage(langType);
    if (langLocal == langType) {
      return;
    }

    if (langType == fre) {
      langLocal = fre;
      saveLanguage(fre);
    } else if (langType == ara) {
      langLocal = ara;
      saveLanguage(ara);
    } else {
      langLocal = eng;
      saveLanguage(eng);
    }
    update();
  }
}
