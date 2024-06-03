import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/sharedPreference/LocalStore.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';
import 'package:foodorder/app/modules/onboardingPage/model/onboardingModel.dart';
import 'package:foodorder/app/widgets/indicator/dotIndicator.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  setKey() async {
    await LocalStore().saveIsGetStarted('1');
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    print("onboardingData.length-${onboardingData.length}");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 130,
              ),
              Center(
                  child: Image.asset(
                'assets/images/logoonboarding.png',
                height: 50,
                width: 138,
              )),
              const SizedBox(
                height: 20,
              ),
              // Center(
              //   child:
              //   Text(
              //     ConstantText.appName,
              //     style: TextStyle(
              //         fontFamily: 'NunitoSans',
              //         fontSize: 23,
              //         fontWeight: FontWeight.w700),
              //   ),
              // ),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (int page) {
                      setState(() {
                        print("page--${page}");
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // const SizedBox(
                              //   height: 120,
                              // ),
                              Spacer(),
                              Image.asset(
                                onboardingData[index].imagePath,
                                height: 150.37,
                              ),
                              const SizedBox(height: 80),
                              Text(onboardingData[index].title,
                                  style: const TextStyle(
                                      fontFamily: 'Satisfy',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  onboardingData[index].description,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(57, 57, 57, 1)),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // onboardingData[index].welcomeKey
                              //     ? Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: <Widget>[
                              //           Row(
                              //             children: List.generate(
                              //                 onboardingData.length - 1,
                              //                 (index) => _currentPage == index + 1
                              //                     ? Padding(
                              //                         padding: const EdgeInsets
                              //                             .symmetric(horizontal: 3),
                              //                         child: Image.asset(
                              //                             'assets/images/selectedOnboardingIcon.png'),
                              //                       )
                              //                     : Padding(
                              //                         padding: const EdgeInsets
                              //                             .symmetric(horizontal: 3),
                              //                         child: Image.asset(
                              //                             'assets/images/onboardingIcon.png'),
                              //                       )),
                              //           ),
                              //         ],
                              //       )
                              //     : Container(),
                              (_currentPage == 0)
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ...List.generate(
                                            onboardingData.length - 1,
                                            (index) => Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4),
                                              child: DotIndicator(
                                                isActive:
                                                    index == _currentPage - 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              // CustomButton.regular(
                              //   title: ConstantText.getStarted,
                              //   background: Color.fromRGBO(203, 32, 45, 1),
                              //   fontweight: FontWeight.w400,
                              //   onTap: () async {
                              //     if (index == onboardingData.length - 1) {
                              //       await setKey();
                              //       await Navigator.pushReplacement(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => const LoginView()));
                              //     } else {
                              //       _pageController.nextPage(
                              //           duration: const Duration(milliseconds: 300),
                              //           curve: Curves.easeIn);
                              //     }
                              //   },
                              // ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomButton.regular(
                title: ConstantText.getStarted.toUpperCase(),
                background: AppColor.redThemeColor,
                fontSize: 16,
                radius: 10,
                fontweight: FontWeight.bold,
                onTap: () async {
                  if (_currentPage == onboardingData.length - 1) {
                    await setKey();
                    await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  } else {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                child: Text(ConstantText.skip.toUpperCase()),
                onTap: () {
                  setKey();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
