import 'package:flutter/material.dart';

import 'textchatScreen.dart';
import 'voicechatScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  int pageIndex = 0;
  final TextEditingController _username = TextEditingController();

  List<Widget> pageList = <Widget>[
    TextchatScreen(),
    VoicechatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xffD2D2D2),
            indicatorColor: Colors.transparent,
            tabs: <Widget>[
              Tab(text: "문자살롱"),
              Tab(text: "음성살롱"),
            ],
          ),
          body: TabBarView(children: [
            TextchatScreen(),
            VoicechatScreen(),
          ]),
        ),
      ),
    );
  }
}
