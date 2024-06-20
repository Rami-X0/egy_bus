import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/colors.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

final _controller = PageController(
  viewportFraction: 1,
  keepPage: true,
);
bool isLast = true;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                if (index == image.length - 1) {
                  setState(() {
                    isLast = false;
                  });
                } else {
                  setState(() {
                    isLast = true;
                  });
                }
              },
              controller: _controller,
              itemCount: image.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      height: 750.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image[index].toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(1),
                                  Colors.black.withOpacity(0.0),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 100.h,
                      right: 180.w,
                      child: Text(
                        text[index],
                        style: TextStyles.font30MainColorBold.copyWith(
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50.h,
                      right: 160.w,
                      child: Text(
                        title[index],
                        style: TextStyles.font28WhiteSemiBold.copyWith(
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          isLast == true
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                  child: Row(
                    children: [
                      _buildSmoothSwipe(),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        },
                        child: const CircleAvatar(
                          backgroundColor: ColorsManager.mainColor,
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ))
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Column(
                      children: [
                        _buildSmoothSwipe(),
                        Gap(15.h),
                        AppTextButton(
                          border: 5,
                          verticalSize: 50,
                          onPressed: () {
                            AppSharedPref.sharedPrefSet(
                                key: AppSharedPrefKey.onBoarding,
                                value: 'onBoarding');
                            context.pushNamed(Routes.chooseUser);
                          },
                          text: 'Start Now',
                          textStyle: TextStyles.font15DarkBlueMedium
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )

          // Column()
        ],
      ),
    );
  }

  List<String> image = [
    'assets/images/on_boarding_image_1.jpg',
    'assets/images/on_boarding_image_2.jpg',
    'assets/images/on_boarding_image_3.png',
  ];
  List<String> text = [
    'Efficiency',
    'Time-Saving',
    'Convenience ',
  ];
  List<String> title = [
    'Reducing manual processes \nand human errors.',
    'No more waiting in long \n       queues.',
    'Quick and easy digital ticket.',
  ];

  Widget _buildSmoothSwipe() {
    return SmoothPageIndicator(
      controller: _controller,
      count: image.length,
      axisDirection: Axis.horizontal,
      effect: const SlideEffect(
        activeDotColor: ColorsManager.mainColor,
        dotColor: Colors.grey,
        dotHeight: 10,
        dotWidth: 10,
        spacing: 5,
      ),
    );
  }
}
