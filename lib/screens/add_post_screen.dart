import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';

class AddPostScreen extends StatelessWidget {
  // const AddPostScreen({Key? key}) : super(key: key);
  var textPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postImage = SocialCubit.get(context).postimage;

        var usermodel = SocialCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if (state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(),
              if (state is SocialCreatePostLoadingState)
                const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${usermodel!.profileimage}',
                              )),
                        ),
                      )),
                  const SizedBox(width: 8),
                  Text(
                    '${usermodel.name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: TextFormField(
                  controller: textPostController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What in your mind.... ',
                  ),
                ),
              ),
              if (postImage != null)
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
                              image: FileImage(postImage),
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
                            //       SocialCubit.get(context).removePhoto();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).pickedPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.camera_sharp,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Add Photos',
                            )
                          ],
                        )),
                  ),
                  Expanded(
                      child:
                          TextButton(onPressed: () {}, child: Text('# tags')))
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    if (postImage == null) {
                      SocialCubit.get(context).createPost(
                        //    postImage: postImage,
                        posttext: textPostController.text,
                        date: DateTime.now().toString(),
                      );
                    } else {
                      SocialCubit.get(context).upLoadPostImage(
                        //    postImage: postImage,
                        posttext: textPostController.text,
                        date: DateTime.now().toString(),
                      );
                    }
                  },
                  child: Text('Add Post'))
            ],
          ),
        );
      },
    );
  }
}
