import 'dart:io';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:salondec/data/define.dart';
import 'package:salondec/data/model/gender_model.dart';
import 'package:salondec/data/model/user_model.dart';
import 'package:salondec/data/repositories/auth_repository_impl.dart';

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

  final Rxn<UserModel?> _userModel = Rxn(null);
  UserModel? get userModel => _userModel.value;
  // RxList<UserModel> userModelList = <UserModel>[].obs;
  // final Rxn<UserModel> _user = Rxn<UserModel>();
  // UserModel? get user => _user.value;
  String gender = '남';
  String imageUrl = '';
  // final GetStorage _storage = GetStorage();
  // final storage = FlutterSecureStorage();

  Rxn<List<GenderModel>> genderModelList = Rxn(null);

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

      UserModel userModel = UserModel(
        id: userCredential.user?.uid ?? "",
        email: userCredential.user?.email ?? "",
        gender: gender,
      );
      GenderModel genderModel = GenderModel(
        uid: userCredential.user?.uid ?? "",
      );

      _firebaseFirestore
          .collection(FireStoreCollection.userCollection)
          .doc(userModel.id)
          .set(userModel.toJson());
      if (gender == "남") {
        _firebaseFirestore
            .collection(FireStoreCollection.manCollection)
            .doc(userModel.id)
            .set(genderModel.toJson());
      } else {
        _firebaseFirestore
            .collection(FireStoreCollection.womanCollection)
            .doc(userModel.id)
            .set(genderModel.toJson());
      }
      _userModel.value = userModel;
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
    }
  }

  Future<void> getMainPageInfo(
      {required String uid, required String gender}) async {
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
}
