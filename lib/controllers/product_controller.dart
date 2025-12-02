import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_dashboard/controllers/base_controller/my_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends MyController{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// COLLECTION NAME
  final String collectionName = "Products";

  RxBool isLoading = false.obs;

  RxString selectedCategory = "Select".obs;
  RxString selectedSubCategory = "Simple Latte".obs;
  RxString selectedAvailable = "Hot".obs;
  RxString selectedSize = "Small".obs;

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  // Lists from your screenshot
  final List<String> categories = [
    "Select",
    "Coffee",
    "Sandwich",
    "Desert",
    "Drinks",
    "Grocery Item",
  ];

  final List<String> subCategories = [
    "Simple Latte",
    "Iced Latte",
    "Cappuccino",
    "Signature Coffee",
    "Americano",
    "Espresso",
    "Flat White",
    "Macchiato",
    "Mocha",
    "Affogato",
  ];

  final List<String> availableIn = ["Hot", "Iced", "Both"];
  final List<String> sizes = ["Small", "Medium", "Large"];

  /// --------------------------------------------------------------
  /// 🔹 GET PRODUCTS STREAM (Real-time updates)
  /// --------------------------------------------------------------
  Stream<QuerySnapshot> getProductsStream() {
    return _firestore
        .collection(collectionName)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  /// --------------------------------------------------------------
  /// 🔹 GET PRODUCT BY ID
  /// --------------------------------------------------------------
  Future<Map<String, dynamic>?> getProductById(String docId) async {
    try {
      final doc = await _firestore.collection(collectionName).doc(docId).get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch product: $e");
      return null;
    }
  }

  /// --------------------------------------------------------------
  /// 🔹 ADD NEW PRODUCT
  /// --------------------------------------------------------------
  Future<bool> addProduct({
    required String name,
    required String price,
    required String category,
    String? subCategory,
    String? availableIn,
    String? size,
  }) async {
    try {
      isLoading.value = true;

      // Validation
      if (name.isEmpty || price.isEmpty || category == "Select") {
        Get.snackbar("Error", "Please fill all required fields");
        return false;
      }

      // Check for duplicate product
      final existing = await _firestore
          .collection(collectionName)
          .where("name", isEqualTo: name)
          .where("category", isEqualTo: category)
          .get();

      if (existing.docs.isNotEmpty) {
        Get.snackbar(
          "Duplicate",
          "Product with same name and category already exists!",
        );
        return false;
      }

      // Placeholder image URL (since Firebase Storage is not available)
      const String placeholderImage = "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400";

      // Create product data
      Map<String, dynamic> productData = {
        "name": name,
        "price": price,
        "category": category,
        "image": placeholderImage,
        "createdAt": DateTime.now().toIso8601String(),
      };

      // Add optional fields if category is Coffee
      if (category == "Coffee") {
        productData["subCategory"] = subCategory ?? "Simple Latte";
        productData["availableIn"] = availableIn ?? "Hot";
        productData["size"] = size ?? "Medium";
      }

      // Add to Firestore
      await _firestore.collection(collectionName).add(productData);

      Get.snackbar("Success", "Product added successfully");
      return true;
    } catch (e) {
      Get.snackbar("Error", "Failed to add product: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// --------------------------------------------------------------
  /// 🔹 UPDATE PRODUCT
  /// --------------------------------------------------------------
  Future<bool> updateProduct({
    required String docId,
    required String name,
    required String price,
    required String category,
    String? subCategory,
    String? availableIn,
    String? size,
  }) async {
    try {
      isLoading.value = true;

      // Validation
      if (name.isEmpty || price.isEmpty || category == "Select") {
        Get.snackbar("Error", "Please fill all required fields");
        return false;
      }

      Map<String, dynamic> updatedData = {
        "name": name,
        "price": price,
        "category": category,
      };

      // Add optional fields if category is Coffee
      if (category == "Coffee") {
        updatedData["subCategory"] = subCategory ?? "Simple Latte";
        updatedData["availableIn"] = availableIn ?? "Hot";
        updatedData["size"] = size ?? "Medium";
      } else {
        // Remove coffee-specific fields if category changed
        updatedData["subCategory"] = FieldValue.delete();
        updatedData["availableIn"] = FieldValue.delete();
        updatedData["size"] = FieldValue.delete();
      }

      await _firestore.collection(collectionName).doc(docId).update(updatedData);

      Get.snackbar("Success", "Product updated successfully");
      return true;
    } catch (e) {
      Get.snackbar("Error", "Failed to update product: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// --------------------------------------------------------------
  /// 🔹 DELETE PRODUCT
  /// --------------------------------------------------------------
  Future<void> deleteProduct(String docId) async {
    isLoading.value = true;
    try {
      await _firestore.collection(collectionName).doc(docId).delete();
      Get.snackbar("Deleted", "Product deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete product: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// --------------------------------------------------------------
  /// 🔹 CLEAR FORM
  /// --------------------------------------------------------------
  void clearForm() {
    nameController.clear();
    priceController.clear();
    selectedCategory.value = "Select";
    selectedSubCategory.value = "Simple Latte";
    selectedAvailable.value = "Hot";
    selectedSize.value = "Small";
  }

  /// --------------------------------------------------------------
  /// 🔹 LOAD PRODUCT DATA FOR EDITING
  /// --------------------------------------------------------------
  void loadProductData(Map<String, dynamic> data) {
    nameController.text = data["name"] ?? "";
    priceController.text = data["price"] ?? "";
    selectedCategory.value = data["category"] ?? "Select";
    
    if (data["category"] == "Coffee") {
      selectedSubCategory.value = data["subCategory"] ?? "Simple Latte";
      selectedAvailable.value = data["availableIn"] ?? "Hot";
      selectedSize.value = data["size"] ?? "Small";
    }
  }

}