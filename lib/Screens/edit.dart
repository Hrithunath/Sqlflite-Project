import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlflite/model/user.dart';
import 'package:sqlflite/services/userServices.dart';

class update extends StatefulWidget {
  final User user;
  const update({Key? key, required this.user}) : super(key: key);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  final nameController = TextEditingController();

  final studyController = TextEditingController();

  final placeController = TextEditingController();

  final admissionController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  var userService = UserServices();
  File? imagepath;
  String? selectedimage;
  @override
  void initState() {
    setState(() {
      nameController.text = widget.user.name ?? '';
      studyController.text = widget.user.study ?? '';
      placeController.text = widget.user.place ?? '';
      admissionController.text = widget.user.admission ?? '';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: Text(
            'Details page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit user Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: imagepath != null
                          ? ClipOval(
                              child: Image.file(
                                imagepath!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                pickImageFromGallery();
                              },
                              icon: Icon(Icons.camera_alt_outlined),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Text('name'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'name is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: studyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('study'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'study is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: placeController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      label: Text('place'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'place is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: admissionController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('admission Number'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'admission Number is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.yellowAccent),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.yellowAccent)),
                          onPressed: () {},
                          child: Text(
                            'Clear',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      imagepath = File(returnedImage.path);
      selectedimage = returnedImage.path.toString();
    });
  }

  void forClear() {
    nameController.text = '';
    studyController.text = '';
    placeController.text = '';
    admissionController.text = '';
  }

  updateDetails() async {
    if (formkey.currentState!.validate()) {
      var user = User();
      user.id = widget.user.id;
      user.name = nameController.text;
      user.study = studyController.text;
      user.place = placeController.text;
      user.admission = admissionController.text;
      user.selectedImage = selectedimage;
      var result = await userService.updateUser(user);
      Navigator.pop(context, result);
    }
  }
}
