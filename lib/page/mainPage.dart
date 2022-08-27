import 'package:flutter/material.dart';
import 'package:salondec/menu/Test.dart';
import 'package:salondec/menu/lobby.dart';
import 'package:salondec/menu/imageUpload.dart';
import 'package:salondec/screen/homeScreen.dart';
import 'package:salondec/screen/chatScreen.dart';
import 'package:salondec/screen/discoveryScreen.dart';
import 'package:salondec/screen/favoriteScreen.dart';
import 'package:salondec/screen/loveletterScreen.dart';
import 'package:salondec/menu/lobby_list.dart';

String title_string = "Home";

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    HomeScreen(),
    FavoriteScreen(),
    ChatScreen(),
    LoveletternewScreen(),
    DiscoveryScreen()
  ];

  final TextEditingController _username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text((widget.title),
            style: const TextStyle(
                fontFamily: 'Abhaya Libre',
                fontWeight: FontWeight.w700,
                fontSize: 36.0)),
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text("header"),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('나의 프로필'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageUploads()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('음성채팅방만들기'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LobbyPage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('음성채팅리스트'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LobbyList(username: _username.text)));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('테스트'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Test()));
              },
            ),
          ],
        ),
      ),
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
            switch (pageIndex) {
              case 0:
                {
                  title_string = 'Home';
                }
                break;
              case 1:
                {
                  title_string = 'Favorite';
                }
                break;
              case 2:
                {
                  title_string = 'Salon';
                }
                break;
              case 3:
                {
                  title_string = 'Love letter';
                }
                break;
              case 4:
                {
                  title_string = 'Discovery';
                }
                break;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'reviews',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'public',
          ),
        ],
        selectedItemColor: Colors.amber[200],
      ),
    );
  }
}
