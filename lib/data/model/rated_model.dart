import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RatedModel extends Equatable {
  late String uid;
  late double rating;
  // late bool ratingYn;

  RatedModel({
    required this.uid,
    required this.rating,
    // required this.ratingYn,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'rating': rating,
      // 'ratingYn': ratingYn,
    };
  }

  factory RatedModel.fromFirebase(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> json = documentSnapshot.data() as Map<String, dynamic>;

    return RatedModel(
      uid: json['uid'],
      rating: json['rating'],
      // ratingYn: json['ratingYn'],
    );
  }

  @override
  List<Object> get props => [uid, rating];
}
