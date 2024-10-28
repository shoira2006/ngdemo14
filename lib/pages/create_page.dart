import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../service/http_service.dart';
import '../service/log_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  apiCreatePost(Post post) async {
    setState(() {
      isLoading = true;
    });

    var response = await HttpService.POST(HttpService.API_POST_CREATE, HttpService.paramsCreatePost(post));
    LogService.i(response!);
    var createdPost = HttpService.parsePostCreate(response);

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pop(true);
  }

  saveNewPost() {
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post post = Post(title: title, body: body, userId: 1);
    apiCreatePost(post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Create Post"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: "Enter title"),
                ),
                TextField(
                  controller: bodyController,
                  decoration: InputDecoration(hintText: "Enter body"),
                ),
                MaterialButton(
                  color: Colors.blue,
                  child: Text("Save"),
                  onPressed: () {
                    saveNewPost();
                  },
                ),
              ],
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
