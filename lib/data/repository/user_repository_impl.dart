import '../../domain/repositories/user_repository.dart';
import '../../domain/utils/resources.dart';
import '../local/local_data_source.dart';
import '../model/user_dao.dart';
import '../remote/const_helper.dart';
import '../remote/remote_module.dart';

class UserRepositoryImpl extends UserRepository{
  RemoteModule remoteModule;
  LocalDataSource localDataSource;
  UserRepositoryImpl(this.remoteModule,this.localDataSource);

  @override
  Stream<Resource<UserDao>> fetchUserDetails(String login) async* {
    try {
      dynamic response = await remoteModule
          .getResponse(
          userDetail + login,
          RequestType.get
      );
      UserDao user = UserDao.fromJson(response);
      yield Resource.success(user);
    }catch (exception) {
      yield Resource.error(exception.toString());
    }
  }

  @override
  Stream<Resource<List<UserDao>>> fetchUsersList() async* {
    try {
      dynamic response = await remoteModule
          .getResponse(
          "${searchUsers}q=majid&sort=followers", RequestType.get
      );
      final jsonData = response['items'] as List;
      List<UserDao> userList =
      jsonData.map((tagJson) => UserDao.fromJson(tagJson)).toList();
      yield Resource.success(userList);
    }catch (exception) {
      yield Resource.error(exception.toString());
    }
  }
  
  
}