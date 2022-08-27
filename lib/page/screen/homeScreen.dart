import 'package:flutter/material.dart';
import 'package:salondec/data/model/person2.dart';
import 'today_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  ),
  Note(
    title: '강살롱',
    content: '24살 | 배우 | ESFJ',
    image: 'assets/image/image1.png',
  ),
  Note(
    title: '이살롱',
    content: '24살 | 배우 | ESFJ',
    image: 'assets/image/image2.png',
  ),
];

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('woman').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      padding: const EdgeInsets.all(15),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.5,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0),
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    todaydetail(_noteList[index]),
                              )),
                          child: Card(
                            shadowColor: Colors.transparent,
                            child: Stack(
                                alignment: FractionalOffset.bottomCenter,
                                children: <Widget>[
                                  Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                doc['userPhotoUrl'],
                                              ),
                                              fit: BoxFit.fitHeight))),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    height: 40.0,
                                    child: Row(children: <Widget>[
                                      Expanded(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Text(doc['title'],
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontFamily: 'Gothic A1',
                                                      fontWeight:
                                                          FontWeight.w600)))),
                                      Expanded(
                                          child: Text(
                                              doc['age'] +
                                                  ' | ' +
                                                  doc['job'] +
                                                  ' | ' +
                                                  doc['mbti'],
                                              style: const TextStyle(
                                                  fontSize: 10.0,
                                                  fontFamily: 'Gothic A1',
                                                  fontWeight:
                                                      FontWeight.w400))),
                                    ]),
                                  ),
                                ]),
                          ),
                        );
                      },
                    );
                  }
                  return Text(snapshot.error.toString());
                })));
  }
}
