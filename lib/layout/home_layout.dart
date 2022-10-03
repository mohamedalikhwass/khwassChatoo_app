
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/layout/cubit/states.dart';
import 'package:khwass_chat/sheared/components/components.dart';

import '../modules/post.dart';
import 'cubit/cubit.dart';

class HomeLayout extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<CubitChat,States>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = CubitChat.get(context);
        bool showFab = MediaQuery.of(context).viewInsets.bottom !=0;
        return Scaffold(
          appBar: AppBar(

            title: Text(cubit.title[cubit.curantIndex]),
          ),
          body: cubit.screens[cubit.curantIndex],
          bottomNavigationBar: BottomAppBar(
             shape: const CircularNotchedRectangle(),
             notchMargin: 7,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            child: BottomNavigationBar(
              showSelectedLabels: true,
              iconSize:30,
              showUnselectedLabels: false,
              type:BottomNavigationBarType.fixed ,
              currentIndex: cubit.curantIndex,
              onTap: (index)
              {
                cubit.changeNavBar(index);
              },
              items:
              const [
                BottomNavigationBarItem(icon:Icon(Icons.home_outlined),label: 'Home'),
                BottomNavigationBarItem(icon:Icon(Icons.chat_outlined),label: 'Chats'),
                BottomNavigationBarItem(icon:Icon(Icons.supervised_user_circle_outlined),label: 'Users'),
                BottomNavigationBarItem(icon:Icon(Icons.person_outlined),label: 'Profile'),
              ],
            ),
          ),
          floatingActionButton: Visibility(
            visible: ! showFab,
            child: FloatingActionButton(
              onPressed: ()
              {

                navigatorTo(context, AddPost());

              },
              child: Icon(Icons.post_add_outlined,color: Colors.grey,size: 35,),
              tooltip: 'Post',




            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,



        );
      },
    );
  }
}
