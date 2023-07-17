// ignore_for_file: camel_case_types

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dg_fortune/src/bloc/fortune_user_cubit.dart';
import 'package:dg_fortune/src/model/FortuneUser/fortune_user.dart';
import 'package:dg_fortune/src/screen/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'src/screen/login/login_screen.dart';
import 'src/service/firebase/firebase_auth_services.dart';
import 'src/service/firebase/firebase_options.dart';

var fortuneUser;
Future<void> main() async {
  await init();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const FortuneApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: FirebaseOptionsClass.firebaseConfig);
  await appTracking();

  if (FirebaseAuth.instance.currentUser?.uid != null) {
    print("user var");
    print(FirebaseAuth.instance.currentUser?.uid);

    fortuneUser = await FirebaseAuthServices().getFortuneUser();
  } else {
    print("user yok");
    fortuneUser = await FirebaseAuthServices().signUpAnon();
  }
  /*
  await FirebaseAuthService.loggedCheck().then((value) => kmUser = value);
  await FirestoreOperations.kmSystemSettingsGetter().then((value) => systemSettings = value);*/
  //
}

Future<void> appTracking() async {
  if (await AppTrackingTransparency.trackingAuthorizationStatus == TrackingStatus.notDetermined) {
    // Show a custom explainer dialog before the system dialog
    //  await showCustomTrackingDialog(context);
    // Wait for dialog popping animation
    await Future.delayed(const Duration(milliseconds: 200));
    // Request system's tracking authorization dialog
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
}

class FortuneApp extends StatelessWidget {
  const FortuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: MultiBlocProvider(providers: [
          /*     BlocProvider(
            create: (context) => KmUserCubit(),
          ),*/
          BlocProvider(
            create: (context) => FortuneUserCubit(),
          ),
        ], child: const _cupertinoApp()),
      );
    }));
  }
}

class _cupertinoApp extends StatefulWidget {
  const _cupertinoApp({super.key});

  @override
  State<_cupertinoApp> createState() => __cupertinoAppState();
}

class __cupertinoAppState extends State<_cupertinoApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    if (fortuneUser != null) {
      context.read<FortuneUserCubit>().changeFortuneUser(fortuneUser);
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      routes: {
        //  "/": (BuildContext context) => isLogged == false ? const LoginScreen() : const HomeScreen(),
        "/": (BuildContext context) => const HomeScreen(),
        "/Home": (BuildContext context) => const HomeScreen(),
        "/Login": (BuildContext context) => const LoginScreen(),
      },
    );
  }
}
