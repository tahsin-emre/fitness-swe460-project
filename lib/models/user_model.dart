import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/core/constants/hive_types.dart';
import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveTypes.userModel)
class UserModel {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String phone;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? surname;
  @HiveField(4)
  String? image;
  @HiveField(5)
  double? weight;
  @HiveField(6)
  double? height;
  @HiveField(7)
  DateTime? birthDate;
  @HiveField(8)
  String? gender;
  @HiveField(9)
  double? bmi;
  @HiveField(10)
  String? fullname;

  UserModel();

  UserModel.temp(this.phone);

  UserModel.fromDS(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    phone = data['phone'];
    name = data['name'];
    surname = data['surname'];
    image = data['image'];
    weight = data['weight'];
    height = data['height'];
    birthDate = (data['birthDate'] as Timestamp?)?.toDate();
    gender = data['gender'];
    bmi = weight ?? 0 / pow(((height) ?? 1) / 100, 2);
    fullname = '$name $surname';
  }
}
