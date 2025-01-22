import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../const_helper.dart';
import '../remote_module.dart';
import '../remote_module_imp.dart';

class RemoteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectionTimeOut,
        receiveTimeout: connectionTimeOut,
      ),
    ));

    Get.lazyPut<RemoteModule>(
            () => RemoteModuleImpl(Get.find(),Get.find())
    );
    }
}