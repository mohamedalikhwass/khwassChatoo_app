
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khwass_chat/layout/cubit/states.dart';
import 'package:khwass_chat/model/comments.dart';
import 'package:khwass_chat/model/messge_model.dart';
import 'package:khwass_chat/model/post_model.dart';
import 'package:khwass_chat/model/user_model.dart';
import 'package:khwass_chat/modules/chats.dart';
import 'package:khwass_chat/modules/home.dart';
import 'package:khwass_chat/modules/users.dart';
import 'package:khwass_chat/modules/settings.dart';

import '../../model/like-comment.dart';
import '../../modules/register/cubit_regester/cubit.dart';
import '../../sheared/components/constantes.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CubitChat extends Cubit<States>
{

  CubitChat():super (InitialState());




 static CubitChat get(context)=>BlocProvider.of(context);

      // bool showFap = MediaQuery.of(context).viewInsets.bottom !=0;

       UserModel? userModel;
       LikeCommentPost? likeCommentPost;


  void getUserData() {
    emit(LoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {

      userModel = UserModel.fromJson(value.data()!);
      emit(SuccessState());
      print(value.data());
    }).catchError((error) {
       print(error.toString());
      emit(ErrorState(error.toString()));
    });
  }


  int curantIndex =0;
  List<String>title =
  [
    'Home',
    'Chats',
    'Users',
    'Profile',
  ];

  List<Widget> screens =
  [
    Home(),
    Chats(),
    Users(),
    Setting(),
  ];

  void changeNavBar(index)
  {
    curantIndex =index;
    if(index == 0) {
      getPosts();
     }
   else if(index==1)
      {
        getUsers();
      }
    emit(ChangeNavBarState());


  }


  bool isPassword=true;
  IconData iconShowPassword=Icons.remove_red_eye;

  void changePasswordIcon()
  {
    isPassword = !isPassword;
    iconShowPassword=isPassword ?Icons.remove_red_eye:Icons.visibility_off;
    emit(ChangeIconPassword());
  }


  File? profileImage;
  var pickerProfile = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await pickerProfile.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChangeProfileImageSuccessState());

     } else {
      print('No image selected.');
      emit(ChangeProfileImageErrorState());
    }
  }


   File? coverImage;
  var pickerCover = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedFile = await pickerCover.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChangeCoverImageSuccessState());


    } else {
      print('No image selected.');
      emit(ChangeCoverImageErrorState());
    }
  }

  String? profileImageUrl;
  void uploadProfileImage()
  {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance.
    ref().child('profile/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).
    then((value){
      value.ref.getDownloadURL().
      then((value) {
        profileImageUrl =value;
        emit(UploadProfileImageSuccessState());
        updateUser(userModel!.name, userModel!.phone, userModel!.email, userModel!.password, userModel!.bio);
      }).catchError((error){
       emit(UploadProfileImageErrorState());
      });
    }).catchError((error){
      emit(UploadProfileImageErrorState());
    });
  }


  String? coverImageUrl ;
  void uploadCoverImage()
  {
    emit(UploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance.
    ref().child('cover/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).
    then((value){
      value.ref.getDownloadURL().
      then((value) {
        coverImageUrl =value;
        emit(UploadCoverImageSuccessState());
        updateUser(userModel!.name, userModel!.phone, userModel!.email, userModel!.password, userModel!.bio);
        print(value.toString());
      }).catchError((error){
        emit(UploadCoverImageErrorState());
        print('first error ${error.toString()}');
      });
    }).catchError((error){
      emit(UploadCoverImageErrorState());
      print(error.toString());
    });
  }



  void updateUser(
   String name,
   String phone,
   String email,
   String password,
   String bio,
  {
    String? image,
    String? cover,
  }

      )
  {

    emit(UpdateLoadingState());

      UserModel model = UserModel(
          name = name ,
          phone = phone,
          email = email,
          password = password,
          bio = bio,
          cover = coverImageUrl??userModel!.cover,
          image = profileImageUrl??userModel!.image,
          uId =uId,
      );
      FirebaseFirestore.instance.collection('users').doc(uId).update(model.createUsers())
          .then((value) {
        getUserData();
      })
          .catchError((error){
        emit(UpdateErrorState());
        print(error.toString());
      });


  }






  File? postImage;
  var pickerPost = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await pickerPost.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChangePostImageSuccessState());


    } else {
      print('No image selected.');
      emit(ChangePostImageErrorState());
    }
  }

  void getRemovePostImage()
  {
    postImage =null;
    emit(RemovePostImageSuccessState());
  }

  String? postImageUrl;
  void uploadPostImage(
      String dateTime,
      String text,
      )
  {
    emit(UploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance.
    ref().child('postImage/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).
    then((value){
      value.ref.getDownloadURL().
      then((value) {
        postImageUrl =value;
        emit(UploadPostImageSuccessState());
        cratePost(dateTime, text,postImage: postImageUrl);
      }).catchError((error){
        emit(UploadPostImageErrorState());
      });
    }).catchError((error){
      emit(UploadPostImageErrorState());
    });
  }


  void cratePost(


       String dateTime,
       String text,
  {
    String? name,
    String? image,
    String? uId,
    String? postImage,
 }

      )
  {

    emit(PostLoadingState());
    PostModel model = PostModel(
      name = userModel!.name ,
      image = userModel!.image,
      uId =userModel!.uId,
      dateTime = dateTime,
      text = text,
      postImage = postImage??'',

    );
    FirebaseFirestore.instance.collection('posts').add(model.createPost())
        .then((value) {
          emit(PostSuccessState());
    })
        .catchError((error){
      emit(PostErrorState());
      print(error.toString());
    });
  }


  List <PostModel> posts=[];
  List <String> postsId=[];
  List <int> likesNum=[];
  List <int> commentNum=[];
 // List <PostModel> posts=[];

  void getPosts()
  {
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime').snapshots().listen((event)
    {
      posts=[];
      event.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
      });
    });
    // then((value)
    // {
    //   value.docs.forEach((element) {
    //     element.reference.collection('likes').get().
    //     then((value){
    //       likesNum.add(value.docs.length);
    //       value.docs.forEach((element) {
    //         // LikeCommentPost.fromJson(element.data());
    //       });
    //      // likes.add(LikeCommentPost.fromJson(value.))
    //     }).
    //     catchError((error)
    //     {
    //     });
    //     element.reference.collection('comments').get().
    //     then((value)
    //     {
    //       commentNum.add(value.docs.length);
    //       posts.add(PostModel.fromJson(element.data()));
    //       postsId.add(element.id);
    //     }).
    //     catchError((error)
    //     {
    //
    //     });
    //   });
      // print(posts[1]);
    //   emit(GetPostSuccessState());
    // }).catchError((error)
    // {
    //   emit(GetPostErrorState());
    // });
  }


  void likePost(
  String postId,
      bool like,
      )
  {
    emit(LikePostLoadingState());
    LikeCommentPost model =LikeCommentPost(like = like);
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(userModel!.uId)
        .set(model.setLikeComment()
    ).then((value)
    {
      emit(LikePostSuccessState());
    }).catchError((error)
    {
      emit(LikePostErrorState());
    });
  }

  List<LikeCommentPost>likes=[];
  void getLikePost(
      String postId,
      )
  {
    emit(GetLikePostLoadingState());
   // LikeCommentPost model =LikeCommentPost(like = like);
    FirebaseFirestore.instance.collection('posts').doc().collection('likes').doc(userModel!.uId)
        .get().then((value)
    {
      likeCommentPost=LikeCommentPost.fromJson(value.data()!);
      likes.add(LikeCommentPost.fromJson(value.data()!));

      print(value.data().toString());
      emit(GetLikePostSuccessState());
    }).catchError((error)
    {
      emit(GetLikePostErrorState());
    });
  }


  void commentPost(
      String postId,
      String comment,
      )
  {
    emit(CommentPostLoadingState());
    CommentModel model = CommentModel(comment=comment);
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc(userModel!.uId)
        .set(
        model.setComment(),
    ).then((value)
    {
      emit(CommentPostSuccessState());
    }).catchError((error)
    {
      emit(CommentPostErrorState());
    });
  }





  List<UserModel> users=[];
  void getUsers()
  {
    emit(GetUsersLoadingState());
    if(users.length == 0) {
      FirebaseFirestore.instance.collection('users').
      snapshots().
      listen((event) {
        users=[];
      event.docs.forEach((element) {
        // if(element.data()['uId'] != userModel!.uId)
        users.add(UserModel.fromJson(element.data()));
        emit(GetUsersSuccessState());
      });
    });
          }
    // then((value)
    // {
    //   value.docs.forEach((element) {
    //    // if(element.data()['uId'] != userModel!.uId)
    //       users.add(UserModel.fromJson(element.data()));
    //
    //   });
    //
    //     emit(GetUsersSuccessState());
    //
    // }).catchError((error)
    // {
    //   emit(GetUsersErrorState());
    // });

  }





  void sendMessage(
  {
    String? sendId,
    String? receiverId,
    String? dateTime,
    String? text,
})
  {
    MessageModel model =MessageModel(
        sendId = userModel!.uId,
        receiverId = receiverId! ,
        dateTime = dateTime!,
        text = text!,
    );
    FirebaseFirestore.instance.collection('users').
    doc(userModel!.uId).
    collection('chat').
    doc(receiverId).
    collection('message').
    add(model.senMessageModel()).
    then((value)
    {
      emit(SendMessageSuccessState());
    } ).
    catchError((error)
    {
      emit(SendMessageErrorState());
    });
   if(sendId != receiverId) {
     FirebaseFirestore.instance.collection('users').
    doc(receiverId).
    collection('chat').
    doc(userModel!.uId).
    collection('message').
    add(model.senMessageModel()).
    then((value)
    {
      emit(SendMessageSuccessState());
    } ).
    catchError((error)
    {
      emit(SendMessageErrorState());
    });
   }
  }



  List<MessageModel> messages=[];
  void getMessage(String receiverId )
  {
    FirebaseFirestore.instance.
    collection('users').
    doc(userModel!.uId).
    collection('chat').
    doc(receiverId).
    collection('message').
    orderBy('dateTime').
    snapshots().
    listen((event)
    {
      messages=[];
      event.docs.forEach((element)
      {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });

  }


 Future <void> logeOut()
  async {
    await FirebaseAuth.instance.signOut();
    uId = '';

  }



}