import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CampaignsFirebaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// COLLECTION NAME
  final String collectionName = "Campaigns";

  RxBool isLoading=false.obs;


  Stream<QuerySnapshot> getCampaignsStream() {
    return _firestore
        .collection(collectionName)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<Map<String, dynamic>?> getCampaignById(String docId) async {
    try {
      final doc = await _firestore.collection(collectionName).doc(docId).get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch campaign: $e");
      return null;
    }
  }

  Future<bool> updateCampaign({
    required String docId,
    required String title,
    required String subtitle,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      isLoading.value = true;

      await _firestore.collection(collectionName).doc(docId).update({
        "title": title,
        "subtitle": subtitle,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        // Keep the same image or update if you implement image editing
      });

      return true;
    } catch (e) {
      Get.snackbar("Error", "Failed to update campaign: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }



  Future<bool> addCampaign({
    required String title,
    required String subtitle,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      isLoading.value = true;

      // -----------------------------------------------------------
      // 🔍 CHECK IF SAME CAMPAIGN ALREADY EXISTS
      // -----------------------------------------------------------
      final existing = await _firestore
          .collection(collectionName)
          .where("title", isEqualTo: title)
          .where("subtitle", isEqualTo: subtitle)
          .where("startDate", isEqualTo: startDate.toIso8601String())
          .where("endDate", isEqualTo: endDate.toIso8601String())
          .get();

      if (existing.docs.isNotEmpty) {
        Get.snackbar(
          "Duplicate",
          "Campaign with same details already exists!",
        );
        return false;
      }

      // -----------------------------------------------------------
      // 🟢 ADD NEW CAMPAIGN
      // -----------------------------------------------------------
      await _firestore.collection(collectionName).add({
        "title": title,
        "subtitle": subtitle,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "image": "assets/images/compaign1.png",
        "createdAt": DateTime.now().toIso8601String(),
      });

      return true; // SUCCESS
    } catch (e) {
      Get.snackbar("Error", "Failed to add campaign: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }



  /// --------------------------------------------------------------
  /// 🔹 EDIT / UPDATE CAMPAIGN
  /// --------------------------------------------------------------
  Future<void> editCampaign({
    required String docId,
    String? title,
    String? subtitle,
    DateTime? startDate,
    DateTime? endDate,
    String? image,
  }) async {
    isLoading.value=true;
    try {
      Map<String, dynamic> updatedData = {};

      if (title != null) updatedData["title"] = title;
      if (subtitle != null) updatedData["subtitle"] = subtitle;
      if (startDate != null) {
        updatedData["startDate"] = startDate.toIso8601String();
      }
      if (endDate != null) {
        updatedData["endDate"] = endDate.toIso8601String();
      }
      if (image != null) updatedData["image"] = image;

      await _firestore.collection(collectionName).doc(docId).update(updatedData);

      Get.snackbar("Updated", "Campaign updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update campaign: $e");
    }finally{
      isLoading.value=false;
    }
  }

  /// --------------------------------------------------------------
  /// 🔹 DELETE CAMPAIGN
  /// --------------------------------------------------------------
  Future<void> deleteCampaign(String docId) async {
    isLoading.value=true;
    try {
      await _firestore.collection(collectionName).doc(docId).delete();

      Get.snackbar("Deleted", "Campaign deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete campaign: $e");
    }finally{
      isLoading.value=false;
    }
  }

  /// --------------------------------------------------------------
  /// 🔹 GET STREAM OF ALL CAMPAIGNS (Optional - for listing)
  /// --------------------------------------------------------------
}
