import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlflite/services/userServices.dart';
import 'package:sqlflite/model/user.dart';
import 'package:image_picker/image_picker.dart';

class create extends StatefulWidget {
  const create({super.key});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final NameController = TextEditingController();
  final studyController = TextEditingController();
  final PlaceController = TextEditingController();
  final AdmissionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var userService = UserServices();
  File? imagepath;
  String? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text(
          'Enter the details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
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
                        : ClipOval(
                            child: IconButton(
                              onPressed: () {
                                pickImageFromGallery();
                              },
                              icon: Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 13),
                TextFormField(
                  controller: NameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
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
                  controller: PlaceController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    label: Text('Place'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Place is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: AdmissionController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Admission Number'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Admission Number is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.yellowAccent),
                      ),
                      onPressed: () async {
                        saveData();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.yellowAccent)),
                      onPressed: () {
                        forclear();
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      imagepath = File(returnedImage.path);
      selectedImage = returnedImage.path.toString();
    });
  }

  void saveData() async {
    if (_formkey.currentState!.validate() && selectedImage != null) {
      var user = User();
      user.name = NameController.text;
      user.study = studyController.text;
      user.place = PlaceController.text;
      user.admission = AdmissionController.text;
      user.selectedImage = selectedImage;
      var result = await userService.saveUser(user);
      if (result != null) {
        Navigator.pop(context, true);
      } else {
        print('error');
      }
    }
  }

  void forclear() {
    NameController.text = '';
    studyController.text = '';
    PlaceController.text = '';
    AdmissionController.text = '';
  }
}
