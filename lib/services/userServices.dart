import 'package:sqlflite/db_helper/repository.dart';
import 'package:sqlflite/model/user.dart';

class UserServices {
  late Repository repository;
  UserServices() {
    repository = Repository();
  }
  saveUser(User user) async {
    return await repository.insertData('user', user.userMap());
  }

  //Read All Users
  readAllUsers() async {
    return await repository.readData('user');
  }

  //editallusers
  updateUser(User user) async {
    return await repository.updateData('user', user.userMap());
  }

//delete user
  deleteUser(userId) async {
    return await repository.deleteDataById('user', userId);
  }
}
