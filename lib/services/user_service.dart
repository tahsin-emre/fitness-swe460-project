import 'dart:io' as io;

import 'package:fitness/core/extensions/user_ext.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/services/db.dart';

class UserService {
  static Future<UserModel?> getUserModel() async {
    var data = await DB.db.collection('users').doc(DB.auth.currentUser?.uid).get();
    if (data.exists) {
      return UserModel.fromDS(data);
    } else {
      return null;
    }
  }

  static Future<UserModel> register(UserModel tempUser) async {
    await DB.db.collection('users').doc(DB.auth.currentUser!.uid).set(tempUser.toMap());
    return (await getUserModel())!;
  }

  static Future<UserModel> changeProfilePic(io.File? ioFile) async {
    String? url;
    var ref = DB.storage.ref().child('img_profile').child(DB.auth.currentUser!.uid);
    if (ioFile != null) {
      await ref.putFile(ioFile);
      url = await ref.getDownloadURL();
      await DB.db.collection('users').doc(DB.auth.currentUser!.uid).update({'image': url});
    }
    return (await getUserModel())!;
  }

  static Future<UserModel> updateUser(num kg, num cm) async {
    await DB.db
        .collection('users')
        .doc(DB.auth.currentUser!.uid)
        .update({'weight': kg, 'height': cm});
    return (await getUserModel())!;
  }
}
