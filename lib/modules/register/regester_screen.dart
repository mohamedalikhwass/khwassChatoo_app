import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khwass_chat/layout/home_layout.dart';
import 'package:khwass_chat/modules/login/login_screen.dart';
import '../../../styles/colors.dart';
import '../../sheared/components/components.dart';
import 'cubit_regester/cubit.dart';
import 'cubit_regester/states.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class RegisterScreen extends StatelessWidget {

  late var nameControl =TextEditingController();
  late var phoneControl =TextEditingController();
  late var emailControl =TextEditingController();
  late var passwordControl =TextEditingController();

  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener:(context, state) {

          if(state is CreateUsersSuccessState)
            {
              navigatorToAndFinch(context, HomeLayout());
            }
          // {
          //   Fluttertoast.showToast(msg: 'RegisterSuccess',);
          //
          // }
          // else if(state is RegisterErrorState)
          // {
          //   Fluttertoast.showToast(msg:state.error );
          // }

        } ,
        builder: (context,state)
        {

          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: (
                    Text(
                      'Khwass',
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 28,

                      ),
                    )
                ),
              ),

              actions: [
                TextButton(
                  onPressed:()
                  {
                   // print(cubit.)
                  } ,
                  child:Text('SKIP') ,

                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child:Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: defaultColor,

                          ),
                        ),
                        SizedBox(
                          height:40.0,
                        ),
                        defaultTextForm(
                          control: nameControl,
                          icon: Icons.person_rounded,
                          textType: TextInputType.name,
                          labelText: 'Name',
                          validat:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Name must not be  Empty ';
                            }

                          },

                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextForm(
                          control: phoneControl,
                          icon: Icons.phone,
                          textType: TextInputType.phone,
                          labelText: 'Phone Number',
                          validat:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return ' Phone Number must not be  Empty ';
                            }

                          },

                        ),
                        SizedBox(
                          height: 20.0,
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
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextForm(
                          // onFieldSubmitted: (value) {
                          //   if (formKey.currentState.validate()) {
                          //     cubit.loginUser(
                          //         email: emailControl.text,
                          //         password: passwordControl.text
                          //     );
                          //   }
                          //
                          // },

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
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! RegisterLoadingState ,
                          builder:(context)
                          {
                            return defaultButton(
                              color: defaultColor,
                              function: (){
                                if(formKey.currentState!.validate()) {
                                  cubit.registerUser(
                                      name:nameControl.text,
                                      phone:phoneControl.text,
                                      email:emailControl.text,
                                      password: passwordControl.text
                                  );
                                }

                              },
                              text: 'Register',
                              widith: double.infinity,
                              isUpperCase: true,

                            );
                          } ,
                          fallback: (context)=>const CircularProgressIndicator(),
                        ),
                        Row(
                          children: [
                            Text(
                                'I\'m have account ?'
                            ),
                            TextButton(onPressed: ()
                            {
                              navigatorToAndFinch(context,LoginScreen());
                            },
                                child: Text('Login')),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );

  }
}
