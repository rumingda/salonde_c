import 'package:flutter/material.dart';
import '../today_detail.dart';
import '../data/person.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:salonde_c/firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  
                     
  
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  

  final List<Note> _noteList = [
    Note(
      title: '강살롱',
      content: '24살 | 배우 | ESFJ',
      image: 'assets/image/image1.png',
    ),
    Note(
      title: '이살롱',
      content: '24살 | 배우 | ESFJ',
      image: 'assets/image/image2.png',
    )
  ];
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(  
      debugShowCheckedModeBanner: false,
       home: Scaffold(    
        body: GridView.builder( 
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('woman').snapshots(),
          builder: (context, snapshot) {
              if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,*/
                  itemCount: _noteList.length,  
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,  
                    childAspectRatio: 1/ 1.73,
                    crossAxisSpacing: 12.0,  
                    mainAxisSpacing: 12.0
                  ),
            itemBuilder: (BuildContext context, int index){
              DocumentSnapshot doc = snapshot.data!.docs[index];
              return GestureDetector(  
                       
                onTap: () => Navigator.push(
                  
                  context,
                  MaterialPageRoute(
                    builder: (context) => todaydetail(_noteList[index]),
                 )
                ),

                child: Container(
                  color: Colors.white,
                  child: Column(
                   children: [

                    Image.asset(_noteList[index].image),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0), 
                              //child: Text(doc['title'],
                              child: Text(_noteList[index].title,
                              style: const TextStyle(fontSize: 16.0, fontFamily: 'Gothic A1', fontWeight : FontWeight.w600)
                            ))),
                            
                            Expanded(

                              //child: Text(doc['content'],
                              child: Text(_noteList[index].content,
                              style: const TextStyle(fontSize: 10.0, fontFamily: 'Gothic A1', fontWeight : FontWeight.w400))),
                            ]
                          ),
                      ),
                    ]
                  ),
                ),
              );
          },
        )
      )
    );
  }
}
