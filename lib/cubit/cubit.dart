import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/const/constant.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/add_post_screen.dart';
import 'package:social_app/screens/chat_screen.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/screens/settings_screen.dart';
import 'package:social_app/screens/user_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialIntialAppState());

  static SocialCubit get(context) => BlocProvider.of(context);

  userModel? usermodel;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      usermodel = userModel.FromJson(value.data()!);
      emit(SocialGetUserDataSucsesstate());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialGetUserDataErorrState());
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    AddPostScreen(),
    const UserScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chat',
    'Create post',
    'USers',
    'Settings',
  ];

  void changeBottomNavbar(int index) {
    currentIndex = index;
    if (index == 1) getAllUsers();
    emit(ChangeBottomNavBarState());
  }

  File? profileimage;
  final picker = ImagePicker();

  Future<void> pickedprofileImage() async {
    final pickedProfileImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedProfileImage != null) {
      profileimage = File(pickedProfileImage.path);
      emit(SocialgetprofileImageSucsessState());
    } else {
      print('no image selceted');
      emit(SocialgetprofileImageErrorState());
    }
  }

  File? coverimage;

  Future<void> pickedCoverImage() async {
    final pickedCoverImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedCoverImage != null) {
      coverimage = File(pickedCoverImage.path);
      emit(SocialgetCoverImageSucsessState());
    } else {
      print('no image selceted');
      emit(SocialgetCoverImageErrorState());
    }
  }

  void upLoadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    firebase_Storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file('${profileimage!.path}').pathSegments.last}')
        .putFile(profileimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          bio: bio,
          phone: phone,
          profileimage: value,
        );
        print(value);
        emit(SocialUploadProfileImageSucsessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void upLoadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    firebase_Storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file('${coverimage!.path}').pathSegments.last}')
        .putFile(coverimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          bio: bio,
          phone: phone,
          coverimage: value,
        );
        print(value);
        emit(SocialUploadCoverImageSucsessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String bio,
    required String phone,
    String? profileimage,
    String? coverimage,
  }) {
    userModel model = userModel(
      name: name,
      bio: bio,
      phone: phone,
      profileimage: profileimage ?? usermodel!.profileimage,
      coverimage: coverimage ?? usermodel!.coverimage,
      email: usermodel!.email,
      uId: usermodel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(SocialUpdateUserDataSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserDataErrorState());
    });
  }

  void createPost({
    String? name,
    required String date,
    required String posttext,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: usermodel!.name,
      date: date,
      postImage: postImage ?? '',
      profileimage: usermodel!.profileimage,
      uId: usermodel!.uId,
      posttext: posttext,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSucseswsState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  File? postimage;

  Future<void> pickedPostImage() async {
    final pickedCoverImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedCoverImage != null) {
      postimage = File(pickedCoverImage.path);
      emit(SocialgetPostImageSucsessState());
    } else {
      print('no image selceted');
      emit(SocialgetPostImageErrorState());
    }
  }

  void upLoadPostImage({
    String? name,
    required String date,
    required String posttext,
  }) {
    emit(SocialUploadPostImagLoadingState());
    firebase_Storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file('${postimage!.path}').pathSegments.last}')
        .putFile(postimage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        createPost(
          name: name,
          date: date,
          posttext: posttext,
          postImage: value,
        );
        print(value);
        emit(SocialUploadPostImageSucsessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialUploadPostImageErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likesNumber = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likesNumber.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.FromJson(element.data()));
        }).catchError((error) {
          print(error);
        });
      });
    }).catchError((erorr) {
      print(erorr.toString());
    });
  }

  void likeposts(
    String postid,
  ) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('likes')
        .doc(usermodel!.uId)
        .set({'like': true})
        .then((value) {})
        .catchError((erorr) {
          print(erorr);
        });
  }

  List<userModel> users = [];

  void getAllUsers() {
    if (users.length == 0) //emit(SocialGetAllUserDataLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != usermodel!.uId)
            users.add(userModel.FromJson(element.data()));
          emit(SocialGetAllUserDataSucsesstate());
        });
      }).catchError((erorr) {
        print(erorr.toString());
        emit(SocialGetAllUserDataErorrState());
      });
  }

  void sendMessages({
    required String date,
    required String textmessage,
    required String recevierID,
    required String senderID,
  }) {
    MessageModel model = MessageModel(
      date: date,
      title: textmessage,
      reciverUid: recevierID,
      senderUid: usermodel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(recevierID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagefromMESucsesstate());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialSendMessagefromMEErorrState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierID)
        .collection('chats')
        .doc(usermodel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageToMESucsesstate());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialSendMessageToMEErorrState());
    });
  }

  List<MessageModel> messages = [];

  void getMesages({
    required String recevierID,
  }) {
    messages = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('cahts')
        .doc(recevierID)
        .collection('messages')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        emit(SocialGetMessagesSucsesState());
      });
    });
  }
}
