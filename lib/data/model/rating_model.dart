import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RatingModel extends Equatable {
  late String targetUid;
  late double rating;

  RatingModel({
    required this.targetUid,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'targetUid': targetUid,
      'rating': rating,
    };
  }

  factory RatingModel.fromFirebase(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> json = documentSnapshot.data() as Map<String, dynamic>;

    return RatingModel(
      targetUid: json['targetUid'],
      rating: json['rating'],
    );
  }

  @override
  List<Object> get props => [targetUid, rating];
}
