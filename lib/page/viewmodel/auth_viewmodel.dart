import 'dart:io';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
<<<<<<< HEAD
import 'package:salondec/core/define.dart';
import 'package:salondec/core/viewState.dart';
=======
import 'package:salondec/data/define.dart';
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
import 'package:salondec/data/model/gender_model.dart';
import 'package:salondec/data/model/user_model.dart';
import 'package:salondec/data/repositories/auth_repository_impl.dart';

<<<<<<< HEAD
enum ErrorState { network, fail, none }

=======
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
class AuthViewModel extends GetxController {
  late AuthRepositoryImpl _authRepository;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  // AuthViewModel({required AuthRepositoryImpl authRepository}) {
  //   _authRepository = authRepository;
  // }

  //Firebase통해서 들어오는 유저 데이터
  final Rxn<User?> _user = Rxn(null);
  User? get user => _user.value;

<<<<<<< HEAD
  final Rxn<ViewState> _homeViewState = Rxn(Initial());
  ViewState get homeViewState => _homeViewState.value!;

  final Rxn<UserModel?> userModel = Rxn(null);

  final Rx<ErrorState> _errorState = ErrorState.none.obs;
  ErrorState get errorState => _errorState.value;
  // UserModel? get userModel => _userModel.value;
  // set userModel(UserModel? user) => _userModel.value = user;
=======
  final Rxn<UserModel?> _userModel = Rxn(null);
  UserModel? get userModel => _userModel.value;
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
  // RxList<UserModel> userModelList = <UserModel>[].obs;
  // final Rxn<UserModel> _user = Rxn<UserModel>();
  // UserModel? get user => _user.value;
  String gender = '남';
  String imageUrl = '';
  // final GetStorage _storage = GetStorage();
  // final storage = FlutterSecureStorage();
<<<<<<< HEAD
  Map<String, File> photoMap = {};
  Map<String, String> downloadUrlMap = {};
  Map<String, Reference> referenceMap = {};
  RxList<GenderModel> genderModelList = <GenderModel>[].obs;

  _currentUser() {
    if (_firebaseAuth.currentUser != null) {
      _user.value = _firebaseAuth.currentUser!;
      return;
    }
  }

  _deleteAll() {
    photoMap.clear();
    downloadUrlMap.clear();
    referenceMap.clear();
    genderModelList.clear();
    _user.value = null;
    userModel.value = null;
    _setState(_homeViewState, Initial());
  }

  Future<void> init() async {
    genderModelList.value = [];
    _currentUser();
    await getUserInfo();
    await getMainPageInfo(uid: user!.uid, gender: userModel.value!.gender);
  }
=======

  Rxn<List<GenderModel>> genderModelList = Rxn(null);
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b

  // sign up 은 우선 이메일, 비번으로 아디 만들고
  // 성별을 넣어놓기. 나머지 데이터들은 프로필페이지에서 수정누르면 작동하도록. 가입할때 All_users에도 같이 들어가야함.
  // 프로필 페이지에서 내용을 입력하면 User, All_users 에도 같이 들어가야함. -> man, woman 으로 수정
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String gender,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

<<<<<<< HEAD
      UserModel userModelTemp = UserModel(
        uid: userCredential.user?.uid ?? "",
=======
      UserModel userModel = UserModel(
        id: userCredential.user?.uid ?? "",
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
        email: userCredential.user?.email ?? "",
        gender: gender,
      );
      GenderModel genderModel = GenderModel(
        uid: userCredential.user?.uid ?? "",
      );

      _firebaseFirestore
          .collection(FireStoreCollection.userCollection)
<<<<<<< HEAD
          .doc(userModelTemp.uid)
          .set(userModelTemp.toJson());
      if (gender == "남") {
        _firebaseFirestore
            .collection(FireStoreCollection.manCollection)
            .doc(userModelTemp.uid)
=======
          .doc(userModel.id)
          .set(userModel.toJson());
      if (gender == "남") {
        _firebaseFirestore
            .collection(FireStoreCollection.manCollection)
            .doc(userModel.id)
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
            .set(genderModel.toJson());
      } else {
        _firebaseFirestore
            .collection(FireStoreCollection.womanCollection)
<<<<<<< HEAD
            .doc(userModelTemp.uid)
            .set(genderModel.toJson());
      }
      userModel.value = userModelTemp;
=======
            .doc(userModel.id)
            .set(genderModel.toJson());
      }
      _userModel.value = userModel;
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
      _user.value = userCredential.user;
      // storage.write(key: "uid", value: userCredential.user!.uid);

      return true;
    } on FirebaseAuthException catch (e) {
      var logger = Logger();
      logger.d("error code : ${e.code}");
      return false;
    } catch (e) {
      if (e is Error) {
        var logger = Logger();
        logger.d("error code : ${e.toString()}, ${e.stackTrace}");
        return false;
      }
      var logger = Logger();
      logger.d("error code : ${e.toString()}");
      return false;
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      _user.value = userCredential.user;
      // storage.write(key: "uid", value: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
<<<<<<< HEAD
      if (e.code == "network-request-failed") {
        _errorState.value = ErrorState.network;
      }
      var logger = Logger();
      logger.d("error code : ${e.toString()}, ${e.stackTrace}");
    } catch (e) {
      _catchError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _deleteAll();
    } on FirebaseAuthException catch (e) {
      _catchError(e);
    } catch (e) {
      _catchError(e);
    }
  }

  Future<void> uploadUpdateImages(
      // {required List<String> urlList, required File photo}) async {
      {required Map<String, File> photoMap}) async {
    try {
      if (photoMap.isNotEmpty) {
        // var piterator = photoMap.keys.iterator;
        // for (var i = 0; i < photoMap.length; piterator., i++) {
        //   print("piterator.current ${piterator.current.toString()}");
        // }
        // List<String> test = [];
        // test.add(photoMap.keys.iterator.current);
        // print("object $test");

        for (var mapKey in photoMap.keys) {
          final firebaseStorageRef = _firebaseStorage
              .ref()
              .child('users')
              .child('${DateTime.now().millisecondsSinceEpoch}.png');
          referenceMap[mapKey] = firebaseStorageRef;
          // var test  = await firebaseStorageRef.putFile(
          await firebaseStorageRef.putFile(
              photoMap[mapKey]!, SettableMetadata(contentType: 'image/png'));
          // photoFile, SettableMetadata(contentType: 'image/png'));
        }
        // photoMap.forEach((key, photoFile) async {
        //     .whenComplete(() async {
        //   downloadUrlMap[key] = await firebaseStorageRef.getDownloadURL();
        // });
        // test.ref.fullPath
        // downloadUrlMap[key] = await firebaseStorageRef.getDownloadURL();
        // });
        // updateImagesInfo(downloadUrlMap: downloadUrlMap);
      }
    } on FirebaseException catch (e) {
      _catchError(e);
    } catch (e) {
      _catchError(e);
    }
  }

  Future<void> getDownloadURLs() async {
    for (var mapKey in referenceMap.keys) {
      downloadUrlMap[mapKey] = await referenceMap[mapKey]!.getDownloadURL();
    }
    // referenceMap.forEach((key, e) async {
    //   downloadUrlMap[key] = await e.getDownloadURL();
    // });
    // if (referenceMap.length != referenceMap.length) {
    //   await getDownloadURLs();
    // }
  }

  // Future<void> updateImagesInfo(
  //     {required Map<String, String> downloadUrlMap}) async {
  //   try {
  //     String genderCollection = _checkGender(_userModel.value!);
  //     GenderModel genderModel = GenderModel(
  //       uid: _userModel.value!.uid,
  //       imgUrl1: downloadUrlMap['imgUrl1'],
  //       imgUrl2: downloadUrlMap['imgUrl2'],
  //       imgUrl3: downloadUrlMap['imgUrl3'],
  //     );
  //     UserModel userModel = UserModel(
  //       uid: _userModel.value!.uid,
  //       email: _userModel.value!.email,
  //       gender: _userModel.value!.gender,
  //       imgUrl1: downloadUrlMap['imgUrl1'],
  //       imgUrl2: downloadUrlMap['imgUrl2'],
  //       imgUrl3: downloadUrlMap['imgUrl3'],
  //     );
  //     await _firebaseFirestore
  //         .collection(FireStoreCollection.userCollection)
  //         .doc(userModel.uid)
  //         .set(userModel.toUpdateJson());

  //     await _firebaseFirestore
  //         .collection(genderCollection)
  //         .doc(genderModel.uid)
  //         .set(genderModel.toUpdateJson());
  //   } catch (e) {
  //     _catchError(e);
  //   }
  // }

  Future<void> updateUserInfo({required UserModel userModelTemp}) async {
    // Future<void> updateUserInfo() async {
    String genderCollection = _checkSelfGender(userModel.value!);
    if (downloadUrlMap.isNotEmpty) {
      userModelTemp.imgUrl1 = downloadUrlMap['imgUrl1'];
      userModelTemp.imgUrl2 = downloadUrlMap['imgUrl2'];
      userModelTemp.imgUrl3 = downloadUrlMap['imgUrl3'];
      userModelTemp.profileImageUrl = downloadUrlMap['profileImageUrl'];
    }
    GenderModel genderModel = GenderModel(
      uid: userModel.value!.uid,
      age: userModelTemp.age,
      name: userModelTemp.name,
      mbti: userModelTemp.mbti,
      job: userModelTemp.job,
      imgUrl1: downloadUrlMap['imgUrl1'],
      imgUrl2: downloadUrlMap['imgUrl2'],
      imgUrl3: downloadUrlMap['imgUrl3'],
      introduction: userModelTemp.introduction,
      character: userModelTemp.character,
      interest: userModelTemp.interest,
      profileImageUrl: downloadUrlMap['profileImageUrl'],
      // imgUrl1: userModel.imgUrl1,
      // imgUrl2: userModel.imgUrl2,
      // imgUrl3: userModel.imgUrl3,
    );
    try {
      // UserModel userModel = userModel;
      await _firebaseFirestore
          .collection(FireStoreCollection.userCollection)
          .doc(userModel.value!.uid)
          .update(userModelTemp.toJson(userModel: userModel.value));
      // .update(userModel.value!.toUpdateJson());

      await _firebaseFirestore
          .collection(genderCollection)
          .doc(genderModel.uid)
          .update(genderModel.toJson(userModel: userModel.value));
      // .update(genderModel.toUpdateJson());
      downloadUrlMap.clear();
      photoMap.clear();
    } catch (e) {
      _catchError(e);
    }
  }

  Future<void> getUserInfo(
      // required String uid,
      ) async {
    // currentUser();
    try {
      DocumentSnapshot documentSnapshot = await _firebaseFirestore
          .collection(FireStoreCollection.userCollection)
          .doc(_user.value!.uid)
          .get();

      if (documentSnapshot.data() != null) {
        userModel.value = UserModel.fromFirebase(documentSnapshot);
        gender = userModel.value!.gender;
      }
    } catch (e) {
      _catchError(e);
=======
      var logger = Logger();
      logger.d("error code : ${e.toString()}, ${e.stackTrace}");
    } catch (e) {
      if (e is Error) {
        var logger = Logger();
        logger.d("error code : ${e.toString()}, ${e.stackTrace}");
      }
      var logger = Logger();
      logger.d("error code : ${e.toString()}");
    }
  }

  Future<void> getUserInfo({
    required String uid,
  }) async {
    try {
      DocumentSnapshot documentSnapshot = await _firebaseFirestore
          .collection(FireStoreCollection.userCollection)
          .doc(uid)
          .get();

      if (documentSnapshot.data() != null) {
        _userModel.value = UserModel.fromFirebase(documentSnapshot);
        gender = _userModel.value!.gender;
      }
    } catch (e) {
      if (e is Error) {
        var logger = Logger();
        logger.d("error code : ${e.toString()}, ${e.stackTrace}");
      }
      var logger = Logger();
      logger.d("error code : ${e.toString()}");
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
    }
  }

  Future<void> getMainPageInfo(
      {required String uid, required String gender}) async {
<<<<<<< HEAD
    String genderCollection = _checkGender(userModel.value!);
    genderModelList.clear();
    _setState(_homeViewState, Loading());
    List<GenderModel> tempList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          // await _firebaseFirestore.collection(collection).doc(uid).get();
          await _firebaseFirestore.collection(genderCollection).get();

      // if (querySnapshot != null) {
      // genderModelList.value =
      var temp =
          querySnapshot.docs.map((e) => GenderModel.fromFirebase(e)).toList();

      for (var e in temp) {
        if (e.imgUrl1 != null && e.imgUrl1 != '') {
          // genderModelList.add(e);
          tempList.add(e);
        }
      }

      if (genderModelList.isNotEmpty) {
        for (var i = 0; i < tempList.length; i++) {
          if (!genderModelList.contains(tempList[i])) {
            genderModelList.add(tempList[i]);
          }
        }
      } else {
        genderModelList.addAll(tempList);
      }

      _setState(_homeViewState, Loaded());
    } catch (e) {
      _catchError(e);
=======
    // String collection = gender == "남"
    String collection = _userModel.value?.gender == "남"
        ? FireStoreCollection.womanCollection
        : FireStoreCollection.manCollection;
    print(collection);
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          // await _firebaseFirestore.collection(collection).doc(uid).get();
          await _firebaseFirestore.collection(collection).get();

      // if (querySnapshot != null) {
      genderModelList.value =
          querySnapshot.docs.map((e) => GenderModel.fromFirebase(e)).toList();
      // }
    } catch (e) {
      if (e is Error) {
        var logger = Logger();
        logger.d("error code : ${e.toString()}, ${e.stackTrace}");
      }
      var logger = Logger();
      logger.d("error code : ${e.toString()}");
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
    }
  }

  Future<void> setProfileImage(
      {required String uid, required File image}) async {
    try {
      var fileName = "$uid.jpeg";
      TaskSnapshot result = await _firebaseStorage
          .ref()
          .child("profile/$fileName")
          .putFile(image);
      imageUrl = await result.ref.getDownloadURL();

      await _firebaseFirestore
          .collection(FireStoreCollection.userCollection)
          .doc(uid)
          .update({
        'profile_image_url': imageUrl,
      });
      // return imageUrl;
    } catch (e) {
      var logger = Logger();
      logger.d("error code : ${e.toString()}");
    }
  }
<<<<<<< HEAD

  _catchError(Object e) {
    if (e is Error) {
      var logger = Logger();
      logger.d("error code : ${e.toString()}, ${e.stackTrace}");
    }
    var logger = Logger();
    logger.d("error code : ${e.toString()}");
  }

  String _checkGender(UserModel usermodel) => userModel.value!.gender == "남"
      ? FireStoreCollection.womanCollection
      : FireStoreCollection.manCollection;
  String _checkSelfGender(UserModel usermodel) => userModel.value!.gender == "남"
      ? FireStoreCollection.manCollection
      : FireStoreCollection.womanCollection;

  void _setState(Rxn<ViewState> state, ViewState nextState) =>
      state.value = nextState;
=======
>>>>>>> 8239899606af8655f2c3ae272f42ae6154d99f2b
}
