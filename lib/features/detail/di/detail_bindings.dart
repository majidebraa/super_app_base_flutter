import 'package:get/get.dart';

import '../../../domain/use_case/detail/get_user_details_use_case.dart';
import '../detail_view_model.dart';

class DetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetUserDetailsUseCase(Get.find()));
    Get.lazyPut<DetailViewModel>(() => DetailViewModel(Get.find<GetUserDetailsUseCase>())
    );
  }
}