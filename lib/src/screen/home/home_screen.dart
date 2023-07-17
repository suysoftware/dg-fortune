import 'dart:math';
import 'package:dg_fortune/src/bloc/fortune_user_cubit.dart';
import 'package:dg_fortune/src/screen/home/components/falling_stars.dart';
import 'package:dg_fortune/src/service/firebase/firestore_operations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  var t1 = TextEditingController();
  late AnimationController _controller;
  List<Star> stars = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color(0xFF0A0118),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              FallingStars(),
              buildStars(),
              buildTopText(),
              buildPurpleEarth(),
              buildCenterText(),
              buildBottomTextField(),
              buildSendManifestButton(context.read<FortuneUserCubit>().state.userNo),
            ],
          ),
        ));
  }

  Positioned buildPurpleEarth() {
    return Positioned(
      top: MediaQuery.of(context).viewInsets.bottom == 0 ? 16.h : 45.h,
      left: 100.w / 2 - 150,
      child: GestureDetector(
        onTap: () async {
         await FirestoreOperations.getAiFortune(context.read<FortuneUserCubit>().state.userNo);
        },
        child: SvgPicture.asset(
          "assets/svg/purple_earth.svg",
          height: 300,
          width: 300,
        ),
      ),
    );
  }

  Visibility buildCenterText() {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: Positioned(
          top: 60.h,
          left: 100.w / 2 - 158,
          child: GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: SizedBox(
              width: 316,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(color: CupertinoColors.white, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: '“Huzur içinde bir hayat yaşıyorum. Huzur ve mutluluğu kendime çekiyorum.”',
                        style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.white, fontSize: 16)),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Positioned buildBottomTextField() {
    return Positioned(
        top: 90.h,
        left: 3.w,
        child: Container(
            height: 5.h,
            width: 80.w,
            child: CupertinoTextField(
              maxLines: 2,
              minLines: 1,
              textInputAction: TextInputAction.send,
              placeholder: "  Type something...",
              placeholderStyle: TextStyle(color: CupertinoColors.systemGrey6, fontSize: 16),
              style: TextStyle(color: CupertinoColors.white, fontSize: 16),
              controller: t1,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: CupertinoColors.white,
              decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(12)), border: Border.all(color: CupertinoColors.white), color: Colors.transparent),
            )));
  }

  buildSendManifestButton(String userUid) {
    return Positioned(
        top: 89.h,
        left: 85.w,
        child: CupertinoButton(
            child: Icon(CupertinoIcons.add),
            onPressed: () async {
              var manifestMessage = t1.text;
              t1.clear();

              await FirestoreOperations.sendManifestMessage(manifestMessage, userUid);
            }));
  }
}

buildFallingStars() {
  return Positioned(
    top: 100,
    left: 100,
    child: SvgPicture.asset(
      "assets/svg/falling_star_2_r.svg",
      height: 300,
      width: 150,
    ),
  );
}

Positioned buildTopText() {
  return Positioned(
    top: 13.h,
    left: 100.w / 2 - 110,
    child: const SizedBox(
      width: 220,
      child: Text(
        "TIME TO MANIFEST",
        style: TextStyle(color: CupertinoColors.white, fontSize: 24),
      ),
    ),
  );
}

Positioned buildStars() {
  return Positioned(
    child: SvgPicture.asset(
      "assets/svg/stars.svg",
      height: 100.h,
      width: 100.w,
    ),
  );
}
