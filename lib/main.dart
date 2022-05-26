import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/const/constant.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/login/login_screen.dart';
import 'package:social_app/screens/layout_screen.dart';
import 'package:social_app/shared/cache_helper.dart';

import 'shared/bloc_observer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  Fluttertoast.showToast(
      msg: "message from background",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

void main() async {
  blocObserver:
  MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHellper.init();

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    Fluttertoast.showToast(
        msg: "just  message  ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    Fluttertoast.showToast(
        msg: " message opended app  ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  uId = CacheHellper.getData(key: 'uid');
  Widget startWidget;

  if (uId != null) {
    startWidget = const Layoutscreen();
  } else {
    startWidget = LoginScreen();
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getPosts()
            ..getUserData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
