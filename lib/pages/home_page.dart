import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ngdemo14/model/post_list_res.dart';
import 'package:ngdemo14/pages/create_page.dart';
import 'package:ngdemo14/service/http_service.dart';

import '../model/post_model.dart';
import '../service/log_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<PostListRes> items = [];

  apiLoadPostList() async {
    setState(() {
      isLoading = true;
    });

    var response = await HttpService.GET(
        HttpService.API_POST_LIST, HttpService.paramsEmpty());
    LogService.i(response!);
    List<PostListRes> posts = HttpService.parsePostList(response);

    setState(() {
      items.addAll(posts);
      isLoading = false;
    });
  }

  apiDeletePost(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await HttpService.DEL(
        HttpService.API_POST_DELETE + post.id.toString(),
        HttpService.paramsEmpty());
    LogService.i(response!);

    apiLoadPostList();
  }

  callCreatePage() async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CreatePage();
    }));

    if (result) {
      apiLoadPostList();
    }
  }

  void openDialog(Post post){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return CupertinoAlertDialog(
            title: Text("Delete"),
            content: Text("Are you sure you want to delete this post?"),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Cancel"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                textStyle: TextStyle(color: Colors.red),
                isDefaultAction: true,
                child: Text("Confirm"),
                onPressed: (){
                  Navigator.of(context).pop();
                  apiDeletePost(post);
                },
              ),
            ],
          );
        }
    );
  }


  @override
  void initState() {
    super.initState();
    apiLoadPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return itemOfPost(items[index], index);
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          callCreatePage();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(PostListRes postRes, int index) {
    return GestureDetector(
      onLongPress: (){
        Post post = Post(title: postRes.title, body:  postRes.body, userId: postRes.userId);
        openDialog(post);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Text(
              "${index + 1} - ${postRes.title.toUpperCase()}",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              postRes.body,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
