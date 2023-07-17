import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dg_fortune/src/enums/theme_type_enum.dart';
import 'package:dg_fortune/src/enums/user_type_enum.dart';
import 'package:dg_fortune/src/model/FortuneUser/components/notification_settings.dart';
import 'package:dg_fortune/src/model/FortuneUser/components/user_settings.dart';
import 'package:dg_fortune/src/model/FortuneUser/fortune_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
//get user
  Future<FortuneUser?> getFortuneUser() async {
    try {
      var userUid = FirebaseAuth.instance.currentUser!.uid;

      var fortuneUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .withConverter(fromFirestore: (snapshot, _) => FortuneUser.fromJson(snapshot.data()!), toFirestore: (fortuneuser, _) => fortuneuser.toJson())
          .get();

      if (fortuneUserData.data() == null) {
        print("data nulll");
        var credential = await FirebaseAuth.instance.signInAnonymously();
        var fortuneUser = FortuneUser.withInfo(
            userNo: credential.user!.uid,
            userName: "",
            userManifests: [],
            userEmail: "",
            userType: UserType.anon,
            userAiFortunes: [],
            userNextAiFortuneDate: Timestamp.fromDate(DateTime.now()),
            userMessageToken: "",
            userSettings:
                UserSettings(notificationSettings: NotificationSettings(surpriseNotification: true, fortuneReadyNotification: true, dailyNews: true), themeType: ThemeType.night));
        return fortuneUser;
      } else {
        return fortuneUserData.data();
      }
    } catch (e) {
      print(e);
      print("cat");

      var credential = await FirebaseAuth.instance.signInAnonymously();
      var fortuneUser = FortuneUser.withInfo(
          userNo: credential.user!.uid,
          userName: "",
          userManifests: [],
          userEmail: "",
          userType: UserType.anon,
          userAiFortunes: [],
          userNextAiFortuneDate: Timestamp.fromDate(DateTime.now()),
          userMessageToken: "",
          userSettings:
              UserSettings(notificationSettings: NotificationSettings(surpriseNotification: true, fortuneReadyNotification: true, dailyNews: true), themeType: ThemeType.night));
      return fortuneUser;
    }
  }

// signUp anon
  Future<FortuneUser?> signUpAnon() async {
    try {
      var credential = await FirebaseAuth.instance.signInAnonymously();
      var fortuneUser = FortuneUser.withInfo(
          userNo: credential.user!.uid,
          userName: "",
          userManifests: [],
          userEmail: "",
          userType: UserType.anon,
          userAiFortunes: [],
          userNextAiFortuneDate: Timestamp.fromDate(DateTime.now()),
          userMessageToken: "",
          userSettings:
              UserSettings(notificationSettings: NotificationSettings(surpriseNotification: true, fortuneReadyNotification: true, dailyNews: true), themeType: ThemeType.night));
      return fortuneUser;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
