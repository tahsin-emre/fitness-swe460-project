import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DB {
  DB._();
  static var db = FirebaseFirestore.instance;
  static var auth = FirebaseAuth.instance;

  static Future appinit() async {}
}
