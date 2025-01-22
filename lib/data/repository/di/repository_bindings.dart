import 'package:get/get.dart';
import '../../../domain/repositories/user_repository.dart';
import '../user_repository_impl.dart';


class RepositoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(
            () => UserRepositoryImpl(
                Get.find(),
                Get.find()
            )
    );
  }
}