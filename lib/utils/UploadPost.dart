import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/services/Authentication.dart';
import 'package:memories/services/Firebaseoperations.dart';
import 'package:provider/provider.dart';


class UploadPost with ChangeNotifier {
  TextEditingController captionController = TextEditingController();
  final picker = ImagePicker();
  ConstantColors constantColors = ConstantColors();
  late File uploadPostImage;
  File get getUploadImage => uploadPostImage;
  late String uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  late UploadTask imagePostUploadTask;


  Future pickerUploadPostImage(BuildContext context, ImageSource source) async{
    final uploadPostImageVal = await picker.pickImage(source: source);
    uploadPostImageVal == null
        ? print('Select image') : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImageVal?.path);

    uploadPostImage!= null
        ? showPostImage(context)
        : print('Image upload error');
    notifyListeners();
  }

  Future uploadPostImageToFirebase() async{
    Reference imageReference = FirebaseStorage.instance.ref().child(
      'posts/${uploadPostImage.path}/${TimeOfDay.now()}'
    );
    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() {
      print('Post image uploaded to storage');
    });
    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print('uploadPostImageUrl');
    });
    notifyListeners();

  }
  selectPostImageType(BuildContext context){
    return showModalBottomSheet(context: context, builder: (context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: constantColors.blueGrayColor,
        borderRadius: BorderRadius.circular(12)
      ),
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
                     fontSize: 16.0
                   ),),
                   onPressed: () {
                   pickerUploadPostImage(context, ImageSource.gallery);
                   }),
               MaterialButton(
                   color: constantColors.bluColor,
                   child: Text('Camera', style: TextStyle(
                       color: constantColors.whiteColor,
                       fontWeight: FontWeight.bold,
                       fontSize: 16.0
                   ),),
                   onPressed: () {
                     pickerUploadPostImage(context, ImageSource.camera);
                   })
             ],
           )
        ],
      ),
    );

  }
    );
  }

  showPostImage(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context){
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.5,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
            color: constantColors.darkColor,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              child: Divider(
                thickness: 4.0,
                color: constantColors.whiteColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Image.file(uploadPostImage,fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      child: Text('Reselect', style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: constantColors.whiteColor
                      ),),
                      onPressed: () {
                        selectPostImageType(context);
                      }),
                  MaterialButton(
                      color: constantColors.bluColor,
                      child: Text('Confirm Image', style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),),
                      onPressed: () {
                        uploadPostImageToFirebase().whenComplete(() {
                          editPostSheet(context);
                          print('Image uploaded');
                        });
                      })
                ],
              ),
            )
          ],
        ),
      );
    }
    );
  }

  editPostSheet(BuildContext context){
    return showModalBottomSheet(
      isScrollControlled: true,
        context: context, builder: (context){
      return Padding(
        padding:  EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: constantColors.blueGrayColor,
            borderRadius: BorderRadius.circular(12.0)
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: constantColors.whiteColor,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.image_aspect_ratio,
                            color: constantColors.greenColor,),
                              onPressed: (){}),
                          IconButton(
                              icon: Icon(Icons.fit_screen,
                                color: constantColors.yellowColor,),
                              onPressed: (){}),
                        ],
                      ),
                    ),
                    Container(
                      height: 120.0,
                      width: 300.0,
                      child: Image.file(uploadPostImage, fit: BoxFit.contain,),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset('asset/icons/logo.jpg'),
                    ),
                    Container(
                      height: 110.0,
                      width: 5.0,
                      color: constantColors.bluColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                        height: 120.0,
                        width: 300.0,
                        child: TextField(
                          maxLines: 5,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          maxLength: 100,
                          controller: captionController,
                          style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                            hintText: 'Add a caption...',
                            hintStyle: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                child: Text(
                  'Share',
                  style: TextStyle(
                    color: constantColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  ),
                ),
                  onPressed: () async{
                  Provider.of<Firebaseoperations>(context, listen: false).uploadPostData(
                    captionController.text,{
                      'postimage': getUploadPostImageUrl,
                      'caption':captionController.text,
                    'username': Provider.of<Firebaseoperations>(context, listen: false).getInitUserName,
                    'userimage': Provider.of<Firebaseoperations>(context, listen: false).getInitUserImage,
                    'useruid': Provider.of<Authentication>(context,listen: false).getUserUid,
                    'time': Timestamp.now(),
                    'useremail': Provider.of<Firebaseoperations>(context, listen: false).getInitUserEmail,
                  }
                  ).whenComplete((){
                    Navigator.pop(context);
                  });
                  },
              color: constantColors.bluColor,)
            ],
          ),
        ),
      );
    });
  }

}