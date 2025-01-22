import 'package:get/get.dart';
import '../../common/base/base_view_model.dart';
import '../../data/model/user_dao.dart';
import '../../domain/use_case/detail/get_user_details_use_case.dart';
import '../../domain/use_case/home/get_users_list_use_case.dart';
import '../../domain/utils/resources.dart';

class DetailViewModel extends BaseViewModel {
  final GetUserDetailsUseCase getUserDetailsUseCase;

  DetailViewModel(
    this.getUserDetailsUseCase,
  );

  final Rx<Resource<UserDao>> _userDetails = Resource<UserDao>.loading().obs;

  Rx<Resource<UserDao>> get userDetails => _userDetails;

  void getUsersDetails(String login) {
    // Subscribe to the stream from the use case
    getUserDetailsUseCase.execute(login).listen((resource) {
      userDetails.value = Resource.success(resource.data); // Update the response with new data
    }, onError: (error) {
      userDetails.value = Resource.error(error.toString()); // Handle errors
    });
  }
}