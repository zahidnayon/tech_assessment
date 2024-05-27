import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:tech_assessment/model/data_model.dart';

class ApiController extends GetxController {
  var posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Function to fetch data from the API
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        posts.value = responseData.map((data) => Post.fromJson(data)).toList();
        await cacheData(posts); // Cache the fetched data
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Load cached data if offline
      posts.value = await loadCachedData();
    }
  }

  // Function to cache data locally using Hive
  Future<void> cacheData(RxList<Post> data) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final hiveBox = await Hive.openBox<List<Map<String, dynamic>>>(
      'posts',
      path: appDocumentDir.path,
    );
    hiveBox.put('data', data.map((post) => post.toJson()).toList());
  }

  // Function to load cached data from local storage
  Future<List<Post>> loadCachedData() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final hiveBox = await Hive.openBox<List<Map<String, dynamic>>>(
      'posts',
      path: appDocumentDir.path,
    );
    final List<Map<String, dynamic>>? cachedData = hiveBox.get('data');
    if (cachedData != null) {
      return cachedData.map((data) => Post.fromJson(data)).toList();
    } else {
      return [];
    }
  }
}
