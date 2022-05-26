import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/const/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';

class Layoutscreen extends StatelessWidget {
  const Layoutscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff00B761),
            elevation: 0,
            // leading: IconButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     icon: Icon(
            //       Icons.arrow_back_ios,
            //       color: Colors.black,
            //     )),
            title: Text(
              '${cubit.titles[cubit.currentIndex]}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavbar(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Add_User), label: 'add post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Profile), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
