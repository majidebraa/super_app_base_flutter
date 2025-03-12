import 'package:get/get.dart';
import '../../navigation/navigation_command.dart';

abstract class BaseViewModel extends GetxController {
  final  _navigationCommand = Rx<NavigationCommand?>(null);
  final _snackBarMessage = Rx<String?>(null);

  Stream<NavigationCommand?> get navigationCommand => _navigationCommand.stream;
  Stream<String?> get snackBarMessage => _snackBarMessage.stream;

  void navigateTo(String route, {dynamic arguments}) {
    _navigationCommand.value = To(route, arguments: arguments);
  }

  void navigateBack() {
    _navigationCommand.value = Back();
  }

  void navigateAndClearStack(String route, {dynamic arguments}) {
    _navigationCommand.value = ClearAndNavigate(route, arguments: arguments);
  }

  void showSnackBar(String message) {
    _snackBarMessage.value = message;
    // Clear the message immediately after emitting
    Future.microtask(() => _snackBarMessage.value = null);
  }

  void deleteBindingIfRegistered<T>() {
    if (Get.isRegistered<T>()) {
      Get.delete<T>();
    }
  }

  @override
  void onClose() {
    _navigationCommand.close();
    _snackBarMessage.close();
    super.onClose();
  }
}

