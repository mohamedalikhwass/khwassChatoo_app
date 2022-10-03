import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_chat/layout/cubit/cubit.dart';
import 'package:khwass_chat/layout/home_layout.dart';
import 'package:khwass_chat/modules/login/login_screen.dart';
import 'package:khwass_chat/network/local/cache_helper.dart';
import 'package:khwass_chat/sheared/blocoserver/blocObserver.dart';
import 'package:khwass_chat/sheared/components/constantes.dart';
import 'package:khwass_chat/styles/themes.dart';
import 'firebase_options.dart';



Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  var token = await FirebaseMessaging.instance.getToken();
  print('token = $token');

  FirebaseMessaging.onMessage.listen((event)
  {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

   late Widget widget;
  uId = CacheHelper.getData(key: 'uId');
   if (uId !='')
     {
       widget =HomeLayout();
     }
   else {
     widget = LoginScreen();
   }
 print(uId);

  BlocOverrides.runZoned(
        () {
          runApp(MyApp(
             firstWidget: widget,
          ));
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {


   final Widget firstWidget;
  MyApp(
      {required this.firstWidget}
  );


  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: 
      [
       BlocProvider(
        create: (context) =>CubitChat()..getUserData()..getPosts(),
       )
      ],
      child: MaterialApp(

        title: 'Flutter Demo',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: firstWidget,
      ),
    );
  }
}




