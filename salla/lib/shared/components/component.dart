import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../cubits/shop_cubit/shop_cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required Icon prefix,
  required validate,
  required TextInputType type,
  required context,
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
        labelStyle: Theme.of(context).textTheme.bodyText1,
        prefixIconColor: Colors.blue,
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

Widget productsBuilder(model,context,{bool isSearch = true}) => Row(
  children: [
    Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image.network(
          model.image,
          width: 120,
          height: 120,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return child;
          },
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress == null){
              return child;
            }else{
              return Center(
                child: Image.asset(
                  'assets/images/image0.jpg',
                  width: 120,
                  height: 120,
                ),
              );
            }
          },
        ),
        if (model.discount != 0 && isSearch)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Image.asset(
              'assets/images/disc.gif',
              width: 35,
              height: 35,
            ),
          ),
      ],
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.3,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${model.price.round()}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (model.discount != 0 && isSearch)
                  Text(
                    '${model.oldPrice.round()}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const Spacer(),
                IconButton(
                  alignment: Alignment.bottomCenter,
                  onPressed: () {
                    ShopCubit.getCubit(context).changeFavorites(model.id);
                    print(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: ShopCubit.getCubit(context).favorites[model.id]??false ? Colors.blue:Colors.grey,
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ],
);

