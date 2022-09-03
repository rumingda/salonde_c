import 'package:flutter/material.dart';

import 'myProfile.dart';

//widgets
//import 'package:now_ui_flutter/widgets/photo-album.dart';

const double _kItemExtent = 32.0;
List<String> imgArray = [
  "assets/image1.png"
];
const title = 'Floating App Bar';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {

  @override
  void initState() {
    super.initState();
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height*0.7;
  
    return Scaffold(  
        body: CustomScrollView(
          slivers: <Widget>[
            // Add the app bar to the CustomScrollView.
            SliverAppBar(
              actions: <Widget>[
                IconButton(icon: Icon(Icons.edit), onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyProfileScreen()));
                }),
              ],
                  
              expandedHeight:height,
              flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
              height: 100,
              child: Align(
              alignment: Alignment.bottomCenter,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "4.87", 
                        style: TextStyle(
                          color: Color(0xff365859),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "살롱드, 30세", 
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "30개", 
                          style: TextStyle(
                            color: Color(0xff365859),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "보유코인", 
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                  ]
            ),)),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/image/image1.png",
                  fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment(0.0, 0.0),
                        colors: [
                           Colors.white,
                           Color(0x00ffffff),
                           ]
                          )
                        ),
                      ),
                    ],
                  ),
              ),
            ),
            // Next, create a SliverList
            SliverFillRemaining(
              child: ListView(
                padding: EdgeInsets.all(30),
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                    ),
                    shape: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    )),
                    title: const Text('재심사받기'),
                    onTap: () {
                    }
                    ),
                    ListTile(
                    leading: const Icon(
                      Icons.home,
                    ),
                    shape: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    )),
                    title: const Text('지인연락처 차단'),
                    onTap: () {
                    }
                    ),
                ]
              )
            ),
          ],
        ),
    );
  }
}
  
    
    
    
    /*Material(
      child: Stack(
        children: <Widget>[

          Container(
            height: 400,
            child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientStart, gradientEnd],
              ).createShader(Rect.fromLTRB(0, -140, rect.width, rect.height-20));
            },
            blendMode: BlendMode.darken,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/image/image1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
           Align(
                alignment: Alignment.center,
            child:Row(  
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ButtonTheme(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {},
                    textColor: Colors.blueAccent,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Container(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ButtonTheme(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Container(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
            ),
          ),

          Expanded(
            //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16,),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: EdgeInsets.all(0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Container(
                  height: size.height * 0.45,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12,),
                                      child: Center(
                                        child: Text(
                                          "ADD FRIEND",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 8,
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE4395F),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12,),
                                      child: Center(
                                        child: Text(
                                          "FOLLOW",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Text(
                              "Winnie Vasquez",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Text(
                              "Photography",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Text(
                              "I am a UI/UX designer for Website & Mobile who likes to create powerful, pizel perfect designs",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),

                          ],
                        ),
                      ),

                      Expanded(
                        child: Container(),
                      ),

                      Divider(
                        color: Colors.grey[400],
                      ),     
                    ],
                  ),
                ),
              ),
            ),
          )
        ]
      )
    );
  }
}
  
    
Size size = MediaQuery.of(context).size;
    Color gradientStart = Colors.transparent;
    Color gradientEnd = Colors.white;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
           ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientStart, gradientEnd],
              ).createShader(Rect.fromLTRB(0, 0 , rect.width, rect.height));
            },
            blendMode: BlendMode.screen,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/image4.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            //child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "4.87", 
                          style: TextStyle(
                            color: Color(0xff365859),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "살롱드, 30세", 
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "30개", 
                          style: TextStyle(
                            color: Color(0xff365859),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "보유코인", 
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                )
            ),

          ),
          Expanded(
            //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16,),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: EdgeInsets.all(0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Container(
                  height: size.height * 0.45,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12,),
                                      child: Center(
                                        child: Text(
                                          "ADD FRIEND",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 8,
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE4395F),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12,),
                                      child: Center(
                                        child: Text(
                                          "FOLLOW",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Text(
                              "Winnie Vasquez",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Text(
                              "Photography",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Text(
                              "I am a UI/UX designer for Website & Mobile who likes to create powerful, pizel perfect designs",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),

                          ],
                        ),
                      ),

                      Expanded(
                        child: Container(),
                      ),

                      Divider(
                        color: Colors.grey[400],
                      ),     
*/