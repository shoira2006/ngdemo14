import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../service/http_service.dart';
import '../service/log_service.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  apiUpdatePost() async{
    Post post = Post(id: 1,title: "NextGen", body: "Academy", userId: 1);

    var response = await HttpService.PUT(HttpService.API_POST_UPDATE+post.id.toString(), HttpService.paramsUpdatePost(post));
    LogService.i(response!);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
