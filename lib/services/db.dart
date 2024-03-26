import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DB {
  static late FirebaseApp app;
  static var db = FirebaseFirestore.instance;
  static var auth = FirebaseAuth.instance;

  DB._();
}
