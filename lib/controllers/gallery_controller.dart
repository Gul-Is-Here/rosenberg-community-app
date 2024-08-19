import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/evnets_images_model.dart';

class GalleryController extends GetxController {
  var gallerySubcategories = <Subcategory>[].obs; // List of Subcategory model
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGalleryEvents();
  }

  void fetchGalleryEvents() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(
            'https://rosenbergcommunitycenter.org/api/gallery_events?access=7b150e45-e0c1-43bc-9290-3c0bf6473a51332&cat_name=images'),
      );

      if (response.statusCode == 200) {
        var data = EventsModel.fromRawJson(response.body);
        gallerySubcategories.assignAll(data.data.subcategory);
      } else {
        print(
            'Error: Failed to fetch events. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
