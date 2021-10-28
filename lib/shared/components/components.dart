import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required Function() function,
  required String text,
}) =>
    Container(
      height: 40.0,
      width: width,
      child: MaterialButton(
        onPressed: function,
        color: background,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style:const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) => TextButton(
    onPressed: function,
    child: Text(text.toUpperCase()));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  GestureTapCallback? onTap,
  bool isClickable = true,
  // required FormFieldValidator validate,
  required FormFieldValidator validate,
  required String label,
  String? hint,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        validator: validate,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        obscureText: isPassword,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border:const OutlineInputBorder(),
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ),
          ),
        ));

// PreferredSizeWidget defaultAppBar({
//   required BuildContext context,
//   String? title,
//   List<Widget>? actions
// })=> AppBar(
//   leading: IconButton(
//     onPressed: ()
//     {
//       Navigator.pop(context);
//     },
//     icon: Icon(
//       IconBroken.Arrow___Left_2,
//     ),
//   ),
//   title: Text(title!),
//   titleSpacing: 5.0,
//   actions: actions,
// );

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


void navigateTo (context , widget) => Navigator.push(context,
    MaterialPageRoute(
      builder: (context)=> widget,
    )
);

void navigateAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(
            builder: (context)=>widget),
            (Route<dynamic>route)=>false);

void showToast(
    {
      required String text,
      required ToastStates state,
    })
=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS, ERROR ,WARNING}

Color? chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
