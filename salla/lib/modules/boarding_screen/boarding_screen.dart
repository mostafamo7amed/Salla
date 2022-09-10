import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/component.dart';
import '../../shared/network/local/cache_helper/cache_helper.dart';
import '../login_screen/login_screen.dart';

class OnBoardingModel{
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  bool isLast = false;
  var boardingController =PageController();
  List<OnBoardingModel> boarding =[
    OnBoardingModel(image: 'assets/images/image1.jpg', title: '1', body: 'body'),
    OnBoardingModel(image: 'assets/images/image2.jpg', title: '2', body: 'body'),
    OnBoardingModel(image: 'assets/images/image3.png', title: '3', body: 'body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(onPressed: () {
            submit();
          }, child: const Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if(index == boarding.length-1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardingController,
                physics:const BouncingScrollPhysics(),
                itemBuilder: (context, index) => defaultOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      expansionFactor: 4.0,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5.0,
                      activeDotColor: Colors.blue,

                    ),
                    controller: boardingController,
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      submit();
                    }else{
                      boardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  Widget defaultOnBoardingItem(OnBoardingModel list) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(image: AssetImage(list.image),
        ),
      ),
      const SizedBox(height: 20,),
      Text(list.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 15,),
      Text(list.body,
        style:const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 15,),
    ],
  );

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', data: true).then((value){
      navigateAndFinish(context, LoginScreen());
    });
  }
}
