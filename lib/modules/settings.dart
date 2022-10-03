import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/layout/cubit/cubit.dart';
import 'package:khwass_chat/modules/edit_profile.dart';
import 'package:khwass_chat/modules/login/login_screen.dart';
import 'package:khwass_chat/modules/post.dart';
import 'package:khwass_chat/modules/register/cubit_regester/cubit.dart';
import 'package:khwass_chat/sheared/components/components.dart';

import '../layout/cubit/states.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';

class Setting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitChat,States>(
      listener: (context, state) {

      },
      builder: (context, state) {

        var model =CubitChat.get(context).userModel ;
        var cubit = CubitChat.get(context);
       return Padding(
         padding: const EdgeInsets.all(6.0),
         child: SingleChildScrollView(
           physics: BouncingScrollPhysics(),
           child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Stack(
                    alignment:AlignmentDirectional.bottomCenter ,
                    children: [
                      Align(
                        alignment:AlignmentDirectional.topCenter ,
                        child: Image(image:NetworkImage(model!.cover),

                          width: double.infinity,
                          height: 190,

                        ),
                      ),
                      CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius:80 ,
                          backgroundImage: NetworkImage(model.image),
                        ),
                      ),

                    ],
                  ),
                ),
                 Text(model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign:TextAlign.center ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,

                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8,bottom: 20),
                  child: Text(
                    model.bio,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,


                    ),
                  ),
                ),
                Row(
                  children:
                [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                         children:
                          [
                           Text(
                             '${cubit.posts.length}',
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                             textAlign:TextAlign.center ,
                             style: const TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20,

                             ),
                           ),
                           Text(
                             'Posts',
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                             textAlign:TextAlign.center ,
                             style: TextStyle(
                               fontSize: 15,
                               color: Colors.grey,

                             ),
                           ),
                         ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        const [
                          Text(
                            '1000',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign:TextAlign.center ,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,

                            ),
                          ),
                          Text(
                            'Followers',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign:TextAlign.center ,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        const[
                          Text(
                            '100',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign:TextAlign.center ,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,

                            ),
                          ),
                          Text(
                            'Followings',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign:TextAlign.center ,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10 ,bottom: 10),
                  child: Row(
                    children:
                    [
                      Expanded(
                      child: OutlinedButton(

                        onPressed: (){
                          navigatorTo(context, AddPost());
                        },
                        child: const Text(
                            'Add Post',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),

                      ),
                    ),
                      SizedBox(width: 5,),
                      OutlinedButton(
                        style: ButtonStyle(

                        ),
                        onPressed: ()
                        {
                          navigatorTo(context, EditProfile());
                        },

                        child: Icon(
                          Icons.edit,
                          size: 20,
                        ),

                      ),
                      SizedBox(width: 5,),
                      OutlinedButton(
                        style: ButtonStyle(

                        ),
                        onPressed: ()
                        {
                          cubit.logeOut();
                          navigatorToAndFinch(context, LoginScreen());
                        },

                        child: Icon(
                          Icons.logout,
                          size: 20,
                        ),

                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    itemBuilder: (context,index) =>buildPost(context,cubit.posts[index],index),
                    separatorBuilder: (context,index) =>SizedBox(height: 5,),
                    itemCount: cubit.posts.length),
                SizedBox(height: 10,),



              ],
     ),
         ),
       );
      },
    );
  }


  Widget buildPost(context,PostModel model,index)
  {
    var cubit = CubitChat.get(context);
    final TextEditingController commentController =TextEditingController();
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:NetworkImage(model.image),
                ),
                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children:  [
                        Text(
                          model.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5,),
                        Icon(Icons.verified,size: 18,color: Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      model.dateTime,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,

                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.withOpacity(0.4),
            ),
            const SizedBox(height: 10,),
            Text(model.text,
              textAlign:TextAlign.start ,
              style: TextStyle(
                fontSize:18,
                fontWeight: FontWeight.bold,


              ),
            ),

            // Row(
            //   children: [
            //     MaterialButton(
            //       onPressed: (){},
            //       child: Text('#Flutter'),
            //       textColor: Colors.blue,
            //       height: 20,
            //       minWidth: 20,
            //       padding:EdgeInsetsDirectional.only(end: 4) ,
            //     ),
            //     MaterialButton(
            //       onPressed: (){},
            //       child: Text('#Mohamed'),
            //       textColor: Colors.blue,
            //       height: 20,
            //       minWidth: 10,
            //       padding:EdgeInsetsDirectional.only(end: 4) ,
            //     ),
            //   ],
            // ),
            if(model.postImage !='')
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  clipBehavior:Clip.antiAliasWithSaveLayer ,
                  elevation: 0,

                  child: Stack(
                    children:  [

                      Image(image:NetworkImage(model.postImage),
                        width: double.infinity,
                        height: 250,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      // cubit.getLikePost(cubit.postsId[index]);
                      // print(cubit.likeCommentPost!.like);
                      //print(cubit.likes]);

                    },
                    child: Row(
                      children: [

                        Icon(Icons.favorite,color: Colors.red),
                        SizedBox(width: 8,),
                        Text(
                          //'${cubit.likesNum[index]}'
                            '1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),

                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      // cubit.getLikePost(cubit.postsId[index]);
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.comment_outlined,color: Colors.amber),
                        SizedBox(width: 8,),
                        Text('1 Commint',
                            // '${cubit.commentNum[index]} Commint',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),

                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.withOpacity(0.4),
            ),
            const SizedBox(height: 10,),
            Row(

              children: [
                Expanded(
                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(cubit.userModel!.image),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 50,
                        width:170,
                        child: TextFormField(
                          maxLines: 5,
                          controller: commentController,

                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: (){
                            cubit.commentPost(cubit.postsId[index], commentController.text);
                          },
                          icon: Icon(Icons.send)
                      ),
                      // Text('Write a comment...',)
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    cubit.likePost(cubit.postsId[index],true);
                  },
                  //   if(cubit.likeCommentPost!.like==false)
                  //     {
                  //
                  //       cubit.likePost(cubit.postsId[index],true);
                  //     }
                  //   else{
                  //     cubit.likePost(cubit.postsId[index],false);                    }
                  // },
                  child: Row(
                    children: [

                      Icon(Icons.favorite_border,color: Colors.red,size: 27,),
                      SizedBox(width: 10,),
                    ],
                  ),

                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
