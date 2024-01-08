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
  final NameController = TextEditingController();

  final ClassController = TextEditingController();

  final PlaceController = TextEditingController();

  final AdmissionController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  var userService = UserServices();
  File? imagepath;
  String? selectedimage;
  @override
  void initState() {
    setState(() {
      NameController.text = widget.user.name ?? '';
      ClassController.text = widget.user.Class ?? '';
      PlaceController.text = widget.user.place ?? '';
      AdmissionController.text = widget.user.admission ?? '';
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
                    'Add new users',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
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
                  SizedBox(
                    height: 13,
                  ),
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
                    controller: ClassController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Class'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Class is required';
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.yellowAccent),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Login',
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
    NameController.text = '';
    ClassController.text = '';
    PlaceController.text = '';
    AdmissionController.text = '';
  }

  UpdateDetails() async {
    if (formkey.currentState!.validate()) {
      var user = User();
      user.id = widget.user.id;
      user.name = NameController.text;
      user.Class = ClassController.text;
      user.place = PlaceController.text;
      user.admission = AdmissionController.text;
      user.selectedImage = selectedimage;
      var result = await userService.updateUser(user);
      Navigator.pop(context, result);
    }
  }
}
