import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/const/icon_broken.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postsmodel = SocialCubit.get(context).posts;
        return ConditionalBuilderRec(
          condition: postsmodel.length > 0,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: const [
                      Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-vector/light-bulbs-hang-from-ceiling-realistic-3d-glass-electric-lamps-with-one-bright-lightbulb-glowing-symbol-creative-innovation-energy-inspiration-transparent-background_575670-1392.jpg?t=st=1652416832~exp=1652417432~hmac=a2f1d7e27ea94209faaf2674d8ed98828e82d71bcc14c22260e7a2265735a94b&w=1380',
                        ),
                        fit: BoxFit.cover,
                        //    height: 330,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Comunicate with your Friends ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  // SocialCubit.get(context).posts[index]
                  itemBuilder: (context, index) =>
                      buildPostItem(context, index, postsmodel[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                  itemCount: postsmodel.length,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

//postModel model,
  Widget buildPostItem(context, index, PostModel model) => Card(
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                                '${model.profileimage}',
                              ),
                            )),
                      )),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 16),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${model.date}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz_outlined,
                        size: 19,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            //SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${model.posttext}',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      height: 1.29,
                      fontSize: 18,
                    ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 4,
            //       horizontal: 8,
            //     ),
            //     child: Wrap(
            //       children: [
            //         Text(
            //           '#software',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //                 fontSize: 13,
            //               ),
            //         ),
            //         Text(
            //           '#software',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //                 fontSize: 13,
            //               ),
            //         ),
            //         Text(
            //           '#software develafpewlf efalewpf',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //                 fontSize: 13,
            //               ),
            //         ),
            //         Text(
            //           '#software develafpewlf efalewpf',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //                 color: Colors.blue,
            //                 fontSize: 13,
            //               ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            if (SocialCubit.get(context).postimage != '')
              Container(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: Image(
                    image: NetworkImage('${model.postImage}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likeposts(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        //${SocialCubit.get(context).likes[index]}
                        Text(
                          '${SocialCubit.get(context).likesNumber[index]}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 13,
                              ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat,
                          size: 18,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '0 Comment',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 13,
                              ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Container(
                height: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${SocialCubit.get(context).usermodel!.profileimage}'),
                            )),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Write s comment...',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.heart_broken_outlined,
                          size: 18,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 15,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      );
}
