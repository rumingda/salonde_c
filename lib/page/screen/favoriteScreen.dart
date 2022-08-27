import 'package:flutter/material.dart';

import 'package:salondec/page/screen/matchedScreen.dart';
import 'package:salondec/page/screen/matchingScreen.dart';
import 'package:salondec/page/screen/passawayScreen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    MatchingScreen(),
    MatchedScreen(),
    PassawayScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        accentColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xffD2D2D2),
            tabs: <Widget>[
              Tab(text: "매칭된이성"),
              Tab(text: "진행중인이성"),
              Tab(text: "지나간이성")
            ],
          ),
          body: TabBarView(children: [
            MatchedScreen(),
            MatchingScreen(),
            PassawayScreen(),
          ]),
        ),
      ),
    );
  }
}
