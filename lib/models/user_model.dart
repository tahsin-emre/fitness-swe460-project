import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/core/constants/hive_types.dart';
import 'package:fitness/core/enums/gender_enum.dart';
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
  num? weight;
  @HiveField(6)
  num? height;
  @HiveField(7)
  DateTime? birthDate;
  @HiveField(8)
  Genders gender = Genders.none;
  @HiveField(9)
  num? bmi;
  @HiveField(10)
  String? fullname;
  @HiveField(11)
  num? dailyCalorie;

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
    gender = Genders.values[data['gender'] ?? 0];
    bmi = bmiCalc(weight ?? 0, height ?? 1);
    fullname = '$name $surname';
    dailyCalorie = calorieCalc(weight ?? 0, height ?? 1, gender);
  }

  num bmiCalc(num w, num h) {
    return w / ((h * h) / 10000);
  }

  num calorieCalc(num w, num h, Genders gender) {
    num lmb = 0;
    if (gender == Genders.male) {
      lmb = 0.407 * w + 0.267 * h - 19.2;
    } else if (gender == Genders.female) {
      lmb = 0.252 * w + 0.473 * h - 48.3;
    }
    return 370 + (21.6 * lmb);
  }
}
