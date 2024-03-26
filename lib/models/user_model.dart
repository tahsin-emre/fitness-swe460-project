import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/core/constants/hive_types.dart';
import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveTypes.userModel)
class UserModel {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String surname;
  @HiveField(3)
  late String fullname;
  @HiveField(4)
  late String phone;
  @HiveField(5)
  String? image;

  UserModel();

  UserModel.fromDS(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    name = data['name'] ?? '';
    surname = data['surname'] ?? '';
    fullname = '$name $surname';
    phone = data['phone'] ?? '';
    image = data['image'];
  }
}
