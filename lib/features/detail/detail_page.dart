
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app_base_flutter/common/extension/context_extension.dart';
import 'package:super_app_base_flutter/common/extension/resource_ext.dart';
import '../../common/base/base_widget.dart';
import '../../common/constant/app_colors.dart';
import '../../common/constant/app_images.dart';
import '../../data/model/user_dao.dart';
import 'avatar_page.dart';
import 'detail_view_model.dart'; // Adjust import based on your project structure
import 'row_title_value_widget.dart'; // Adjust import based on your project structure

class DetailPage extends StatelessWidget {

  DetailPage({super.key});
  final detailViewModel = Get.find<DetailViewModel>();

  final String login = Get.arguments ?? 'No message received';

  @override
  Widget build(BuildContext context) {
    double coverHeight = 280;
    double profileHeight = 80;
    final top = coverHeight - profileHeight / 2;

    // Call getUsersDetails to fetch data when the widget is built
    detailViewModel.getUsersDetails(login);

    return BaseWidget(
      viewModel: detailViewModel,
      title: 'Details',
      showBackArrow: true,
      content: (context, padding) {
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            detailViewModel.getUsersDetails(login); // Refresh user details on pull down
          },
          child: Obx(() {
            final resource = detailViewModel.userDetails.value; // Assuming response holds the Resource

            return resource.when(
              success: (userDetail) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        backgroundWidget(coverHeight),
                        avatarWidget(context, userDetail, top, profileHeight), // Pass context here
                      ],
                    ),
                    const SizedBox(height: 50),
                    RowTitleValueWidget(
                      title: userDetail.login,
                      iconData: Icons.contact_page,
                      onRowClick: () {},
                    ),
                    RowTitleValueWidget(
                      title: userDetail.company,
                      iconData: Icons.account_balance,
                      onRowClick: () {},
                    ),
                    RowTitleValueWidget(
                      title: userDetail.blog,
                      iconData: Icons.link,
                      onRowClick: () {},
                    ),
                  ],
                ),
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

  Widget avatarWidget(BuildContext context, UserDao userDetail, double top, double profileHeight) {
    return Positioned(
      top: top,
      child: GestureDetector(
        child: CircleAvatar(
          radius: profileHeight / 2,
          backgroundImage: NetworkImage(userDetail.avatarUrl!),
        ),
        onTap: () {
          context.easeInOutTransition(AvatarPage(avatarUrl: userDetail.avatarUrl!)); // Ensure AvatarPage is defined
        },
      ),
    );
  }

  Widget backgroundWidget(double coverHeight) {
    return Container(
      color: AppColors.greyColor,
      child: Image.asset(
        AppImages.icBackground,
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
