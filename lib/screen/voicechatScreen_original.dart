import 'package:flutter/material.dart';

class VoicechatScreen2 extends StatefulWidget {
  @override
  _VoicechatScreen2State createState() => _VoicechatScreen2State();
}

class _VoicechatScreen2State extends State<VoicechatScreen2>{
  final titles = ["스타벅스 매장 음악방", "대화가 필요해 ~", "당신의 고민을 들어드려요"];
  final subtitles = [
    "3명이 댓글을 달았어요",
    "3명이 댓글을 달았어요",
    "3명이 댓글을 달았어요",
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time, Icons.access_time];
  final times = ["1분전", "2분전", "4분전"];

  @override
  Widget build(BuildContext context){
   return ListView.builder(
    
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
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(titles[index] + ' pressed!'),
                    ));
                  },

                  leading: Icon(Icons.call),// appbar leading icon.

                  title: Text(titles[index]),
                  subtitle: Text(subtitles[index]),
                  trailing: Text(times[index])
                  ));
        });
  }
}