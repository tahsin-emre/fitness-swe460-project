import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/models/user_model.dart';

extension UserExtensions on UserModel {
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'phone': phone,
      'image': image,
      'weight': weight,
      'height': height,
      'birthDate': birthDate != null ? Timestamp.fromDate(birthDate!) : null,
      'gender': gender.index,
    };
  }
}
