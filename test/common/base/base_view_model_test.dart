import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:super_app_base_flutter/common/base/base_view_model.dart';
import 'package:super_app_base_flutter/navigation/navigation_command.dart';


class TestViewModel extends BaseViewModel {}

void main() {
  late TestViewModel viewModel;

  setUp(() {
    viewModel = TestViewModel();
  });

  test('Initial state should have no navigation or snack bar messages', () {
    expect(viewModel.navigationCommand, emitsInOrder([null]));
    expect(viewModel.snackBarMessage, emitsInOrder([null]));
  });

  test('Navigate to a new screen', () {
    viewModel.navigateTo('/home', arguments: {'id': 1});
    expectLater(
        viewModel.navigationCommand,
        emits(isA<To>().having((e) => e.route, 'route', '/home')));
  });

  test('Navigate back', () {
    viewModel.navigateBack();
    expectLater(viewModel.navigationCommand, emits(isA<Back>()));
  });

  test('Navigate and clear stack', () {
    viewModel.navigateAndClearStack('/dashboard');
    expectLater(
        viewModel.navigationCommand,
        emits(isA<ClearAndNavigate>().having((e) => e.route, 'route', '/dashboard')));
  });

  test('Show a snack bar message', () {
    viewModel.showSnackBar('Test message');
    expectLater(viewModel.snackBarMessage, emits('Test message'));
  });

  test('Delete binding if registered', () {
    Get.put(viewModel);
    expect(Get.isRegistered<TestViewModel>(), isTrue);

    viewModel.deleteBindingIfRegistered<TestViewModel>();
    expect(Get.isRegistered<TestViewModel>(), isFalse);
  });

  test('Dispose properly onClose', () {
    viewModel.onClose();
    expect(viewModel.navigationCommand, emitsDone);
    expect(viewModel.snackBarMessage, emitsDone);
  });
}
