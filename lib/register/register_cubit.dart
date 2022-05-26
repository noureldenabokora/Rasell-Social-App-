import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/register/register_states.dart';

class SocialRegisterCubit extends Cubit<RegisterStates> {
  SocialRegisterCubit() : super(RegisterIntialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  late userModel dafaultModel;

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(UserRegisterLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      creatUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(UserRegisterSucseesState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(UserRegisterEroorState());
    });
  }

  void creatUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    userModel model = userModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
    );

    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap())
      ..then((value) {
        emit(CreateSucseesState());
      }).catchError((erorr) {
        print(erorr.toString());
        emit(CreateEroorState());
      });
  }
  // void userRegister({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phone,
  // })
  // {
  //   emit(SocialRegisterLodingState());
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   )
  //       .then((value) {
  //     print(value.user!.email);
  //     print(value.user!.uid);
  //     createUser(
  //       name: name,
  //       email: email,
  //       phone: phone,
  //       uId: value.user!.uid,
  //       isVerified: false,
  //     );
  //     emit(SocialRegisterSucseesState());
  //   }).catchError((erorr) {
  //     emit(SocialRegisterEroorState());
  //   });
  // }

  // void createUser({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String uId,
  //   required bool isVerified,
  // })
  // {
  //   userModel model = userModel(
  //     name: name,
  //     email: email,
  //     phone: phone,
  //     uid: uId,
  //     isVerified: isVerified,
  //     bio: 'write A bio',
  //     covereImage:
  //         'https://img.freepik.com/free-photo/girl-rides-horse_1321-1254.jpg?t=st=1652419195~exp=1652419795~hmac=fddd1f44683fc5cdebe77f9e100b98e6f7e918b76fabe2016e6b0f13d621404a&w=996',
  //     profileImage:
  //         'https://img.freepik.com/free-photo/senior-man-white-sweater-eyeglasses_273609-42003.jpg?t=st=1652421965~exp=1652422565~hmac=45adcd0a2ef9c68ec7c2c832ee6f5d743449b476f71a324eb31e1ba93c380a7f&w=996',
  //   );
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uId)
  //       .set(model.toMap())
  //       .then((value) {
  //     emit(SocialCreateSucseesState());
  //   }).catchError((erorr) {
  //     emit(SocialCreateEroorState());
  //   });
  // }
}
