import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../model/imagemodel.dart';

class ApiService {
  final String _baseUrl = 'https://picsum.photos/v2/list';

  Future<dynamic> fetchImages() async {
    final response = await http.get(Uri.parse(_baseUrl));

    log("Api url => $_baseUrl");

    try {
      if (response.statusCode == 200) {
        log("Response Status Code => ${response.statusCode}");
        log("Response body => ${response.body}");
        List data = jsonDecode(response.body);
        return data.map((json) => ImageModel.fromJson(json)).toList();
      } else {
        log("Error Status Code => ${response.statusCode}");
        log("Error body => ${response.body}");
        throw Exception('Failed to load images');
      }
    } catch (e) {
      log("Exception in fetch images => $e");
      throw e;
    }
  }
}
