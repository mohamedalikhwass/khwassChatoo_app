import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/layout/cubit/cubit.dart';
import 'package:khwass_chat/layout/cubit/states.dart';
import 'package:khwass_chat/model/user_model.dart';
import 'package:khwass_chat/modules/chat_screen.dart';
import 'package:khwass_chat/sheared/components/components.dart';

class Chats extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitChat,States>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var model =CubitChat.get(context).userModel ;
          var cubit = CubitChat.get(context);

          return ConditionalBuilder(
              condition:cubit.users.length >0 ,
              builder: (context)=>ListView.separated(
                physics: BouncingScrollPhysics(),

                itemBuilder: (context,index)=>buildUserChat(context,index,model!),
                separatorBuilder: (context,index)=>Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(height: 1,color: Colors.grey,width: double.infinity),
                ),
                itemCount: cubit.users.length,
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
          );

        },
    );
  }

  Widget buildUserChat(context,index,UserModel model)
  {
    var cubit = CubitChat.get(context);
    return InkWell(
      onTap: ()
      {
        navigatorTo(context, ChatScreen(userModel: cubit.users[index],));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children:  [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(cubit.users[index].image),
              //backgroundImage: AssetImage('assets/images/mm.jpeg'),
            ),
            SizedBox(width: 10,),
            Text(
              (cubit.users[index].name),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
