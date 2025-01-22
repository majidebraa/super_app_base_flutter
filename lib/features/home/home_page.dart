
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app_base_flutter/common/extension/resource_ext.dart';
import '../../common/base/base_widget.dart';
import 'home_view_model.dart';
import 'user_list_view_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {

    // Call getUsersList to fetch data when the widget is built
    homeViewModel.getUsersList();

    return BaseWidget(
      viewModel: homeViewModel,
      title: 'Home',
      showBackArrow: false,
      content: (context, padding) {
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            homeViewModel.getUsersList(); // Refresh user list on pull down
          },
          child: Obx(() {
            final resource = homeViewModel.usersList.value; // Assuming response holds the Resource

            return resource.when(
              success: (userList) => UserListViewWidget(
                userList: userList,
                onItemClick: onUserItemClick,
              ),
              error: (error) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          }),
        );
      },
      bottomBar: null, // You can add a bottom bar if needed
    );
  }

  void onUserItemClick(int position) {
    // Navigate to detail page with user login
    // Assuming userList is accessible in this scope or passed as a parameter
    final userList = homeViewModel.usersList.value.data; // Adjust based on your implementation
    if (userList != null && position < userList.length) {
      final login = userList[position].login; // Assuming UserDao has a login property
      homeViewModel.navigateToDetailPage(login); // Navigate to DetailPage with login
    }
  }
}

