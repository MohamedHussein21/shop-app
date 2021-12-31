import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login/login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;


  BoardingModel({required this.image,required this.title,required this.body,} );}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/image/onboarding1.jpg',
      title: 'On Boarding 1',
      body: 'Boarding body 1',
    ),
    BoardingModel(
      image: 'assets/image/onboarding1.jpg',
      title: 'On Boarding 2',
      body: 'Boarding body 2',
    ),
    BoardingModel(
      image: 'assets/image/onboarding1.jpg',
      title: 'On Boarding 3',
      body: 'Boarding body 3',
    ),
  ];

  bool isLast =false;

  var boardingController = PageController();

  void submit (){
    CachHelper.saveData(key: 'OnBoarding', value: true).then((value) {
      if(value )
        {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context)=>LoginScreen()),
                  (route) => false);
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text('Skip')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == boarding.length -1)
                    {
                      setState(() {
                        isLast =true ;
                      });
                    }else{
                    setState(() {
                      isLast =false;
                    });
                  }
                },
                controller: boardingController,
                physics: BouncingScrollPhysics() ,
                itemBuilder: (context, index) => buildBoarding(boarding[index]),
                itemCount: boarding.length,

              ),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.deepOrange,
                      expansionFactor: 4,
                      spacing: 5,
                      dotWidth: 10,
                      dotHeight: 10,
                    ),
                    controller: boardingController,
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast)
                      {
                        submit();
                      }
                  boardingController.nextPage(
                      duration: Duration(
                          milliseconds: 720),
                      curve: Curves.fastLinearToSlowEaseIn );
                },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],

        ),
      ),

    );
  }

  Widget buildBoarding(BoardingModel modle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset('${modle.image}')),
          SizedBox(height: 30,),
          Text('${modle.title}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
          SizedBox(height: 20,),
          Text('${modle.body}',
            style: TextStyle(
                fontSize: 15
            ),
          ),


        ],
      );
}
