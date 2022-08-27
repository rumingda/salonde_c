// import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:salondec/data/repositories/auth_repository_impl.dart';
import 'package:salondec/page/viewmodel/auth_viewmodel.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthViewModel>(AuthViewModel(
        // authRepository: AuthRepositoryImpl(
        //     // dio: new Dio(),
        //     ),
        ));
  }
}
