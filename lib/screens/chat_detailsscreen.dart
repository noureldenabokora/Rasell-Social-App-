import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  //const ChatDetailsScreen({Key? key}) : super(key: key);
  userModel model;

  ChatDetailsScreen(this.model);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMesages(recevierID: model.uId!);

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: Theme.of(context).iconTheme,
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    foregroundImage: NetworkImage(
                      '${model.profileimage}',
                      //  'https://firebasestorage.googleapis.com/v0/b/social-cd56a.appspot.com/o/users%2Fimage_picker2894776659274488802.webp?alt=media&token=c114d997-a4a8-41a6-80c0-6b9326820f83'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (SocialCubit.get(context)
                                .messages[index]
                                .senderUid ==
                            SocialCubit.get(context).usermodel!.uId) {
                          return buildMychatitem(
                            SocialCubit.get(context).messages[index],
                          );
                        }
                        return buildchatitem(
                          SocialCubit.get(context).messages[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: SocialCubit.get(context).messages.length,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message here',
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              SocialCubit.get(context).sendMessages(
                                textmessage: messageController.text,
                                recevierID: model.uId.toString(),
                                date: DateTime.now().toString(),
                                senderID:
                                    SocialCubit.get(context).usermodel!.uId!,
                              );
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildchatitem(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
  Widget buildMychatitem(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.4),
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
}
