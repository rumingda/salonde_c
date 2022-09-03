import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:salondec/core/define.dart';
import 'package:salondec/core/viewState.dart';
import 'package:salondec/data/model/rated_model.dart';
import 'package:salondec/data/model/rating_model.dart';

class RatingViewModel extends GetxController {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ErrorState _errorState = ErrorState.none;
  ErrorState get errorState => _errorState;

  RxList<RatingModel> ratingPersons = <RatingModel>[].obs;

  final RxBool _checkRating = false.obs;
  bool get checkRating => _checkRating.value;

  Rxn<RatingModel> targetDetail = Rxn(null);
  RxInt currentRating = 0.obs;
  final Rxn<ViewState> _detailViewState = Rxn(Initial());
  ViewState get detailViewState => _detailViewState.value!;

  Future<void> rating(
      {required String uid,
      required String targetUid,
      required double rating}) async {
    await giveRating(uid: uid, targetUid: targetUid, rating: rating);
    await getRatingPersons(uid: uid);
    isRatedPersons(targetUid: targetUid);
  }

  Future<void> init({required String uid}) async {
    await getRatingPersons(uid: uid);
    //test
    // await requestRerating(uid: uid);
  }

  delete() {
    _checkRating.value = false;
    _setState(_detailViewState, Initial());
    targetDetail = Rxn(null);
    _errorState = ErrorState.none;
  }

  // 재심사
  // 우선 재심사할 대상의 rated_persons 에 아이디들을 받아와서 all_users에서 해당 uid에서 내 uid 문서 지우기
  // 마지막으로 내 rated_persons 날리기
  Future<void> requestRerating({required String uid}) async {
    List<RatedModel> tempList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection(FireStoreCollection.userCollection)
              .doc(uid)
              .collection(FireStoreCollection.userRatedMeSubCollection)
              .get();
      var temp =
          querySnapshot.docs.map((e) => RatedModel.fromFirebase(e)).toList();
      if (temp.isNotEmpty) {
        for (var e in temp) {
          tempList.add(e);
        }
      }
      if (tempList.isNotEmpty) {
        for (var model in tempList) {
          await _firebaseFirestore
              .collection(FireStoreCollection.userCollection)
              .doc(model.uid)
              .collection(FireStoreCollection.userRatingSubCollection)
              .doc(uid)
              .delete();
          await _firebaseFirestore
              .collection(FireStoreCollection.userCollection)
              .doc(uid)
              .collection(FireStoreCollection.userRatedMeSubCollection)
              .doc(model.uid)
              .delete();
        }
      }
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        _errorState = ErrorState.network;
      }
      var logger = Logger();
      logger.d("error code : ${e.toString()}, ${e.stackTrace}");
    } catch (e) {
      _catchError(e);
    }
  }

  // 디테일 페이지 진입할때 비교
  isRatedPersons({required String targetUid}) {
    _setState(_detailViewState, Loading());
    if (ratingPersons.isNotEmpty) {
      for (var model in ratingPersons) {
        if (model.targetUid == targetUid) {
          _checkRating.value = true; // dispose 할때 다시 false
          targetDetail.value = model;
        }
      }
    }
    _setState(_detailViewState, Loaded());
  }

  // 디스커버리 페이지

  // 메인 페이지 진입할 때.
  Future<void> getRatingPersons({
    required String uid,
  }) async {
    List<RatingModel> tempList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection(FireStoreCollection.userCollection)
              .doc(uid)
              .collection(FireStoreCollection.userRatingSubCollection)
              .get();
      var temp =
          querySnapshot.docs.map((e) => RatingModel.fromFirebase(e)).toList();
      if (temp.isNotEmpty) {
        for (var e in temp) {
          tempList.add(e);
        }
      }
      if (ratingPersons.isNotEmpty) {
        for (var i = 0; i < tempList.length; i++) {
          if (!ratingPersons.contains(tempList[i])) {
            ratingPersons.add(tempList[i]);
          }
        }
      } else {
        ratingPersons.addAll(tempList);
      }
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        _errorState = ErrorState.network;
      }
      var logger = Logger();
      logger.d("error code : ${e.toString()}, ${e.stackTrace}");
    } catch (e) {
      _catchError(e);
    }
  }

// 디테일 페이지, 디스커버리에서 평점 남길때
  Future<void> giveRating(
      {required String uid,
      required String targetUid,
      required double rating}) async {
    RatingModel ratingModel = RatingModel(targetUid: targetUid, rating: rating);
    RatedModel ratedModel = RatedModel(uid: uid, rating: rating);
    try {
      // user sub collection1
      await _firebaseFirestore
          .collection(FireStoreCollection.userCollection)
          .doc(uid)
          .collection(FireStoreCollection.userRatingSubCollection)
          .doc(targetUid)
          .set(ratingModel.toJson());

      // user sub collection2
      await _firebaseFirestore
          .collection(FireStoreCollection.userCollection)
          .doc(targetUid)
          .collection(FireStoreCollection.userRatedMeSubCollection)
          .doc(uid)
          .set(ratedModel.toJson());
      //

    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        _errorState = ErrorState.network;
      }
      var logger = Logger();
      logger.d("error code : ${e.toString()}, ${e.stackTrace}");
    } catch (e) {
      _catchError(e);
    }
  }

  _catchError(Object e) {
    if (e is Error) {
      var logger = Logger();
      logger.d("error code : ${e.toString()}, ${e.stackTrace}");
    }
    var logger = Logger();
    logger.d("error code : ${e.toString()}");
  }

  void _setState(Rxn<ViewState> state, ViewState nextState) =>
      state.value = nextState;
  //? 유저들이 평가한 평점은 특정타이밍에 한번에 반영하기

}
