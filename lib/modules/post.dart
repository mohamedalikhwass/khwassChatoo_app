import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/layout/cubit/cubit.dart';

import '../layout/cubit/states.dart';

class AddPost extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CubitChat,States>(
      listener:(context, state) {

      },
      builder: (context, state) {
        var cubit = CubitChat.get(context);
        var model =CubitChat.get(context).userModel ;
        final TextEditingController textController =TextEditingController();
        final now = DateTime.now();
      return Scaffold(
        appBar: AppBar(
          title: Text('Create Post'),
          actions: [
            TextButton(
              onPressed: (){
                if(state is ChangePostImageSuccessState)
                  {
                    cubit.uploadPostImage(now.toString(), textController.text);
                    print('22222222222222');
                    print(cubit.postImage.toString());
                  }
                else
                  {
                    cubit.cratePost(now.toString(), textController.text);
                    print('11111111111111');
                  }

              },
              child: Text(
                'POST',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 5.0,),
          ],
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                if(state is UploadPostImageLoadingState || state is PostLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height:10 ),

                Row(
                  children:  [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(model!.image),
                      //backgroundImage: AssetImage('assets/images/mm.jpeg'),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      (model.name),
                         style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        fontWeight: FontWeight.bold,
                       ),
                      ),
                  ],
                ),
                Container(
                  height: 150,
                  child: TextFormField(
                    maxLines: 50,

                    controller: textController,
                    decoration:const InputDecoration(
                      hintText: 'Write a Caption ',
                      border:InputBorder.none,

                    ) ,
                  ),
                ),
                if(state is ChangePostImageSuccessState)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Image(image: FileImage(cubit.postImage!)),
                    IconButton(
                        onPressed: (){
                          cubit.getRemovePostImage();
                        },
                        icon: Icon(Icons.close),
                    ),
                  ],
                ),

                Row(

                  children: [
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Icon(Icons.photo,color: Colors.amber),
                            TextButton(
                                onPressed: (){
                                  cubit.getPostImage();
                                },
                                child:Text('Add Photo'),
                            ),

                          ]
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child:const Text('@ Add Tage'),
                      ),
                    ),
                  ],
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
