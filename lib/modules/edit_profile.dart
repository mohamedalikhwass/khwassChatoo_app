import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/layout/cubit/cubit.dart';
import 'package:khwass_chat/modules/register/cubit_regester/cubit.dart';
import 'package:khwass_chat/sheared/components/components.dart';

import '../layout/cubit/states.dart';
import '../model/user_model.dart';

class EditProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitChat,States>(
      listener: (context, state) {

      },
      builder: (context, state) {

         var model =CubitChat.get(context).userModel ;
         var cubit =CubitChat.get(context) ;
         var profileImage =CubitChat.get(context).profileImage ;
         var coverImage =CubitChat.get(context).coverImage ;

         final TextEditingController nameController =
         TextEditingController.fromValue(TextEditingValue(text: model!.name));
         final TextEditingController emailController =
         TextEditingController.fromValue(TextEditingValue(text: model.email));
         final TextEditingController passwordController =
         TextEditingController.fromValue(TextEditingValue(text: model.password));
         final TextEditingController bioController =
         TextEditingController.fromValue(TextEditingValue(text: model.bio));
         final TextEditingController phoneController =
         TextEditingController.fromValue(TextEditingValue(text: model.phone));


        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            primary: true,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: Stack(
                      alignment:AlignmentDirectional.bottomCenter ,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              alignment:AlignmentDirectional.topCenter ,

                              child:coverImage == null? Image(
                                image:NetworkImage(model.cover) ,

                                width: double.infinity,
                                height: 190,

                              ) : Image(
                                image: FileImage(coverImage),
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                            IconButton(
                                onPressed: ()
                                {
                                  cubit.getCoverImage();
                                },
                                icon: Icon(Icons.camera_alt_outlined,color: Colors.amber,size: 30),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.white,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              CircleAvatar(
                                radius:80 ,

                                backgroundImage: cubit.profileImage ==null?NetworkImage(model.image) : FileImage(cubit.profileImage!) as ImageProvider,
                              ),
                              IconButton(
                                onPressed: ()
                                {
                                  cubit.getProfileImage();
                                },
                                icon: Icon(Icons.camera_alt_outlined,color: Colors.amber,size: 30),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [

                      if(state is ChangeProfileImageSuccessState)
                          Expanded(
                            child: defaultButton(
                                text: 'Update Profile',
                                widith: double.infinity,
                                fontSize: 18,

                                color: Colors.amber,
                                function: (){
                                  cubit.uploadProfileImage();
                                }
                            ),
                          ),
                      if(state is ChangeCoverImageSuccessState)
                      Expanded(
                        child: defaultButton(
                                    text: 'Update Cover',
                                    widith: double.infinity,
                                    fontSize: 18,

                                    color: Colors.amber,
                                    function: (){
                                      cubit.uploadCoverImage();
                                    }
                                ),
                      ),

                      if(state is UploadCoverImageLoadingState ||state is UploadProfileImageLoadingState )
                        Expanded(child: LinearProgressIndicator()),
                      // if(state is ChangeCoverImageSuccessState)
                      // Expanded(
                      //   child: Column(
                      //     children: [
                      //       if(state is UploadCoverImageLoadingState)
                      //       LinearProgressIndicator(),
                      //       SizedBox(height: 5),
                      //       defaultButton(
                      //           text: 'Update Cover',
                      //           widith: double.infinity,
                      //           fontSize: 18,
                      //
                      //           color: Colors.amber,
                      //           function: (){
                      //             cubit.uploadCoverImage();
                      //           }
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      
                    ],
                  ),
                  SizedBox(height: 10,),
                  defaultTextForm(
                    icon: Icons.drive_file_rename_outline,
                    control: nameController ,
                    textType: TextInputType.name,
                    labelText: 'Name',

                  ),
                  SizedBox(height: 10,),
                  defaultTextForm(
                    icon: Icons.email_outlined,
                    control: emailController,
                    textType: TextInputType.emailAddress,
                    labelText: 'Email',

                  ),
                  SizedBox(height: 10,),
                  defaultTextForm(
                    icon: Icons.password_outlined,
                    control: passwordController,
                    textType: TextInputType.visiblePassword,
                    obscure: cubit.isPassword,
                    suffixicon: cubit.iconShowPassword,
                      labelText: 'Password',

                    onPreased: (){
                      cubit.changePasswordIcon();
                    }
                    ),
                  SizedBox(height: 10,),
                  defaultTextForm(
                    icon: Icons.drive_file_rename_outline_rounded,
                    control: bioController,
                    textType: TextInputType.name,
                    labelText: 'Bio',

                  ),
                  SizedBox(height: 10,),
                  defaultTextForm(
                    icon: Icons.phone,
                    control: phoneController,
                    textType: TextInputType.phone,
                    labelText: 'Phone',

                  ),
                  SizedBox(height: 10,),
                  if(state is UpdateLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                  defaultButton(
                      text: 'Update',
                      widith:double.infinity ,
                      color: Colors.amber,
                      function: (){
                        cubit.updateUser(
                            nameController.text,
                            phoneController.text,
                            emailController.text,
                            passwordController.text,
                            bioController.text,
                        );
                      }
                  ),
                  

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
