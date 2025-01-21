import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../model/kategori.dart';

class WpApi {
  static Future<List> fecthWpMediaBanner1() async {
    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/media?search=banner-1&per_page=1');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );
    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  static Future<List> fecthWpMediaAd1() async {
    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/media?search=Adv-1&per_page=1');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );
    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  static Future<List> fecthWpMediaAd2() async {
    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/media?search=Adv-2&per_page=1');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );
    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  static Future<List> fecthWpMediaAd3() async {
    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/media?search=Adv-3&per_page=1');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );
    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  static Future<List> fecthWpNews() async {
    Uri url =
        Uri.parse('https://siwalimanews.com/wp-json/wp/v2/posts?per_page=100');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );
    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  static Future<List> fecthWpPopularNews1() async {
    DateTime now = DateTime.now();
    DateTime convertedNow = DateTime(now.year, now.month, now.day, 0, 0, 0);
    String formattedNow = convertedNow.toIso8601String();
    formattedNow = formattedNow.split('.')[0];
    DateTime oneMonthAgo = DateTime(now.year, now.month - 2, now.day);
    DateTime convertedOneMonthAgo =
        DateTime(oneMonthAgo.year, oneMonthAgo.month, oneMonthAgo.day, 0, 0, 0);
    String formattedOneMonthAgo = convertedOneMonthAgo.toIso8601String();
    formattedOneMonthAgo = formattedOneMonthAgo.split('.')[0];

    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/posts?after=$formattedOneMonthAgo&before=$formattedNow&per_page=100');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );

    if (response.statusCode == 200) {
      final ads = json.decode(response.body);
      final random = Random();
      List<dynamic> selectedNews = [];
      while (selectedNews.length < 7) {
        var ad = ads[random.nextInt(ads.length)];
        if (!selectedNews.contains(ad)) {
          selectedNews.add(ad); // Ensure uniqueness
        }
      }
      return selectedNews; // Return only 4 randomly selected ads
    } else {
      throw Exception('Failed to load popular News');
    }
  }

  static Future<Kategori> fecthWpNewsCategory(int id) async {
    Uri url =
        Uri.parse('https://siwalimanews.com/wp-json/wp/v2/categories/$id');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );

    return Kategori.fromJson(jsonDecode(response.body));
  }

  static Future<List> fecthWpNewsRekomendasi(int idkategori) async {
    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/posts?categories=$idkategori&per_page=50');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );
    if (response.statusCode == 200) {
      final ads = json.decode(response.body);
      final random = Random();
      List<dynamic> selectedNews = [];
      while (selectedNews.length < 4) {
        var ad = ads[random.nextInt(ads.length)];
        if (!selectedNews.contains(ad)) {
          selectedNews.add(ad); // Ensure uniqueness
        }
      }
      return selectedNews; // Return only 4 randomly selected ads
    } else {
      throw Exception('Failed to load popular News');
    }
  }

  static Future<List> fecthWpNewsListKategori(int id) async {
    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/posts?categories=$id&per_page=100');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );
    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  static Future<List> fecthWpNewsListSearch(String searchtxt) async {
    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/posts?search=$searchtxt&per_page=100');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );
    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  static Future<List> fecthWpNewsKategori(int id) async {
    Uri url = Uri.parse(
        'https://siwalimanews.com/wp-json/wp/v2/posts?categories=$id&per_page=50');
    final response = await http.get(
      url,
      headers: {"Accept": 'application/json'},
    );

    if (response.statusCode == 200) {
      final ads = json.decode(response.body);
      final random = Random();
      List<dynamic> selectedNews = [];
      while (selectedNews.length < 7) {
        var ad = ads[random.nextInt(ads.length)];
        if (!selectedNews.contains(ad)) {
          selectedNews.add(ad); // Ensure uniqueness
        }
      }
      return selectedNews; // Return only 4 randomly selected ads
    } else {
      throw Exception('Failed to load popular News');
    }
  }

  static Future<void> postWpNewsComment(
      String name, String email, String comment, String postId) async {
    Uri url = Uri.parse('https://siwalimanews.com/wp-json/wp/v2/comments');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'post': postId,
          'author_name': name,
          'author_email': email,
          'content': comment,
        }),
      );

      // Print the raw response
      // ignore: avoid_print
      print('Response status: ${response.statusCode}');
      // ignore: avoid_print
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Handle success
        // ignore: avoid_print
        print('Comment posted successfully!');
      } else {
        // Handle error
        throw Exception(
            'Failed to post comment: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error occurred: $e');
      throw Exception('Error occurred while posting comment: $e');
    }
  }
}
