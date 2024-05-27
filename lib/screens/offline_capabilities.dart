import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_assessment/controller/api_controller.dart';


class OfflineCapabilities extends StatelessWidget {
  final ApiController _controller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Off Line API Screen'),
      ),
      body: Center(
        child: GetBuilder<ApiController>(
          builder: (controller) {
            if (controller.posts.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.posts[index].title),
                    subtitle: Text(controller.posts[index].body),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
