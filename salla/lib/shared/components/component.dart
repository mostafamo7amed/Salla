import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required Icon prefix,
  required validate,
  required TextInputType type,
  suffix,
  pressedShow,
  onTap,
  onSubmit,
  onChange,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
          icon: suffix,
          onPressed: pressedShow,
        )
            : null,
        border: const OutlineInputBorder(),
      ),
      validator: validate,
      keyboardType: type,
    );

Widget defaultButton({
  required onPressed,
  required String text,
  bool toUpperCase = false,
}) =>
    Container(
      width: double.infinity,
      height: 50,
      color: Colors.blue,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          toUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );

Future navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Future navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false);

Future<bool?> toast({
  required String message,
  required ToastStates data,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeToastColor(data),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  success,
  error,
  warning,
}

Color changeToastColor(ToastStates data) {
  Color color;
  switch (data) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
