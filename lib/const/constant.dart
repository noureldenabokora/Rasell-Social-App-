import 'package:flutter/material.dart';

Widget deafualtTextformField({
  required TextEditingController controller,
  void Function()? onTap,
  required void Function(String?)? saved,
  void Function(String?)? submitted,
  required String? Function(String?)? validator,
  TextInputType? keybordtype,
  required String lable,
  required Widget icon,
  Widget? suffixicon,
  void Function(String)? onChange,
  required bool obSecure,
}) =>
    TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChange,
      keyboardType: keybordtype,
      obscureText: obSecure,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: icon,
        suffixIcon: suffixicon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
      onSaved: saved,
      onFieldSubmitted: submitted,
      validator: validator,
    );

//String token = '';
String uId = '';
