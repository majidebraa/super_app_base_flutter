import 'package:get/get.dart';
import '../../../domain/use_case/home/get_users_list_use_case.dart';
import '../home_view_model.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetUsersListUseCase(Get.find()));
    Get.lazyPut(() => HomeViewModel(Get.find<GetUsersListUseCase>())
    );
  }
}