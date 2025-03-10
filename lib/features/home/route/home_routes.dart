import 'package:go_router/go_router.dart';
import '../home_page.dart';

class HomeRoutes {
  static const String home = '/home';

  static List<GoRoute> getPages() {
    return [
      GoRoute(
        path: home,
        builder: (context, state)=>HomePage(),
      ),
    ];
  }
}
