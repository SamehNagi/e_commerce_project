import 'package:e_commerce/language/ar.dart';
import 'package:e_commerce/language/en.dart';
import 'package:e_commerce/language/fr.dart';
import 'package:e_commerce/utils/my_string.dart';
import 'package:get/get.dart';

class LocalizazionApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        eng: en,
        ara: ar,
        fre: fr,
      };
}
