import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestApiController extends GetxController {
  var data = [].obs;

  // Function to fetch data from the API
  Future<void> fetchData() async {
    print('Fetching data...');
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        data.value = json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw Exception('Failed to load data');
    }
  }
}

class RestApiScreen extends StatelessWidget {
  final RestApiController _controller = Get.put(RestApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Screen'),
      ),
      body: Center(
        child: GetBuilder<RestApiController>(
          builder: (controller) {
            if (controller.data.isEmpty) {
              return CircularProgressIndicator();
            } else {
              // Display the fetched data in a ListView
              return ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.data[index]['title']),
                    subtitle: Text(controller.data[index]['body']),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.fetchData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
