import 'package:flutter/material.dart';


import 'package:fluttertoast/fluttertoast.dart';


Widget defaultButton({
  double ? widith,
   Color? color ,
   Function? function,
   String? text ,
  bool isUpperCase=true,
 double ? fontSize=30,


})=>Container(
width: widith,
color: color,
child: MaterialButton(
onPressed: (){function!();},
child: Text( isUpperCase?text!.toUpperCase():text!,
maxLines: 1,
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: fontSize,
color: Colors.white,

),
),
),
);









Widget defaultTextForm({

  TextEditingController? control,
  TextInputType? textType,
  IconData? icon,
  String? labelText,
 bool obscure=false,
 IconData? suffixicon,
  Function? validat,
 Function? onPreased,
 Function? onTap,
 Function?  onFieldSubmitted,
 Function? onChanged,
 Radius? radius,
})=>TextFormField(
 controller: control! ,
 keyboardType:textType! ,
 obscureText: obscure,
 onTap:(){
  onTap!();
  },
 onChanged: (s)
 {
  onChanged!(s);
 },
 onFieldSubmitted: (s)
 {
  onFieldSubmitted!(s);
 },
 validator: (s)
 {
  return validat!(s);

 },
 cursorRadius:radius ,
 decoration: InputDecoration(
  labelText: labelText,
  prefixIcon: Icon(
   icon,
  ),
  suffixIcon: IconButton(
     onPressed: ()
     {
      onPreased!();
     },
      icon:Icon(suffixicon),
  ),
  border: OutlineInputBorder(),


 ),
);





void  navigatorTo(context,Widget widget)=>Navigator.push(
 context,
 MaterialPageRoute(
  builder: (context)=>widget
 ),
);




void  navigatorToAndFinch(context,Widget widget)=>Navigator.pushAndRemoveUntil
 (
    context,
   MaterialPageRoute(
     builder: (context)=>widget
 ),
    (Route<dynamic>rout)=>false,
);



void showToast(
{
 required String msg,
 required StateToast state
}
)=>Fluttertoast.showToast(
 msg: msg,
 toastLength: Toast.LENGTH_LONG,
 gravity: ToastGravity.BOTTOM,
 timeInSecForIosWeb: 1,
 backgroundColor: chooseStateToast(state),
 textColor: Colors.white,
 fontSize: 16.0,
);



enum StateToast {SUCCESS,ERROR,WARNING}

Color chooseStateToast(StateToast state)
{
 Color? color;
 switch(state)
 {
  case StateToast.SUCCESS:
     color!.green;
     break;
  case StateToast.ERROR:
   color!.red;
   break;
  case StateToast.WARNING:
   color!.blue;
   break; 
     
  
 }
 return color;


}











