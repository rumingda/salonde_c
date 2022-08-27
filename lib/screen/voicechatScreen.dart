import 'package:flutter/material.dart';
import 'package:salondec/widgets/voicechat/lobby_Screen.dart';

class VoicechatScreen extends StatefulWidget {
  const VoicechatScreen({Key? key}) : super(key: key);

  @override
  _VoicechatScreenState createState() => _VoicechatScreenState();
}

class _VoicechatScreenState extends State<VoicechatScreen>{
  final titles = ["스타벅스 매장 음악방", "대화가 필요해 ~", "당신의 고민을 들어드려요"];
  final subtitles = [
    "3명이 댓글을 달았어요",
    "3명이 댓글을 달았어요",
    "3명이 댓글을 달았어요",
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time, Icons.access_time];
  final times = ["1분전", "2분전", "4분전"];
  final TextEditingController _username = TextEditingController();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(    
        itemCount: titles.length,
        itemBuilder: (context, index) {
          
          return Card(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              elevation: 0.0,       
              child: ListTile(    
                  onTap: () {
                  setState(() {
                    titles.add('List' + (titles.length+1).toString());
                    subtitles.add('Here is list' + (titles.length+1).toString() + ' subtitle');
                    times.add('times');
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text(titles[index] + ' pressed!'), ));
                  },

                  leading: Icon(Icons.call),// appbar leading icon.

                  title: Text(titles[index]),
                  subtitle: Text(subtitles[index]),
                  trailing: Text(times[index])
                  ));
        }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute (
                builder : (context) => LobbyPage()
              )
            );
          }
        )
      ),
   );
  }
}