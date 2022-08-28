import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:salondec/data/model/core.dart';

class UserModel extends Core {
  late String id;
  late String email;
  late String gender;
  late String? name;
  late int? age;
  late int? height;
  late double? rating;
  late String? job;
  late String? religion;
  late String? mbti;
  late String? bodytype;
  late String? introduction;
  late String? profileImageUrl;
  late String? character;
  late String? interest;
  late String? imgUrl1;
  late String? imgUrl2;
  late String? imgUrl3;

  UserModel({
    required this.id,
    required this.email,
    // this.isActivate = true,
    required this.gender,
    this.name,
    this.age,
    this.height,
    this.rating,
    this.job,
    this.religion,
    this.mbti,
    this.bodytype,
    this.introduction,
    this.profileImageUrl,
    this.character,
    this.interest,
    this.imgUrl1,
    this.imgUrl2,
    this.imgUrl3,
  }) : super(DateTime.now(), DateTime.now());

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'email': email,
  //     'name': name,
  //     'job': job,
  //     'profileImageUrl': profileImageUrl,
  //   };
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'gender': gender,
      'name': name ?? "",
      'age': age ?? 0,
      'height': height ?? 0,
      'rating': rating ?? 0.0,
      'job': job ?? "",
      'religion': religion ?? "",
      'mbti': mbti ?? "",
      'bodytype': bodytype ?? "",
      'introduction': introduction ?? "",
      'profileImageUrl': profileImageUrl ?? "",
      'character': character ?? "",
      'interest': interest ?? "",
      'imgUrl1': imgUrl1 ?? "",
      'imgUrl2': imgUrl2 ?? "",
      'imgUrl3': imgUrl3 ?? "",
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserModel.fromFirebase(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> json = documentSnapshot.data() as Map<String, dynamic>;
    UserModel userModel = UserModel(
      id: documentSnapshot.id,
      email: json['email'],
      gender: json['gender'],
      name: json['name'],
      age: json['age'],
      height: json['height'],
      rating: json['rating'],
      job: json['job'],
      religion: json['religion'],
      mbti: json['mbti'],
      bodytype: json['bodytype'],
      introduction: json['introduction'],
      profileImageUrl: json['profile_image_url'],
      character: json['character'],
      interest: json['interest'],
      imgUrl1: json['imgUrl1'],
      imgUrl2: json['imgUrl2'],
      imgUrl3: json['imgUrl3'],
    );
    userModel.createdAt = (json['created_at'] as Timestamp).toDate();
    userModel.updatedAt = (json['updated_at'] as Timestamp).toDate();

    return userModel;
  }
}
