import 'dart:math';

import 'package:dg_fortune/src/screen/home/components/falling_stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        child: Stack(
          children: [
            FallingStars(),
            buildStars(),
            buildTopText(),
            buildPurpleEarth(),
            buildCenterText(),
            buildBottomTextField(),
          ],
        ));
  }

  Positioned buildTopText() {
    return Positioned(
      top: 16.h,
      left: 100.w / 2 - 150,
      child: SvgPicture.asset(
        "assets/svg/purple_earth.svg",
        height: 300,
        width: 300,
      ),
    );
  }

  Positioned buildCenterText() {
    return Positioned(
        top: 53.h,
        left: 100.w / 2 - 158,
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
        ));
  }

  Positioned buildBottomTextField() {
    return Positioned(
        top: 70.h,
        left: 5.w,
        child: Container(
            height: 5.h,
            width: 90.w,
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

Positioned buildPurpleEarth() {
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
