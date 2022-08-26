import 'package:flutter/material.dart';

class LoveletterScreen extends StatefulWidget {
  int pageIndex = 0;
  @override
  _LoveletterScreenState createState() => _LoveletterScreenState();
}

class _LoveletterScreenState extends State<LoveletterScreen>{

  final loveletters = [
    "프로필을 봤는데 너무 인상적이네요 :) 미남이세요. 취미생활이 같아서 호감이 갔어요. 와인과 맛집을 좋아하는게 좋아요.",
    "취미생활이 같아서 호감이 갔어요. 와인과 맛집을 좋아하는게 좋아요. 프로필을 봤는데 너무 인상적이네요 :) 미남이세요 !",
  ];


  final points = [
    "4.5",
    "5",
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time, Icons.access_time];
  List<String> images = [  
    "assets/image/image1_mask.png",  "assets/image/image4_mask.png",   
  ];
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: new ThemeData(accentColor: Colors.black,),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xffD2D2D2), 
            isScrollable: true,   
            tabs: <Widget>[
                Tab(text: "전체"),
                Tab(text: "베스트"),
                Tab(text: "연애"),
                Tab(text: "자랑"),
                Tab(text: "재태크"),
                Tab(text: "유머"),
              ],
          ),
      body:ListView.builder(    
        itemCount: loveletters.length,
        itemBuilder: (context, index) {
          
        return Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          child: IntrinsicHeight(
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    width: 120,
                    child: Image.asset(images[index]),
                  ),
                ),
                Expanded(
                  flex:4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children : [
                      Container(padding: EdgeInsets.all(20),
                      child: Text(loveletters[index])),
                      Container(padding: EdgeInsets.all(20),
                        child: Text("강살롱님에게" + points[index] + "점을 받았어요!")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
       );
        }
        ),
      ),
      )
    );
  }
}
