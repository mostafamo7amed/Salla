
import 'package:flutter/material.dart';
import 'package:salla/shared/components/component.dart';
import 'package:skeleton_text/skeleton_text.dart';
import '../../modules/login_screen/login_screen.dart';
import '../network/local/cache_helper/cache_helper.dart';

String token = CacheHelper.getData(key: 'token');



class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  const SkeletonContainer({
    required this.width,
    required this.height,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
      ),
    );
  }


}
