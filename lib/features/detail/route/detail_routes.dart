import 'package:go_router/go_router.dart';
import '../detail_page.dart';

class DetailRoutes {
  static const String detail = '/detail';

  static List<GoRoute> getPages() {
    return [
      GoRoute(
        path: detail,
        builder: (context, state)=>DetailPage(),
      ),
    ];
  }
}
