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

const Duration _kExpand =  Duration(milliseconds: 200);

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({
    Key? key,
    this.leading,
    required this.title,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children: const <Widget>[],
    this.trailing,
    this.initiallyExpanded: false,
  })
      : assert(initiallyExpanded != null),
        super(key: key);

  final Widget? leading;
  final Widget title;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor;
  final Widget? trailing;
  final bool initiallyExpanded;

  @override
  AppExpansionTileState createState() =>  AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  CurvedAnimation? _easeOutAnimation;
  CurvedAnimation? _easeInAnimation;
  ColorTween? _borderColor;
  ColorTween? _headerColor;
  ColorTween? _iconColor;
  ColorTween? _backgroundColor;
  late Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller =  AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation =  CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor =  ColorTween();
    _headerColor =  ColorTween();
    _iconColor =  ColorTween();
    _iconTurns =  Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation!);
    _backgroundColor =  ColorTween();

    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        }
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    }
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color borderSideColor = _borderColor!.evaluate(_easeOutAnimation!) ?? Colors.transparent;
    final Color? titleColor = _headerColor!.evaluate(_easeInAnimation!);

    return  Container(
      decoration:  BoxDecoration(
          color: _backgroundColor!.evaluate(_easeOutAnimation!) ?? Colors.transparent,
          border:  Border(
            top:  BorderSide(color: borderSideColor),
            bottom:  BorderSide(color: borderSideColor),
          )
      ),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data:  IconThemeData(color: _iconColor!.evaluate(_easeInAnimation!)),
            child:  ListTile(
              onTap: toggle,
              leading: widget.leading,
              title:  DefaultTextStyle(
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: titleColor),
                child: widget.title,
              ),
              trailing: widget.trailing ??  RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.expand_more),
              ),
            ),
          ),
           ClipRect(
            child:  Align(
              heightFactor: _easeInAnimation!.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor!.end = theme.dividerColor;
    _headerColor!
      ..begin = theme.textTheme.subtitle1!.color
      ..end = theme.colorScheme.secondary;
    _iconColor!
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    _backgroundColor!.end = widget.backgroundColor;

    final bool closed = !_isExpanded && _controller.isDismissed;
    return  AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null :  Column(children: widget.children),
    );
  }}