import 'dart:convert';
import 'package:http/http.dart' as http;

class DogService {
  static Future<Map<String, List<String>>> fetchDogData() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, List<String>> dogData = {};

      for (var breed in data['message'].keys) {
        dogData[breed] = [];
      }

      return dogData;
    } else {
      throw Exception('Failed to load dog data');
    }
  }

  static Future<Map<String, String>> fetchDogImages(
      Map<String, List<String>> dogData) async {
    final Map<String, String> dogImages = {};

    await Future.forEach(dogData.keys, (breed) async {
      final response = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String imageUrl = data['message'];

        dogImages[breed] = imageUrl;
      } else {
        throw Exception('Failed to load dog image for $breed');
      }
    });

    return dogImages;
  }

  Future<List<String>> fetchSubBreeds(String breed) async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/list'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> subBreeds = List<String>.from(data['message']);
      return subBreeds;
    } else {
      throw Exception('Failed to load sub breeds');
    }
  }

  Future<String> fetchRandomImageForBreed(String breed) async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load random image for $breed');
    }
  }
}
