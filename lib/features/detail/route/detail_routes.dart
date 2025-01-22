import 'package:get/get.dart';

import '../detail_page.dart';
import '../di/detail_bindings.dart';

class DetailRoutes {
  static const String detail = '/detail';

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: detail,
        page: () => DetailPage(),
        binding: DetailBindings(),
      ),
    ];
  }
}
