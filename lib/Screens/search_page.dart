import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlflite/Screens/edit.dart';
import 'package:sqlflite/Screens/viewProfile.dart';
import 'package:sqlflite/model/user.dart';
import 'package:sqlflite/services/userServices.dart';

class search_page extends StatefulWidget {
  const search_page({super.key});

  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  late List<dynamic> _userList = [];
  late List<dynamic> _filteredUserList = [];
  final _userService = UserServices();
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: Text('Search Page'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchcontroller,
                decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
            Expanded(
                child: Container(
              child: _filteredUserList.isEmpty
                  ? Center(
                      child: Text('Not Found'),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewProfile(
                                          user: _filteredUserList[index]))),
                              leading: CircleAvatar(
                                backgroundImage: _filteredUserList[index]
                                                .selectedImage !=
                                            null &&
                                        File(_filteredUserList[index]
                                                .selectedImage!)
                                            .existsSync()
                                    ? FileImage(File(_filteredUserList[index]
                                            .selectedImage!))
                                        as ImageProvider<Object>?
                                    : const AssetImage(
                                        'assets/images/userProfile.png'),
                              ),
                              title: Text(
                                  _filteredUserList[index].name ?? 'No Name'),
                              subtitle: Text(
                                  _filteredUserList[index].Class ?? 'No Study'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => update(
                                                      user: _filteredUserList[
                                                          index],
                                                    ))).then((data) {
                                          if (data != null) {
                                            getAllUserDetails();
                                            showSnackBar(
                                                'User updated successfully');
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        DeleteFormShowDialog(context,
                                            _filteredUserList[index].id);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          )),
            ))
          ],
        ));
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
        userModel.selectedImage = user['selectedImage'];
        return userModel;
      }).toList();
      _filteredUserList = _userList;
    });
  }

  void filterUserList(String enteredKeyword) {
    List<dynamic> filteredList = _userList.where((user) {
      return user.name!.toLowerCase().contains(enteredKeyword.toLowerCase());
    }).toList();
    setState(() {
      _filteredUserList = filteredList;
    });
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  DeleteFormShowDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text('Are you sure you want to delete this?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancle')),
              TextButton(
                  onPressed: () async {
                    var result = await _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      showSnackBar('User Details Deleted succesfully');
                    }
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }
}
