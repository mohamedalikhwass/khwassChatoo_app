import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/model/user_model.dart';
import 'package:khwass_chat/modules/login/cubit_login/states.dart';

import '../../../network/end_points.dart';
import '../../../network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);

  // ChatLoginModel loginModel;


  bool isPassword=true;
  IconData iconShowPassword=Icons.remove_red_eye;


  void changePasswordIcon()
  {
    isPassword = !isPassword;
    iconShowPassword=isPassword ?Icons.remove_red_eye:Icons.visibility_off;
    emit(ChangeIconPassword());
  }


  void loginUser(
  {
  required String email,
  required String password,
})
  {
    emit(LoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   ).then((value) {
     emit(LoginSuccessState(value.user!.uid));
     print(value.user!.uid);
   }).
    catchError((error)
   {
     emit(LoginErrorState(error.toString()));
     print('error$error');
   });
  }


}