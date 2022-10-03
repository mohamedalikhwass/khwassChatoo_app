
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/layout/cubit/cubit.dart';
import 'package:khwass_chat/layout/cubit/states.dart';
import 'package:khwass_chat/model/user_model.dart';

class ChatScreen extends StatelessWidget {

  UserModel? userModel;

  ChatScreen({this.userModel});


  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          CubitChat.get(context).getMessage(userModel!.uId);
          return  BlocConsumer<CubitChat,States>(

              listener:(context, state) {

              },
              builder:(context, state){

                var cubit = CubitChat.get(context);
                //var model =CubitChat.get(context).userModel ;
                final TextEditingController textController =TextEditingController();
                var message = CubitChat.get(context).messages;
                final now = DateTime.now();

                return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 60,
                    backgroundColor: Colors.amber.withOpacity(.7),
                    title: Row(
                      children:  [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(userModel!.image),
                          //backgroundImage: AssetImage('assets/images/mm.jpeg'),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          (userModel!.name),
                          maxLines: 1,
                          overflow:TextOverflow.ellipsis ,

                          style: TextStyle(
                            fontSize: 20.0,

                            color: Colors.white.withOpacity(.9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),

                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.videocam_rounded,size: 27,color: Colors.white.withOpacity(.9),),
                        ),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.call,size: 25,color: Colors.white.withOpacity(.9),),
                        ),

                        // IconButton(
                        //   onPressed: (){},
                        //   icon: Icon(Icons.videocam_rounded,size: 30,color: Colors.white.withOpacity(.9),),
                        // ),
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(

                        children: [
                          Expanded(
                            child: ConditionalBuilder(
                              condition: message.length >0,
                              fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
                              builder: (BuildContext context) => ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if(message[index].sendId == cubit.userModel!.uId) {
                                    return buildMyChatItem (context,index);
                                  }
                                  else
                                  {
                                    return buildYouChatItem (context,index);
                                  }


                                },
                                separatorBuilder: (context, index)=>SizedBox(height: 5,),
                                itemCount: message.length,
                              ),

                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.8),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: textController,

                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Write here massage',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Spacer(),
                                IconButton(
                                  onPressed: (){
                                    cubit.sendMessage(
                                      receiverId: userModel!.uId,
                                      text: textController.text,
                                      dateTime:  now.toString(),

                                    );
                                  },
                                  icon: Icon(Icons.send),
                                ),
                              ],

                            ),
                          ),
                        ]
                    ),
                  ),
                );
              }
          );
        },

    );

  }

  Widget buildYouChatItem (context,index)
  {
    var message = CubitChat.get(context).messages;
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8,top: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Text(
              message[index].text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildMyChatItem (context,index)
  {
    var message = CubitChat.get(context).messages;
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8,top: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.amber.withOpacity(.5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Text(
              message[index].text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
