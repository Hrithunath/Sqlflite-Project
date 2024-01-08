class User {
  int? id;
  String? name;
  String? Class;
  String? place;
  String? admission;
  String? selectedImage;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['Class'] = Class!;
    mapping['place'] = place!;
    mapping['admission'] = admission!;
    mapping['selectedImage'] = selectedImage;
    return mapping;
  }
}
