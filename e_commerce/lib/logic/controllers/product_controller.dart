import 'package:e_commerce/model/product_models.dart';
import 'package:e_commerce/services/product_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
  var productList = <ProductModels>[].obs;
  var favoritesList = <ProductModels>[].obs;
  var isLoading = true.obs;
  var storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    List? storedShoppings = storage.read<List>("isFavoritesList");

    if (storedShoppings != null) {
      favoritesList =
          storedShoppings.map((e) => ProductModels.fromJson(e)).toList().obs;
    }
    getProducts();
  }

  void getProducts() async {
    var products = await ProductServices.getProduct();

    try {
      //isLoading.value = true; OR
      isLoading(true);

      if (products.isNotEmpty) {
        productList.addAll(products);
      }
    } finally {
      isLoading(false);
    }
  }

  // Logic for Favorites Screen

  void manageFavorites(int productId) async {
    var existingIndex =
        favoritesList.indexWhere((element) => element.id == productId);

    if (existingIndex >= 0) {
      favoritesList.removeAt(existingIndex);

      await storage.remove("isFavoritesList");
    } else {
      favoritesList
          .add(productList.firstWhere((element) => element.id == productId));

      await storage.write("isFavoritesList", favoritesList);
    }
  }

  bool isFavorites(int productId) {
    return favoritesList.any((element) => element.id == productId);
  }
}
