import 'package:flutter/material.dart';
import 'today_detail.dart';
import 'data/person.dart';
 
class PassawayScreen extends StatelessWidget {
  PassawayScreen({Key? key}) : super(key: key);

  final List<Note> _noteList = [
    Note(
      title: '강살롱',
      content: '24살 | 배우 | ESFJ',
      image: 'assets/image/image1.png',
    ),
    Note(
      title: '김살롱',
      content: '24살 | 배우 | ESFJ',
      image: 'assets/image/image2.png',
    ),
    Note(
      title: '주살롱',
      content: '24살 | 배우 | ESFJ',
      image: 'assets/image/image3.png',
    )
  ];

  List<String> images = [  
    "assets/image/image1_mask.png",  "assets/image/image4_mask.png",   
  ];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(  
        body: GridView.builder(  
          itemCount: images.length,  
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
                    builder: (context) => todaydetail(_noteList[index]),
                 )),
                child: Container(
                  child: Column(
                   children: [
                    
                    Image.asset(images[index]),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        
                        height: 60,
                        alignment: Alignment.center,
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