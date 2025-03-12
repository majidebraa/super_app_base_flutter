import 'package:get/get.dart';
import '../../common/base/base_view_model.dart';
import '../../data/model/user_dao.dart';
import '../../domain/use_case/home/get_users_list_use_case.dart';
import '../../domain/utils/resources.dart';
import '../detail/route/detail_routes.dart';

class HomeViewModel extends BaseViewModel {
  final GetUsersListUseCase getUsersListUseCase;

  HomeViewModel(
    this.getUsersListUseCase,
  );



  final Rx<Resource<List<UserDao>>> _usersList = Resource<List<UserDao>>.loading().obs;

  Rx<Resource<List<UserDao>>> get usersList => _usersList;

  void getUsersList() {
    // Subscribe to the stream from the use case
    getUsersListUseCase.execute().listen((resource) {
      _usersList.value = Resource.success(resource.data); // Update the response with new data
    }, onError: (error) {
      _usersList.value = Resource.error(error.toString()); // Handle errors
    });
  }

  void navigateToDetailPage(String? login) {
    navigateTo(DetailRoutes.detail,arguments: login);
  }

  @override
  void onClose() {
    deleteBindingIfRegistered<GetUsersListUseCase>();
    super.onClose();
  }
}