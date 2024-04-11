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

  static Future<UserModel> updateUser(num kg, num cm) async {
    await DB.db
        .collection('users')
        .doc(DB.auth.currentUser!.uid)
        .update({'weight': kg, 'height': cm});
    return (await getUserModel())!;
  }
}
