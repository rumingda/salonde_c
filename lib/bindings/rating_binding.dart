import 'package:get/get.dart';
import 'package:salondec/page/viewmodel/rating_viewmodel.dart';

class RatingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RatingViewModel>(RatingViewModel());
  }
}
