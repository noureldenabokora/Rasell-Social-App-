import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/const/constant.dart';
import 'package:social_app/register/register_cubit.dart';
import 'package:social_app/register/register_states.dart';
import 'package:social_app/screens/layout_screen.dart';

class RegieterScreen extends StatelessWidget {
  //const RegieterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateSucseesState) {
            Fluttertoast.showToast(
              msg: 'Hello ${nameController}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0,
            );
            // CacheHellper.setData(
            //   key: 'uid',
            //   value: state.loginModel.data.token,
            // );
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Layoutscreen(),
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        deafualtTextformField(
                          controller: nameController,
                          saved: (value) {},
                          obSecure: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name is  must not be Empty';
                            }
                            return null;
                          },
                          lable: "Name",
                          icon: const Icon(Icons.person),
                          //suffixicon: const Icon(Icons.visibility_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        deafualtTextformField(
                          controller: emailController,
                          saved: (value) {},
                          obSecure: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Your email';
                            }
                            return null;
                          },
                          lable: "Email",
                          icon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        deafualtTextformField(
                          controller: passwordController,
                          saved: (value) {},
                          obSecure: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          lable: "password",
                          icon: const Icon(Icons.lock_outline),
                          suffixicon: const Icon(Icons.visibility_outlined),
                        ),
                        const SizedBox(height: 20),
                        deafualtTextformField(
                          controller: phoneController,
                          saved: (value) {},
                          obSecure: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone is too short';
                            }
                            return null;
                          },
                          lable: "Phone",
                          icon: const Icon(Icons.phone),
                        ),
                        const SizedBox(height: 30),
                        ConditionalBuilderRec(
                          condition: state != UserRegisterLodingState(),
                          builder: (context) {
                            return FlatButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'REGISTER ',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                              minWidth: 400,
                              height: 50,
                            );
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
