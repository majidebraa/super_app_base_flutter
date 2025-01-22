
import 'package:get/get.dart';

import 'features/detail/route/detail_routes.dart';
import 'features/home/route/home_routes.dart';

class AppRoutes {
  static List<GetPage> getPages() {
    return [
      ...HomeRoutes.getPages(),
      ...DetailRoutes.getPages(),

    ];
  }
}