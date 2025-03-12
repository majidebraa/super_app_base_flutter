import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../local_data_source.dart';

class LocalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlutterSecureStorage>(() => FlutterSecureStorage(),fenix: true);
    Get.lazyPut(() => LocalDataSource(Get.find()),fenix: true);
  }
}