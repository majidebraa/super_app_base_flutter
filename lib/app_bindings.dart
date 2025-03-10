import 'package:get/get.dart';
import 'data/local/di/local_bindings.dart';
import 'data/remote/di/remote_bindings.dart';
import 'data/repository/di/repository_bindings.dart';
import 'features/detail/di/detail_bindings.dart';
import 'features/home/di/home_bindings.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    LocalBindings().dependencies();
    RemoteBindings().dependencies();
    RepositoryBindings().dependencies();

    HomeBindings().dependencies();
    DetailBindings().dependencies();
  }
}
