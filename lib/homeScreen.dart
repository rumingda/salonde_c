import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

import 'page/chatScreen.dart';
import 'page/favoriteScreen.dart';
import 'page/mainScreen.dart'; 
import 'page/loveletterScreen2.dart';
import 'page/discoveryScreen.dart';
import 'page/createpostpage.dart';

Future<void> main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );*/
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();

}

String title_string = "Home";


class _HomeScreen extends State<HomeScreen> {  
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    MainScreen(),
    FavoriteScreen(),
    ChatScreen(),
    LoveletternewScreen(),
    DiscoveryScreen(),
  ];  

  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(  
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60, 
          title: Text((title_string),style: const TextStyle(fontFamily: 'Abhaya Libre', fontWeight : FontWeight.w700, fontSize: 36.0)),
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
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('업로드'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreatePostPage()),
                  );            
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ), 
        
        body: pageList[pageIndex], 
        bottomNavigationBar: BottomNavigationBar(    
          currentIndex: pageIndex,  
          onTap: (value){
            setState((){
              pageIndex = value;
              switch(pageIndex) { 
                case 0: { title_string = 'Home';} 
                break; 
                case 1: { title_string = 'Favorite'; } 
                break;
                case 2: { title_string = 'Salon'; } 
                break;
                case 3: { title_string = 'Love letter'; } 
                break; 
                case 4: { title_string = 'Discovery'; } 
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
      )
    );
  }
}

