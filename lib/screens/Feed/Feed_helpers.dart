import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/services/Authentication.dart';
import 'package:memories/utils/PostOptions.dart';
import 'package:provider/provider.dart';
import 'package:memories/utils/UploadPost.dart';

class FeedHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

   appBar(BuildContext context) {
    return AppBar(
      backgroundColor: constantColors.darkerColor,
      centerTitle: true,
      actions: [
        IconButton(
    icon: const Icon(Icons.camera_enhance_rounded),
          color: constantColors.greenColor,
            onPressed: (){
              Provider.of<UploadPost>(context,listen: false).selectPostImageType(context);
            })
      ],
      title:  RichText(
        text: TextSpan(
            text: 'Memories ',
            style: TextStyle(
              color: constantColors.whiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'feed',
                  style: TextStyle(
                    color: constantColors.bluColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  )
              )
            ]
        ),
      ),
    );
  }

  Widget feedBody(BuildContext context){
     return SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.only(top: 8.0),
         child: Container(
           child: StreamBuilder<QuerySnapshot>(
             stream: FirebaseFirestore.instance.collection('posts').snapshots(),
             builder: (context, snapshot){
               if(snapshot.connectionState == ConnectionState.waiting){
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               }
               else{
                 return loadPosts(context, snapshot);
               }
             },
           ),
           height: MediaQuery.of(context).size.height * 0.9,
           width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
             color: constantColors.darkColor,
             borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))
           ),
         ),
       ),
     );
  }

  Widget loadPosts(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
     return ListView(
         children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot){
       return Container(
        height: MediaQuery.of(context).size.height * 0.7,
         width: MediaQuery.of(context).size.width,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.only(top:8.0,left: 8.0),
               child: Row(
                 children: [
                   GestureDetector(
                     child: CircleAvatar(
                       backgroundColor: constantColors.blueGrayColor,
                       radius: 20.0,
                       backgroundImage: NetworkImage(
                           documentSnapshot ['userimage'] == null ? 'userimage':
                           documentSnapshot ['userimage']!),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left:8.0),
                     child: Container(
                       width: MediaQuery.of(context).size.width * 0.6,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             child: Text(
                               documentSnapshot ['caption'],
                               style: TextStyle(
                                 color: constantColors.greenColor,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16.0
                               ),
                             ),
                           ),
                           Container(
                             child: RichText(
                               text: TextSpan(
                                 text: documentSnapshot ['username'],
                                 style: TextStyle(
                                   color: constantColors.bluColor,
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.bold
                                 ),
                                 children: <TextSpan>[
                                   TextSpan(
                                     text: '12 hours ago',
                                     style: TextStyle(
                                       color: constantColors.lightColor.withOpacity(0.8)
                                     )
                                   )
                                 ]
                               ),)
                           )
                         ],
                       ),
                     ),
                   )
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top:8.0),
               child: Container(
                 height: MediaQuery.of(context).size.height * 0.46,
                 width: MediaQuery.of(context).size.width,
                 child: FittedBox(
                   child: Image.network(documentSnapshot ['postimage'], scale: 2,),
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top:8.0),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Container(
                       width: 80.0,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           GestureDetector(
                             onLongPress: (){
                               Provider.of<PostFunctions>(context, listen: false)
                                   .showLikes(context,
                                 documentSnapshot ['caption'],
                               );
                             },
                             onTap: (){
                               Provider.of<PostFunctions>(context, listen: false)
                                   .addLike(context, documentSnapshot ['caption'],
                                   Provider.of<Authentication>(context,listen: false).
                                   getUserUid == null ? 'useruid':
                                   Provider.of<Authentication>(context,listen: false).
                                   getUserUid!  );
                             },
                             child: Icon(
                               FontAwesomeIcons.heart,
                               color: constantColors.redColor,
                               size: 22.0,
                             ),
                           ),
                           StreamBuilder<QuerySnapshot>(
                             stream: FirebaseFirestore.instance
                                 .collection('posts')
                                 .doc(documentSnapshot['caption'])
                                 .collection('likes')
                                 .snapshots(),
                             builder: (context, snapshot){
                               if (snapshot.connectionState ==
                               ConnectionState.waiting){
                                 return Center(
                                   child: CircularProgressIndicator(),
                                 );
                               } else {
                                 return Padding(
                                     padding: const EdgeInsets.only(left: 8.0),
                                 child: Text(
                                   snapshot.data!.docs.length.toString(),
                                   style: TextStyle(
                                     color: constantColors.whiteColor,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18.0
                                   )
                                 ),);
                               }
                             }
                           )
                         ],
                       ),
                     ),
                     Container(
                       width: 80.0,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           GestureDetector(
                             onTap: (){
                               Provider.of<PostFunctions>(context, listen: false)
                                   .showCommentSheet(
                                   context, documentSnapshot,
                               documentSnapshot ['caption']);
                             },
                             child: Icon(
                               FontAwesomeIcons.comment,
                               color: constantColors.bluColor,
                               size: 22.0,
                             ),
                           ),
    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('posts')
        .doc(documentSnapshot['caption'])
        .collection('comment')
        .snapshots(),
    builder: (context, snapshot){
           if (snapshot.connectionState ==
           ConnectionState.waiting){
           return Center(
           child: CircularProgressIndicator(),
           );
           } else {
           return Padding(
           padding: const EdgeInsets.only(left: 8.0),
           child: Text(
           snapshot.data!.docs.length.toString(),
           style: TextStyle(
           color: constantColors.whiteColor,
           fontWeight: FontWeight.bold,
           fontSize: 18.0
           )
           ),);
           }
           }
    )
                         ],
                       ),
                     ),
                     Container(
                       width: 80.0,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           GestureDetector(
                             onTap: (){
                               Provider.of<PostFunctions>(context, listen: false)
                                   .showRewards(context, documentSnapshot['caption']);
                             },
                             child: Icon(
                               FontAwesomeIcons.award,
                               color: constantColors.redColor,
                               size: 22.0,
                             ),
                           ),
                           StreamBuilder<QuerySnapshot>(
                               stream: FirebaseFirestore.instance
                                   .collection('posts')
                                   .doc(documentSnapshot['caption'])
                                   .collection('awards')
                                   .snapshots(),
                               builder: (context, snapshot){
                                 if (snapshot.connectionState ==
                                     ConnectionState.waiting){
                                   return Center(
                                     child: CircularProgressIndicator(),
                                   );
                                 } else {
                                   return Padding(
                                     padding: const EdgeInsets.only(left: 8.0),
                                     child: Text(
                                         snapshot.data!.docs.length.toString(),
                                         style: TextStyle(
                                             color: constantColors.whiteColor,
                                             fontWeight: FontWeight.bold,
                                             fontSize: 18.0
                                         )
                                     ),);
                                 }
                               }
                           )
                         ],
                       ),
                     ),
                     Spacer(),
                     Provider.of<Authentication>(context,listen: false).getUserUid ==
                         documentSnapshot ['useruid'] ? IconButton(
                         icon: Icon(EvaIcons.moreVertical,
                           color: constantColors.whiteColor,),
                         onPressed: (){})
                         : Container(width: 0.0, height: 0.0,)
                   ],
                 ),
               ),
             ),

           ],
         ),
       );
    }
         ).toList()
     );}
}