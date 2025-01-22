import 'package:get/get.dart';
import '../di/home_bindings.dart';
import '../home_page.dart';

class HomeRoutes {
  static const String home = '/home';

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: home,
        page: () => HomePage(),
        binding: HomeBindings(),
      ),
    ];
  }
}
