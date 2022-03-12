import 'package:e_commerce/model/product_models.dart';
import 'package:e_commerce/services/category_services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categoryNameList = <String>[].obs;
  var categoryList = <ProductModels>[].obs;

  var isCategoryLoading = false.obs;
  var areAllCategoriesLoading = false.obs;

  List<String> imageCategory = [
    "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg",
    "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
    "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
    "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg"
  ];

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() async {
    var categoryName = await CategoryServices.getCategory();

    try {
      isCategoryLoading(true);
      if (categoryName.isNotEmpty) {
        categoryNameList.addAll(categoryName);
      }
    } finally {
      isCategoryLoading(false);
    }
  }

  getAllCategories(String nameCategory) async {
    areAllCategoriesLoading(true);
    categoryList.value = await AllCategoryServices.getAllCategory(nameCategory);

    areAllCategoriesLoading(false);
  }

  getCategoryIndex(int index) async {
    var categoryName = await getAllCategories(categoryNameList[index]);

    if (categoryName.isNotEmpty) {
      categoryList.value = categoryName;
    }
  }
}
