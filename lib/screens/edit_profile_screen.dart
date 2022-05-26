import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/const/constant.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  // const EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).usermodel;
        nameController.text = userModel?.name as String;
        // bioController.text = userModel.bio!;
        // phoneController.text = userModel.phone!;

        var coverimage = SocialCubit.get(context).coverimage;

        var profileimage = SocialCubit.get(context).profileimage;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.9,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    // SocialCubit.get(context)
                    //     .upLoadProfileImage();
                    SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                      coverimage: userModel!.coverimage,
                      profileimage: userModel.profileimage,
                    );
                  },
                  child: const Text('Update'))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 240,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
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
                                      image: coverimage == null
                                          ? NetworkImage(
                                              '${userModel!.coverimage}',
                                            )
                                          : FileImage(coverimage)
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 19,
                              backgroundColor: Theme.of(context).hintColor,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).pickedCoverImage();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileimage == null
                                    ? NetworkImage('${userModel!.profileimage}')
                                    : FileImage(profileimage) as ImageProvider,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            CircleAvatar(
                              radius: 19,
                              backgroundColor: Theme.of(context).hintColor,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .pickedprofileImage();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (SocialCubit.get(context).coverimage != null ||
                      SocialCubit.get(context).profileimage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileimage != null)
                          Expanded(
                            child: Column(
                              children: [
                                if (state
                                    is SocialUploadProfileImagLoadingState)
                                  const LinearProgressIndicator(),
                                if (state
                                    is SocialUploadProfileImagLoadingState)
                                  const SizedBox(height: 4),
                                FlatButton(
                                  onPressed: () {
                                    SocialCubit.get(context).upLoadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                  color: Colors.blue,
                                  child: const Text(
                                    'update profile',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        const SizedBox(width: 10),
                        if (SocialCubit.get(context).coverimage != null)
                          Expanded(
                            child: Column(
                              children: [
                                if (state is SocialUploadCoverImagLoadingState)
                                  const LinearProgressIndicator(),
                                if (state is SocialUploadCoverImagLoadingState)
                                  const SizedBox(height: 4),
                                FlatButton(
                                  onPressed: () {
                                    SocialCubit.get(context).upLoadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                  color: Colors.blue,
                                  child: const Text(
                                    'update cover',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  Text(
                    '${userModel!.name}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${userModel.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 15),
                  deafualtTextformField(
                    controller: nameController,
                    saved: (saved) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    lable: 'Name',
                    icon: Icon(Icons.person),
                    obSecure: false,
                  ),
                  const SizedBox(height: 8),
                  deafualtTextformField(
                    controller: bioController,
                    saved: (saved) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    lable: 'bio',
                    icon: const Icon(Icons.info),
                    obSecure: false,
                  ),
                  const SizedBox(height: 8),
                  deafualtTextformField(
                    controller: phoneController,
                    saved: (saved) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    lable: 'phone',
                    icon: const Icon(Icons.call),
                    obSecure: false,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
