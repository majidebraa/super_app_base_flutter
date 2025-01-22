import '../../../data/model/user_dao.dart';
import '../../repositories/user_repository.dart';
import '../../utils/resources.dart';

class GetUserDetailsUseCase {
  final UserRepository userRepository;

  GetUserDetailsUseCase(this.userRepository);

  Stream<Resource<UserDao>> execute(String login) {
    return userRepository.fetchUserDetails(login).map((resource){
      return resource;
    });
  }
}