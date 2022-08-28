import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class GenderModel {
  late String uid;
  late int? age;
  late String? imgUrl1;
  late String? imgUrl2;
  late String? imgUrl3;
  late String? name;
  late String? mbti;
  late String? job;
  GenderModel({
    required this.uid,
    this.age,
    this.imgUrl1,
    this.imgUrl2,
    this.imgUrl3,
    this.name,
    this.mbti,
    this.job,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'age': age ?? 0,
      'imgUrl1': imgUrl1 ?? "",
      'imgUrl2': imgUrl2 ?? "",
      'imgUrl3': imgUrl3 ?? "",
      'name': name ?? "",
      'mbti': mbti ?? "",
      'job': job ?? "",
    };
  }

  factory GenderModel.fromFirebase(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> json = documentSnapshot.data() as Map<String, dynamic>;
    GenderModel genderModel = GenderModel(
      uid: documentSnapshot.id,
      age: json['age'],
      imgUrl1: json['imgUrl1'],
      imgUrl2: json['imgUrl2'],
      imgUrl3: json['imgUrl3'],
      name: json['name'],
      mbti: json['mbti'],
      job: json['job'],
    );
    return genderModel;
  }
}
