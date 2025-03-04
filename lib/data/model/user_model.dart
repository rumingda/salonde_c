import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

<<<<<<< HEAD
import 'package:salondec/core/core.dart';

class UserModel extends Core {
  late String uid;
=======
import 'package:salondec/data/model/core.dart';

class UserModel extends Core {
  late String id;
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
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
<<<<<<< HEAD
    required this.uid,
=======
    required this.id,
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
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
<<<<<<< HEAD
  Map<String, dynamic> toJson({UserModel? userModel}) {
    if (userModel != null) {
      return {
        'id': uid,
        'email': email,
        'gender': gender,
        'name': (name == null || name == '') ? userModel.name : name,
        'age': (age == null || age == 0) ? userModel.age : age,
        'height': (height == null || height == 0) ? userModel.height : height,
        'rating': (rating == null || rating == 0) ? userModel.rating : rating,
        'job': (job == null || job == '') ? userModel.job : job,
        'religion': (religion == null || religion == '')
            ? userModel.religion
            : religion,
        'mbti': (mbti == null || mbti == '') ? userModel.mbti : mbti,
        'bodytype': (bodytype == null || bodytype == '')
            ? userModel.bodytype
            : bodytype,
        'introduction': (introduction == null || introduction == '')
            ? userModel.introduction
            : introduction,
        'profileImageUrl': (profileImageUrl == null || profileImageUrl == '')
            ? userModel.profileImageUrl
            : profileImageUrl,
        'character': (character == null || character == '')
            ? userModel.character
            : character,
        'interest': (interest == null || interest == '')
            ? userModel.interest
            : interest,
        'imgUrl1':
            (imgUrl1 == null || imgUrl1 == '') ? userModel.imgUrl1 : imgUrl1,
        'imgUrl2':
            (imgUrl2 == null || imgUrl2 == '') ? userModel.imgUrl2 : imgUrl2,
        'imgUrl3':
            (imgUrl3 == null || imgUrl3 == '') ? userModel.imgUrl3 : imgUrl3,
        'created_at': userModel.createdAt,
        'updated_at': updatedAt,
      };
    }
    return {
      'id': uid,
=======

  Map<String, dynamic> toJson() {
    return {
      'id': id,
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
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

<<<<<<< HEAD
  // Map<String, Object?> toUpdateJson() {
  //   Map<String, Object?> result = toJson();
  //   result.removeWhere((key, value) {
  //     // if (key == "created_at") {
  //     //   return true;
  //     // }
  //     return value == null; // 사진, 기본정보 등의 내용들 빈값으로 업뎃못하도록.
  //     // return false;
  //   });
  //   return result;
  // }

  factory UserModel.fromFirebase(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> json = documentSnapshot.data() as Map<String, dynamic>;
    double temp = 0;
    if (json['rating'] is int) {
      int rating = json['rating'];
      temp = rating.toDouble();
    }
    UserModel userModel = UserModel(
      uid: documentSnapshot.id,
=======
  factory UserModel.fromFirebase(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> json = documentSnapshot.data() as Map<String, dynamic>;
    UserModel userModel = UserModel(
      id: documentSnapshot.id,
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
      email: json['email'],
      gender: json['gender'],
      name: json['name'],
      age: json['age'],
      height: json['height'],
<<<<<<< HEAD
      rating: json['rating'] is int ? temp : json['rating'],
=======
      rating: json['rating'],
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
      job: json['job'],
      religion: json['religion'],
      mbti: json['mbti'],
      bodytype: json['bodytype'],
      introduction: json['introduction'],
<<<<<<< HEAD
      profileImageUrl: json['profileImageUrl'],
=======
      profileImageUrl: json['profile_image_url'],
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
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
