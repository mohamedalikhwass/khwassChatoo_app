import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/model/user_model.dart';
import 'package:khwass_chat/modules/register/cubit_regester/states.dart';

import '../../../network/end_points.dart';
import '../../../network/remote/dio_helper.dart';


class  RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);


  bool isPassword=true;
  IconData iconShowPassword=Icons.remove_red_eye;

  void changePasswordIcon()
  {
    isPassword = !isPassword;
    iconShowPassword=isPassword ?Icons.remove_red_eye:Icons.visibility_off;
    emit(ChangeRegisterIconPassword());
  }


  void registerUser(
  {

    required String name,
    required String phone,
    required String email,
    required String password,
})
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.
    createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      createUsers(uId:value.user!.uid ,name: name, phone: phone, email: email,password: password);
      //emit(RegisterSuccessState());
      print(value.user?.email);
      print(value.user?.uid);

    }).catchError((error){
      emit(RegisterErrorState(error));
      print(error);
    });
  }

  void createUsers(
  {
    required String name,
    required String phone,
    required String email,
    required String password,
     String? bio,
    String? cover,
    String? image,
    required String uId,
  })
  {
    UserModel model =UserModel(
      name = name,
      phone = phone,
      email = email,
      password =password,
      bio = 'Write a bio',
      cover ='https://www.instagram.com/p/CVakHETMTZS/',
      image ='https://www.instagram.com/p/CVakHETMTZS/',
      uId = uId,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.createUsers()).
    then((value)
    {
      emit(CreateUsersSuccessState());
    }).
    catchError((error)
    {
      emit(CreateUsersErrorState(error.toString()));
    });
  }



}