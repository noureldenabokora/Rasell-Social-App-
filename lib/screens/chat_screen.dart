import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/chat_detailsscreen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: ListView.separated(
          itemBuilder: (context, index) => buildPersonItem(
            context,
            SocialCubit.get(context).users[index],
          ),
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: Colors.grey,
          ),
          itemCount: SocialCubit.get(context).users.length,
        ));
      },
    );
  }

  Widget buildPersonItem(context, userModel users) => InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatDetailsScreen(users),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '${users.profileimage}',
                        ),
                      )),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '${users.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      );
}
