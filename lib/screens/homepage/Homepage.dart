import 'package:flutter/material.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/screens/Chatroom/Chatroom.dart';
import 'package:memories/screens/Feed/Feed.dart';
import 'package:memories/screens/Profile/Profile.dart';
import 'package:memories/services/Firebaseoperations.dart';
import 'package:provider/provider.dart';
import 'package:memories/screens/homepage/HomepageHelpers.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initState(){
    Provider.of<Firebaseoperations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColors.darkColor,
      body: PageView(
        controller: homepageController,
        children: [
          Feed(),
          Chatroom(),
          Profile()
        ],
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState((){
            pageIndex = page;
          });
        },
      ),
        bottomNavigationBar: Provider.of<HomepageHelpers>(context, listen: false)
      .bottomNavBar(context, pageIndex, homepageController),
    );
  }
}
