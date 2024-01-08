import 'package:flutter/material.dart';
import 'package:sqlflite/Screens/create.dart';
import 'package:sqlflite/Screens/edit.dart';
import 'package:sqlflite/Screens/grid_view.dart';
import 'package:sqlflite/Screens/search_page.dart';
import 'package:sqlflite/Screens/viewProfile.dart';
import 'package:sqlflite/services/userServices.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  late List<dynamic> _userList = [];
  final userService = UserServices();
  getAlluserDetails() async {
    var users = await userService.readAllUsers();
    setState(() {
      _userList = users.map((user) {
        var userModel = user();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.Class = user['Class'];
        userModel.place = user['place'];
        userModel.admission = user['admission'];
        userModel.selectedImage = user['selectedImage'];
        return userModel;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getAlluserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => search_page()));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => grid_view()));
              },
              icon: Icon(Icons.grid_view))
        ],
      ),
      body: Container(
          child: _userList.isEmpty
              ? Center(
                  child: Text('No Data'),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(9),
                  itemCount: _userList.length,
                  itemBuilder: (context, index) => Card(
                        elevation: 5,
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProfile(
                                        user: _userList[index],
                                      ))),
                          leading: CircleAvatar(),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => update(
                                                user: _userList[index],
                                              )),
                                    ).then((data) {
                                      if (data != null) {
                                        getAlluserDetails();
                                        showSnackBar('User Update succesfully');
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    deleteFormShowDialouge(
                                        context, _userList[index].id);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => create()),
          ).then((data) {
            if (data != null) {
              getAlluserDetails();
              showSnackBar('User added successfully');
            }
          });
        },
        backgroundColor: Colors.yellowAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  deleteFormShowDialouge(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text('Are you sure you want to delete this?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    var result = await userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAlluserDetails();
                      showSnackBar('User Details Deleted succesfully');
                    }
                  },
                  child: Text('Delete')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
            ],
          );
        });
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
