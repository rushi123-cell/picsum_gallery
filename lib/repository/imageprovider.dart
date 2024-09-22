import 'dart:developer';

import 'package:flutter/material.dart';

import '../Service/imageservice.dart';
import '../model/imagemodel.dart';

class ImageProviderModel with ChangeNotifier {
  List<ImageModel> _images = [];
  bool _isLoading = false;

  List<ImageModel> get images => _images;
  bool get isLoading => _isLoading;

  Future<void> loadImages() async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiService = ApiService();
      _images = await apiService.fetchImages();
      log("Images => ${_images.length}");
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
