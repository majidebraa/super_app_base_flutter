import '../../data/model/user_dao.dart';
import '../utils/resources.dart';

abstract class UserRepository{
  Stream<Resource<List<UserDao>>> fetchUsersList();
  Stream<Resource<UserDao>> fetchUserDetails(String login);
}