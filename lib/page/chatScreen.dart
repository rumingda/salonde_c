import 'package:flutter/material.dart';
import 'package:salonde_c/textchatScreen.dart';
import 'package:salonde_c/voicechatScreen.dart';

class ChatScreen extends StatefulWidget {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    TextchatScreen(),
    VoicechatScreen(),
  ];
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>{
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    TextchatScreen(),
    VoicechatScreen(),
  ];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: DefaultTabController(
        length: 2,      
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xffD2D2D2),
            indicatorColor:Colors.transparent,
   
            tabs: <Widget>[
                Tab(text: "문자살롱"),
                Tab(text: "음성살롱"),
              ],
          ),
          body: TabBarView(
            children: [TextchatScreen(), VoicechatScreen(),]
          ),
        ),
      ),
    );
  }
}