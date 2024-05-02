import 'dart:core';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/services/Firebaseoperations.dart';
import 'package:provider/provider.dart';

class HomepageHelpers with ChangeNotifier{
  ConstantColors constantColors = ConstantColors();
  Widget bottomNavBar(
      BuildContext context, int index,PageController pageController){
    return CustomNavigationBar(
      currentIndex: index,
        bubbleCurve: Curves.bounceIn,
        scaleCurve: Curves.decelerate,
        selectedColor: constantColors.bluColor,
        unSelectedColor: constantColors.whiteColor,
        strokeColor: constantColors.bluColor,
        scaleFactor: 0.5,
        iconSize: 30.0,
        onTap: (val){
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
        },
        backgroundColor: const Color(0xff040307),
        items: [
          CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
          CustomNavigationBarItem(icon: Icon(Icons.message_rounded)),
          CustomNavigationBarItem(icon: CircleAvatar(
            radius: 35.0,
            backgroundColor: constantColors.blueGrayColor,
            backgroundImage:
            NetworkImage(
    Provider.of<Firebaseoperations>(context,listen: false).
    getInitUserImage == null ? 'userimage':
    Provider.of<Firebaseoperations>(context,listen: false).
                getInitUserImage!),
          )
    ),
        ]);

  }
}