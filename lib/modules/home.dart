import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/layout/cubit/cubit.dart';
import 'package:khwass_chat/layout/cubit/states.dart';
import 'package:khwass_chat/model/post_model.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitChat,States>(
      listener:(context, state) {

      },
      builder: (context, state) {
        var cubit = CubitChat.get(context);
        //var model =CubitChat.get(context).userModel ;
       return ConditionalBuilder(
         condition: cubit.posts.isNotEmpty ,
         builder: (context) =>SingleChildScrollView(
           physics: BouncingScrollPhysics(),
           child: Column(
             children: [
               const SizedBox(height: 15,),
               // Card(
               //
               //   margin: const EdgeInsets.symmetric(horizontal: 8),
               //   clipBehavior:Clip.antiAliasWithSaveLayer ,
               //   elevation: 8,
               //
               //   child: Stack(
               //     alignment: AlignmentDirectional.topEnd,
               //     children: const [
               //
               //       Image(image:AssetImage(
               //           'assets/images/mm.jpeg'),
               //         width: double.infinity,
               //         height: 250,
               //         fit: BoxFit.fill,
               //       ),
               //       Text(
               //           'khwass Chats',
               //           style: TextStyle(
               //             color: Colors.amber,
               //             fontSize: 20,
               //           )
               //       ),
               //     ],
               //   ),
               // ),
               const SizedBox(height: 10,),
               ListView.separated(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context,index) => buildPost(context,cubit.posts[index],index),
                   separatorBuilder:(context,index) => const SizedBox(height: 10),
                   itemCount: cubit.posts.length,
               ),
               SizedBox(height: 100,)
             ],
           ),
         ),
         fallback:(context) =>Center(child: CircularProgressIndicator()) ,
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
        padding: const EdgeInsets.all(10.0),
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
