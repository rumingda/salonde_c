// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:salondec/data/model/person2.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:salondec/component/custom_love_letter.dart';
import 'package:salondec/component/custom_alert_dialog.dart';

class todaydetail extends StatefulWidget {
  final Note note;
  todaydetail(this.note);

  List<String> images = ["assets/image/profile_detail1.png"];
  @override
  _todaydetailState createState() => _todaydetailState();
}

class _todaydetailState extends State<todaydetail> {
  // ignore: non_constant_identifier_names
  double update_rating = 0.0;

  @override
  Widget build(BuildContext context) {
    final note = widget.note;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: <Widget>[
          //# SliverAppBar #1
          SliverAppBar(
            floating: false,
            pinned: false,
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            expandedHeight: 290.0,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Card(
                  color: Color(0xffF1F1F1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipOval(
                              child: Image.asset(
                                note.image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                            ),
                            Text(
                              note.title,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w800),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(2.0),
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (update_rating > 0.0) {
                                  showDialog(
                                    barrierColor:
                                        Color(0xff365859).withOpacity(0.5),
                                    context: context,
                                    builder: (context) {
                                      return const CustomLoveLetter(
                                        title:
                                            "호감을 보내고(20코인) 상대방이 수락하면 바로 연락처를 알 수 있습니다.",
                                        hint: "설레는 마음을 담아 메세지를 작성해보아요 :)",
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    barrierColor: Colors.black26,
                                    context: context,
                                    builder: (context) {
                                      return const CustomAlertDialog(
                                        title: "별점 평가를 먼저 해주세요.",
                                        //description: "Custom Popup dialog Description.",
                                      );
                                    },
                                  );
                                }
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      30.0), //adds padding inside the button
                              child: Text("호감 보내기"),
                              color: Color(0xFF365859),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              child: Text("러브레터 보내기"),
                              color: Color(0xFF365859),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                            ),
                          ]),
                    ),
                  ),
                )),
          ),

          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Text('질문 $index'),
                );
              },
              childCount: 6,
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Color(0xffF1F1F1),
                height: 250.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image.asset(
                      "assets/image/profile_detail1.png",
                      fit: BoxFit.fitHeight,
                    ))
                  ],
                ),
              ),
              Container(
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    title: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text('Q 자기소개 ?')),
                    subtitle: Text(
                        '반갑습니다. 진지한 만남을 하고 싶어요. 티키타카가 잘 맞는 만남을 가지고 싶습니다 :) ')),
              ),
              Container(
                color: Color(0xffF1F1F1),
                height: 250.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image.asset(
                      "assets/image/profile_detail2.png",
                      fit: BoxFit.fitHeight,
                    ))
                  ],
                ),
              ),
              Container(
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    title: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text('Q 제 성격은 ?')),
                    subtitle: Text('#상냥한 #유머있는 #지적인')),
              ),
              Container(
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    title: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text('Q 평소에 가고 싶던 여행지는?')),
                    subtitle: Text('휴양지로 떠나고 싶어요. 일상의 휴식이 필요해요.')),
              ),
              Container(
                color: Color(0xffF1F1F1),
                height: 250.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image.asset(
                      "assets/image/profile_detail3.png",
                      fit: BoxFit.fitHeight,
                    ))
                  ],
                ),
              ),
              Container(
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    title: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text('Q 요즘 어떤 것에 관심이 있나요?')),
                    subtitle: Text('일찍 결혼하고 싶어요. 결혼에 관심이 있습니다.')),
              ),
            ]),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Color(0xffF1F1F1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0), //adds padding inside the button
                      onPressed: () {
                        if (update_rating > 0.0) {
                          showDialog(
                            barrierColor: Color(0xff365859).withOpacity(0.5),
                            context: context,
                            builder: (context) {
                              return const CustomLoveLetter(
                                title:
                                    "호감을 보내고(20코인) 상대방이 수락하면 바로 연락처를 알 수 있습니다.",
                                hint: "설레는 마음을 담아 메세지를 작성해보아요 :)",
                              );
                            },
                          );
                        } else {
                          showDialog(
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) {
                              return const CustomAlertDialog(
                                title: "별점 평가를 먼저 해주세요.",
                              );
                            },
                          );
                        }
                      },
                      elevation: 0,
                      child: Text("호감 보내기"),
                      color: Color(0xFF365859),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      elevation: 0,
                      child: Text("러브레터 보내기"),
                      color: Color(0xFF365859),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text("평가하지 않으면 상대방이 나를 볼 수 없어요"),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Color(0xffFAE291),
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  update_rating = rating;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
