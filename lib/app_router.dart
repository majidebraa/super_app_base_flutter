import 'package:go_router/go_router.dart';
import 'package:super_app_base_flutter/features/home/route/home_routes.dart';
import 'features/detail/route/detail_routes.dart';

final GoRouter router = GoRouter(
  initialLocation: HomeRoutes.home,
  routes: [
    ...HomeRoutes.getPages(),
    ...DetailRoutes.getPages(),
    // Add additional routes as needed...
  ],
  // You can add error pages, redirect logic, etc. here.
);