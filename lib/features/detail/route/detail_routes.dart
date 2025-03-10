import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../detail_page.dart';
import '../di/detail_bindings.dart';

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
