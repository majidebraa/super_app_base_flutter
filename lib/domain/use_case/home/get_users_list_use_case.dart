

import '../../../data/model/user_dao.dart';
import '../../repositories/user_repository.dart';
import '../../utils/resources.dart';

class GetUsersListUseCase {
  final UserRepository userRepository;

  GetUsersListUseCase(this.userRepository);

  Stream<Resource<List<UserDao>>> execute() {
    return userRepository.fetchUsersList().map((resource){
      return resource;
    });
  }
}