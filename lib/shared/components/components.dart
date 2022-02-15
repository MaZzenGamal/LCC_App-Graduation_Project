import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  //required Color color,
  required Function() function,
  required String text,
}) =>
    Container(
      height: 50.0,
      width: width,
      child: MaterialButton(
        onPressed: function,
        color: HexColor('4E51BF'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        ),
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
  required FormFieldValidator validate,
  required String label,
  required IconData prefix,
  Function(String)? onSubmit,
  Function(String)? onChange,
  GestureTapCallback? onTap,
  bool isClickable = true,
  // required FormFieldValidator validate,
  String? hint,
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
        cursorColor: HexColor('4E51BF'),
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(color:HexColor('4E51BF')),
          labelStyle: TextStyle(
            color: Colors.grey[400],
          ),
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey[400]
          ) ,
          fillColor: Colors.grey[200],
          filled: true,
          errorBorder: OutlineInputBorder(
            borderSide:const  BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: HexColor('4E51BF'), width: 2.0),
              borderRadius: BorderRadius.circular(50.0),),
          border:const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0)),
              borderSide: BorderSide.none
          ),
          focusedBorder:OutlineInputBorder(
            borderSide:  BorderSide(color: HexColor('4E51BF'), width: 2.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          prefixIcon: Icon(prefix,
            color: HexColor('4E51BF'),),
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

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
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
