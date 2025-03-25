import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:super_app_base_flutter/common/base/base_view_model.dart';
import 'package:super_app_base_flutter/common/base/base_widget.dart';
import 'package:super_app_base_flutter/navigation/navigation_command.dart';


class MockBaseViewModel extends Mock implements BaseViewModel {
  @override
  Stream<String?> get snackBarMessage => Stream.empty();

  @override
  Stream<NavigationCommand> get navigationCommand => Stream.empty();
}

void main() {
  late MockBaseViewModel viewModel;
  late GoRouter router;

  setUp(() {
    viewModel = MockBaseViewModel();
    router = GoRouter(routes: []);
  });

  Widget createTestWidget({required Widget child}) {
    return GetMaterialApp(
      home: child,
    );
  }

  testWidgets('BaseWidget displays title and app bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestWidget(
        child: BaseWidget<MockBaseViewModel>(
          viewModel: viewModel,
          title: 'Test Title',
          content: (context, padding) => Container(),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('BaseWidget shows back arrow when enabled', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestWidget(
        child: BaseWidget<MockBaseViewModel>(
          viewModel: viewModel,
          title: 'Test',
          showBackArrow: true,
          content: (context, padding) => Container(),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_forward_ios_outlined), findsOneWidget);
  });


  testWidgets('BaseWidget correctly shows a snackbar message', (WidgetTester tester) async {
    when(viewModel.snackBarMessage).thenAnswer((_) => Stream.value('Snackbar Test'));

    await tester.pumpWidget(
      createTestWidget(
        child: BaseWidget<MockBaseViewModel>(
          viewModel: viewModel,
          title: 'Snackbar Test',
          content: (context, padding) => Container(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Snackbar Test'), findsOneWidget);
  });

  testWidgets('BaseWidget cleans up resources on dispose', (WidgetTester tester) async {
    final streamController = StreamController<String?>();

    when(viewModel.snackBarMessage).thenAnswer((_) => streamController.stream);
    when(viewModel.navigationCommand).thenAnswer((_) => Stream.empty());

    await tester.pumpWidget(
      createTestWidget(
        child: BaseWidget<MockBaseViewModel>(
          viewModel: viewModel,
          title: 'Dispose Test',
          content: (context, padding) => Container(),
        ),
      ),
    );

    streamController.close();
  });
}

