import 'package:flutter/material.dart';
import 'package:salondec/menu/Test.dart';
import 'package:salondec/menu/lobby.dart';
import 'package:salondec/menu/myProfile.dart';
// import 'package:salondec/menu/myProfile2.dart';
import 'package:salondec/page/screen/homeScreen.dart';
import 'package:salondec/page/screen/chatScreen.dart';
import 'package:salondec/page/screen/discoveryScreen.dart';
import 'package:salondec/page/screen/favoriteScreen.dart';
import 'package:salondec/page/screen/loveletterScreen.dart';
import 'package:salondec/menu/lobby_list.dart';
import 'package:salondec/page/screen/voiceChatRoomMaker.dart';
import 'package:salondec/widgets/agora-group-calling/GroupCallPage.dart';
import 'package:salondec/widgets/broadcast_audio/broadAudioScreen.dart';
import 'package:salondec/widgets/broadcast_video/broadVideoScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final user = FirebaseAuth.instance.currentUser!;

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
                    MaterialPageRoute(builder: (context) => myProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('채팅만들기'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Voicechat_making_room(username: _username.text)));
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
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('브로드캐스트'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BroadcastVideo(username: user.email!)));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('오디오브로드캐스트'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BroadcastAudio()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('그룹콜'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgoraGroupCalling()));
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
