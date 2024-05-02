import 'dart:io';
import 'package:flutter/material.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/screens/LandingPage/landingServices.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class LandingUtils with ChangeNotifier{
  ConstantColors constantColors = ConstantColors();
  final picker = ImagePicker();
  late File userAvatar;
  File get getUserAvatar => userAvatar;
  late String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickerUserAvatar(BuildContext context, ImageSource source) async{
    final pickedUserAvatar = await picker.pickImage(source: source);
    pickedUserAvatar == null ? print('Select image') : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null ? Provider.of<LandingService>(context, listen: false).showUserAvatar(context) : print('Image upload error');
    notifyListeners();
  }

  Future selectAvatarOptionsSheet(BuildContext context) async{
    return showModalBottomSheet(context: context, builder: (context){
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              child: Divider(
                thickness: 4.0,
                color: constantColors.whiteColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: constantColors.bluColor,
                    child: Text('Gallery', style: TextStyle(
                      color: constantColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    )),
                    onPressed: (){
                    pickerUserAvatar(context, ImageSource.gallery)
                        .whenComplete((){
                          Navigator.pop(context);
                          Provider.of<LandingService>(context,listen: false).showUserAvatar(context);
                    });
                    }),
                MaterialButton(
                    color: constantColors.bluColor,
                    child: Text('Camera', style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                    )),
                    onPressed: (){
                      pickerUserAvatar(context, ImageSource.camera)
                          .whenComplete((){
                        Navigator.pop(context);
                        Provider.of<LandingService>(context,listen: false).showUserAvatar(context);
                      });
                    })
              ],
            )
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: constantColors.blueGrayColor,
          borderRadius: BorderRadius.circular(12.0)
        ),
      );
    });
  }
}