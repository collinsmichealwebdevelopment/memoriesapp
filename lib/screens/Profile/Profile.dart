import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/screens/LandingPage/landingPage.dart';
import 'package:memories/screens/Profile/ProfileHelpers.dart';
import 'package:memories/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
 final ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFF100E20),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(EvaIcons.settings2Outline,
          color: constantColors.lightBlueColor),
        ),
        actions: [
          IconButton(
            icon: Icon(EvaIcons.logInOutline,
            color: constantColors.greenColor),
              onPressed: () {
                Provider.of<ProfileHelpers>(context, listen: false)
                    .logOutDialog(context);
              })
        ],
        backgroundColor: constantColors.blueGrayColor.withOpacity(0.4),
        title: RichText(
          text: TextSpan(
            text: 'My ',
            style: TextStyle(
              color: constantColors.whiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Profile',
                style: TextStyle(
                  color: constantColors.bluColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )
              )
            ]
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('user').doc(
              Provider.of<Authentication>(context,listen: false).getUserUid
            ).snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return new Column(
                  children: [
                    Provider.of<ProfileHelpers>(context, listen: false)
                    .headerProfile(context, snapshot.requireData ),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .divider(),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .middleProfile(context, snapshot),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .footerProfile(context, snapshot)
                  ],
                );
              }
            },
          ),
        ),
      ),
      ),
    );
  }
}