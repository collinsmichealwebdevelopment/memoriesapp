import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:memories/screens/landingpage/landingUtils.dart';
import 'package:memories/services/Authentication.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Firebaseoperations with ChangeNotifier{
   late UploadTask imageUploadTask;
   String? initUserEmail;
   String?  initUserName;
  String ? initUserImage;
   String? get getInitUserName =>
       initUserName;
   String? get getInitUserEmail =>
       initUserEmail;
   String? get getInitUserImage =>
       initUserImage;
  Future uploadUserAvatar(BuildContext context) async{
    Reference imageReference = FirebaseStorage.instance.ref().child(
      'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}'
    );
    imageUploadTask = imageReference.putFile(Provider.of<LandingUtils>(context, listen: false).getUserAvatar);
    await imageUploadTask.whenComplete((){
      print('Image uploaded');
    });
    imageReference.getDownloadURL().then((url){
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl = url.toString();
      print('the user profile avatar url => ${Provider.of<LandingUtils>(context, listen: false).userAvatarUrl}');
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
          print('Fetching user data');
          initUserName = doc['username'];
          initUserEmail = doc['useremail'];
          initUserImage = doc['userimage'];
          print(initUserName);
          print(initUserEmail);
          print(initUserImage);
          notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }

  Future deleteUserData(String userUid) async {
    return FirebaseFirestore.instance.collection('user').doc(userUid).delete();
  }

  Future addAward(String postId, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('awards')
        .add(data);
  }
}





