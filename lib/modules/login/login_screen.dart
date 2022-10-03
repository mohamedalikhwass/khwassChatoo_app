import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khwass_chat/layout/home_layout.dart';
import 'package:khwass_chat/network/local/cache_helper.dart';
import '../../sheared/components/components.dart';
import '../../styles/colors.dart';
import '../register/regester_screen.dart';
import 'cubit_login/cubit.dart';
import 'cubit_login/states.dart';

class LoginScreen extends StatelessWidget {



    var emailControl =TextEditingController();
    var passwordControl =TextEditingController();
    var formKey= GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is LoginSuccessState)
          {

            CacheHelper.saveData(key: 'uId', value: state.uId).
            then((value)
            {
              navigatorTo(context, HomeLayout());
            });
            Fluttertoast.showToast(msg: 'Login Success',);

          }
          else if(state is LoginErrorState)
          {
            Fluttertoast.showToast(msg:state.error );

          }

        },
        builder: (context,state)
        {
          LoginCubit cubit =LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(

              title: (
                  Text(
                    'KhwassChat',
                    style: TextStyle(
                      color: defaultColor,
                      fontSize: 28,

                    ),
                  )
              ),
              
              actions: [
                TextButton(
                  onPressed:()
                  {
                    // navigatorTo(context,ShopLayOutApp());
                  } ,
                  child:const Text('SKIP') ,

                ),
              ],
            ),
            body:
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'You Welcome in KhwassChat',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: defaultColor,

                          ),
                        ),
                        const SizedBox(
                          height:25.0,
                        ),
                         //  const Image(
                         //     image:AssetImage('assets/images/m_1.png'),
                         //     fit: BoxFit.fill,
                         //   height: 200,
                         //   width: 200,
                         //
                         // ),
                        const CircleAvatar(
                          backgroundImage:AssetImage('assets/images/m_3.png') ,
                          radius: 80,
                        ),
                        const SizedBox(
                          height:20.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height:10.0,
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: defaultColor,

                          ),
                        ),
                        const SizedBox(
                          height:20.0,
                        ),

                        defaultTextForm(
                          control: emailControl,
                          icon: Icons.email,
                          textType: TextInputType.emailAddress,
                          labelText: 'Email',
                          validat:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Email must not be  Empty ';
                            }

                          },

                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextForm(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.loginUser(
                                  email: emailControl.text,
                                  password: passwordControl.text
                              );
                            }
                          },

                          validat:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Password must not short ';
                            }
                          },
                          suffixicon: cubit.iconShowPassword,

                          onPreased: ()
                          {
                            cubit.changePasswordIcon();
                          },
                          labelText: 'Password',
                          textType:TextInputType.visiblePassword,
                          icon: Icons.lock,
                          control: passwordControl,
                          obscure: cubit.isPassword,



                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! LoginLoadingState ,
                          builder:(context)
                          {
                            return defaultButton(
                              color: defaultColor,
                              function: (){
                                if(formKey.currentState!.validate()) {
                                  cubit.loginUser(
                                      email:emailControl.text,
                                      password: passwordControl.text
                                  );
                                }
                              },
                              text: 'login',
                              widith: double.infinity,
                              isUpperCase: true,

                            );
                          } ,
                          fallback: (context)=>const CircularProgressIndicator(),
                        ),
                        Row(
                          children: [
                            const Text(
                                'Don\'n have account ?'
                            ),
                            TextButton(onPressed: ()
                            {
                              navigatorToAndFinch(context,RegisterScreen());
                            },
                                child: const Text('Register')),
                            Spacer(),
                            TextButton(onPressed: ()
                            {
                              navigatorToAndFinch(context,RegisterScreen());
                            },
                                child: const Text(
                                    'Forget Password ',
                                    style: TextStyle(
                                        fontSize: 15,
                                    )
                                )),



                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}


