import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/screens/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userinfo = SocialCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 240,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('${userinfo!.coverimage}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                          radius: 60,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage('${userinfo.profileimage}'),
                                )),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '${userinfo.name}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                '${userinfo.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            'posts',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '36',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            'Photos',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '12K',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            'Followers',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '830',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            'Following',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 15,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Edit'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ));
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 18,
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

//  CircleAvatar(
//                     radius: 25,
//                     child: Image(
//                       height: 90,
//                       fit: BoxFit.cover,
//                       image: NetworkImage(
//                           'https://img.freepik.com/free-photo/senior-man-white-sweater-eyeglasses_273609-42003.jpg?t=st=1652421965~exp=1652422565~hmac=45adcd0a2ef9c68ec7c2c832ee6f5d743449b476f71a324eb31e1ba93c380a7f&w=996'),
//                     ),
//                   ),
               