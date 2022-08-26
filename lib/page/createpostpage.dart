import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CreatePostPage extends StatefulWidget{
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage>{
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String postTitle = "";
  String content = "";

  final String _chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("작성하기")),
      body: Column(
        children: [
          TextField(),
          TextField(),
          ElevatedButton(
            onPressed: (){
              String postKey = getRandomString(16);
              fireStore.collection('woman').doc(postKey).set({
                "title" : postTitle,
                "content" : content,
                "imgUrl" : "",
              });

            } , 
            child: const Text("업로드하기")
          ),
          ElevatedButton(
            onPressed: (){
              fireStore.collection('woman').doc('').delete();
            },
            child: const Text("삭제하기"))
        ]),
    );
  }
}