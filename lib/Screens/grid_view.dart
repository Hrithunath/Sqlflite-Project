import 'package:flutter/material.dart';
import 'package:sqlflite/model/user.dart';
import 'package:sqlflite/services/userServices.dart';

class grid_view extends StatefulWidget {
  const grid_view({super.key});

  @override
  State<grid_view> createState() => _grid_viewState();
}

class _grid_viewState extends State<grid_view> {
  late List<dynamic> _userList = [];
  final _userService = UserServices();
  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text('Grid View'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.list))],
      ),
      body: Center(
        child: Text('No Data'),
      ),
    );
  }

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    setState(() {
      _userList = users.map((user) {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.study = user['study'];
        userModel.place = user['place'];
        userModel.admission = user['admission'];
      }).toList();
    });
  }
}
