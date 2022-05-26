import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/login/login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginIntialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialLoginSucseesState(value.user!.uid));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialLoginEroorState());
    });
  }
  //late ShopLoginModel loginModel;
  // void userLogin({
  //   required String email,
  //   required String password,
  // })
  // {
  //   emit(SocialLoginLodingState());
  //   FirebaseAuth.instance
  //       .signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   )
  //       .then((value) {
  //     print(value.user!.email);
  //     emit(SocialLoginSucseesState(
  //       value.user!.uid,
  //     ));
  //   }).catchError((erorr) {
  //     print(erorr);
  //     emit(SocialLoginEroorState());
  //   });
  // }
}
