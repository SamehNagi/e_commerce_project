import 'package:e_commerce/model/category_model.dart';
import 'package:e_commerce/model/product_models.dart';
import 'package:e_commerce/utils/my_string.dart';
import 'package:http/http.dart' as http;

class CategoryServices {
  static Future<List<String>> getCategory() async {
    var response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return categoryModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load products");
    }
  }
}

class AllCategoryServices {
  static Future<List<ProductModels>> getAllCategory(String categoryName) async {
    var response =
        await http.get(Uri.parse('$baseUrl/products/category/$categoryName'));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return productModelsFromJson(jsonData);
    } else {
      return throw Exception("Failed to load products");
    }
  }
}
