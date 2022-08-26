import 'package:flutter/material.dart';
import 'today_detail.dart';
import 'data/person.dart';
 
class MatchedScreen extends StatelessWidget {
  MatchedScreen({Key? key}) : super(key: key);

  final List<Note> _matchedList = [
    Note(
      title: '강살롱',
      content: '24살 | 배우 | ESFJ',
      image: 'assets/image/image2.png',
    ),
    Note(
      title: '유살롱',
      content: '24살 | 배우 | ESFJ',
      image: 'assets/image/image5.png',
    )
  ];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(  
        body: GridView.builder(  
          itemCount: _matchedList.length,  
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,  
            childAspectRatio: 1/ 1.73,
            crossAxisSpacing: 12.0,  
            mainAxisSpacing: 12.0
            ),
            itemBuilder: (BuildContext context, int index)=>
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => todaydetail(_matchedList[index]),
                 )),
                child: Container(
                  color: Colors.white,
                  child: Column(
                   children: [
                    
                    Image.asset(_matchedList[index].image),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0), child: Text(
                              _matchedList[index].title,
                              style: TextStyle(fontSize: 16.0, fontFamily: 'Gothic A1', fontWeight : FontWeight.w600)
                            ))),
                          Expanded(child: Text(
                              _matchedList[index].content,
                              style: TextStyle(fontSize: 10.0, fontFamily: 'Gothic A1', fontWeight : FontWeight.w400))),
                        ]
                      ),
                      ),
                    ],
                  ),
                ),
              ),
        ),   
       ),
    );
  }
}