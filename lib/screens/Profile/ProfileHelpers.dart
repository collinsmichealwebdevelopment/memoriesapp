import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/screens/LandingPage/landingPage.dart';
import 'package:memories/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfileHelpers with ChangeNotifier{
  ConstantColors constantColors = ConstantColors();
  Widget headerProfile(BuildContext context,DocumentSnapshot snapshot) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.3,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 220.0,
            width: 180.0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: constantColors.transparent,
                    radius: 60.0,
                    backgroundImage:
                    NetworkImage(snapshot ['userimage'] ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(snapshot ['username'], style: TextStyle(
                      color: constantColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),),),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(EvaIcons.email, color: constantColors.greenColor,
                        size: 16,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(snapshot ['useremail'], style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0
                        ),),),
                    ],),)
              ],
            ),
          ),
          Container(
            width: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: constantColors.darkColor,
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          height: 60.0,
                          width: 70.0,
                          child: Column(
                            children: [
                              Text('0', style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0
                              ),),
                              Text('Followers', style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0
                              ),)
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: constantColors.darkColor,
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          height: 70.0,
                          width: 80.0,
                          child: Column(
                            children: [
                              Text('0', style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0
                              ),),
                              Text('Following', style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0
                              ),)
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: constantColors.darkColor,
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      height: 70.0,
                      width: 80.0,
                      child: Column(
                        children: [
                          Text('0', style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0
                          ),),
                          Text('Posts', style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0
                          ),)
                        ],
                      ),
                    )
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget divider(){
    return Center(
      child: SizedBox(
        height: 25.0,
        width: 350.0,
        child: Divider(
          color: constantColors.whiteColor,
        ),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(FontAwesomeIcons.userAstronaut,
                color: constantColors.greenColor, size: 16),
                Text('Recently Added',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: constantColors.whiteColor
                ),)
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.darkColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15.0)
            ),
          ),
      )
        ],
      ),
    );
  }

  Widget footerProfile(BuildContext context, dynamic snapshot){
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('No images here',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: constantColors.bluColor
              ),),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: constantColors.darkColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(5.0)
        ),
      ),
    );
  }

  logOutDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: constantColors.darkColor,
        title: Text('Log out of memories?', style: TextStyle(
          color: constantColors.whiteColor,
          fontSize: 16.0,
          fontWeight: FontWeight.bold
        ),),
        actions: [
          MaterialButton(
              child: Text('No',style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  decorationColor: constantColors.whiteColor,
                  decoration: TextDecoration.underline
              ),),
              onPressed: () {
                Navigator.pop(context);
              }),
          MaterialButton(
            color: constantColors.redColor,
              child: Text('Yes',style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
              ),),
              onPressed: () {
                Provider.of<Authentication>(context, listen: false)
                    .logOutViaEmail()
                    .whenComplete(() {
                  Navigator.pushReplacement(
                      context, PageTransition(
                      child: Landingpage(),
                      type: PageTransitionType.bottomToTop
                  ));
                });
              })
        ],
      );
    });
  }
}