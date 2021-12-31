import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

 Widget  buildTextFormField({
  Widget? suffix,
  required Widget icon,
  required String lableTex,
  required TextInputType type,
  required GestureTapCallback ontap,
  required TextEditingController controller,
  required FormFieldValidator validat,
   ValueChanged? onSubmit,
   required bool obscure,
}) {
   return TextFormField(

     obscureText: obscure,
     onFieldSubmitted: onSubmit,
     validator: validat,
     controller: controller,
     decoration: InputDecoration(
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20),
       ),
       prefixIcon:icon ,
       suffixIcon: suffix,


       labelText: lableTex,
     ),
     keyboardType: type,
     onSaved: (String? value) {
       // This optional block of code can be used to run
       // code when the user saves the form.
     },
     onTap: ontap,
   );

 }

 Widget buildButton(
{
  double? width = double.infinity,
  required VoidCallback onPressed,
  required String title,
}
     ){
   return Container(
     width:width,
     child: MaterialButton(
       shape:RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(8),
       ) ,
       onPressed: onPressed,
       color: Colors.deepOrange,
       child: Text(title,style: TextStyle(
         fontSize: 18,
       ),),
     ),
   );
 }

 void showToast ({
  required String text,
   required ToastState state,
})
   =>  Fluttertoast.showToast(
       msg: text,
       toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 5,
       backgroundColor: chooseToastColor(state),
       textColor: Colors.white,
       fontSize: 16.0,
   );

 enum ToastState {SUCCESS , ERROR, WARNING}

Color chooseToastColor (ToastState state) {

   Color color;

   switch(state) {
     case ToastState.SUCCESS:
        color = Colors.green;
      break;
     case ToastState.ERROR:
       color = Colors.red;
       break;
     case ToastState.WARNING:
       color = Colors.yellow;
       break;

   }
   return color;

}
void navigatTo(BuildContext context,Widget widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget));
}
String? token = CachHelper.getData(key: 'token');

Widget buildListProductItems ( model,context,{bool isOldPrice =true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              height: 120.0,
              width: 120,
              // fit: BoxFit.cover,
            ),
            if (model.discount != 0 && isOldPrice)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                alignment: AlignmentDirectional.bottomStart,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 12,
                    backgroundColor: Colors.red,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0 && isOldPrice )
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ?Colors.deepOrange:Colors.grey,
                        child: Icon(Icons.favorite_border,color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

