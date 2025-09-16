import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';
import 'package:ruba_sm/core/widgets/custom_texts.dart';
import 'package:ruba_sm/features/onboardning/bloc/onboarding_bloc.dart';
import 'package:ruba_sm/features/onboardning/helper/get_progress.dart';
import 'package:ruba_sm/features/onboardning/model/onboarding_model.dart';
import 'package:ruba_sm/features/onboardning/widgets/circular_progress_button.dart';
import 'package:ruba_sm/features/onboardning/widgets/onboarding_button.dart';
import 'package:ruba_sm/features/onboardning/widgets/text_animation.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      id: 1,
      title: 'Welcome to Ruba',
      subtitle:
          'Make money by referring your friends with real-estate properties.',
      imagePath: 'assets/images/step-1.png',
      brownIndex: [2],
    ),
    OnboardingPageModel(
      id: 2,
      title: 'Track status for all your leads.',
      subtitle:
          'All your leads are organized into categories, and you can update their statuses anytime.',
      imagePath: 'assets/images/step-2.png',
      brownIndex: [0, 1],
    ),
    OnboardingPageModel(
      id: 3,
      title: 'Get Timely notifications.',
      subtitle:
          'You’ll get notifications for everything from payments to new leads, so you can act quickly.',
      imagePath: 'assets/images/step-3.png',
      brownIndex: [0, 1],
    ),
    OnboardingPageModel(
      id: 4,
      title: 'View and Manage payouts with Ruba Coins.',
      subtitle:
          'You can track all your earnings and withdraw whenever you like, with no set withdrawal dates.',
      imagePath: 'assets/images/step-4.png',
      brownIndex: [2, 3],
    ),
  ];

  void _handleNavigation(
    BuildContext context,
    bool isNext,
    OnboardingState state,
  ) {
    if (state is OnboardingPageChanged) {
      final newPage = isNext ? state.page + 1 : state.page - 1;
      if (newPage >= 0 && newPage < pages.length) {
        context.read<OnboardingBloc>().add(PageChanged(newPage));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingPageChanged) {
            if (_pageController.page?.round() != state.page) {
              _pageController.animateToPage(
                state.page,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          } else if (state is OnboardingCompleted) {}
        },
        builder: (context, state) {
          int currentPage = 0;
          if (state is OnboardingPageChanged) {
            currentPage = state.page;
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              _buildTitleAndSubtitle(currentPage, state),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17, top: 100),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    context.read<OnboardingBloc>().add(PageChanged(page));
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(pages[index], context, state);
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.01),
                        Colors.white.withValues(alpha: 0.9),
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),
              currentPage == 0
                  ? Positioned(
                      bottom: 60,
                      left: 17,
                      right: 17,
                      child: CustomIconButtonNew(
                        maxSize: const Size(double.infinity, 51),
                        minSize: const Size(double.infinity, 51),
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        text: 'Get Started',
                        onPressed: () {
                          _handleNavigation(context, true, state);
                        },
                      ),
                    )
                  : currentPage == 3
                  ? Positioned(
                      bottom: 60,
                      left: 17,
                      right: 17,
                      child: CustomIconButtonNew(
                        maxSize: const Size(double.infinity, 51),
                        minSize: const Size(double.infinity, 51),
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        text: 'Sign In',
                        onPressed: () {
                          _handleNavigation(context, true, state);
                        },
                      ),
                    )
                  : Positioned(
                      bottom: 60,
                      left: 17,
                      right: 17,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                _handleNavigation(context, false, state),
                            child: CustomText(
                              title: 'Back',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          CustomProgressButton(
                            ontap: () {
                              log('ontap');
                              _handleNavigation(context, true, state);
                            },
                            progress: getProgressForPage(currentPage),
                          ),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitleAndSubtitle(int currentPage, OnboardingState? state) {
    int currentPage = 0;
    if (state is OnboardingPageChanged) {
      currentPage = state.page;
    }
    return Positioned(
      top: 100,
      left: 17,
      right: 17,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SmoothGrainyText(
            text: pages[currentPage].title,
            style: GoogleFonts.ibmPlexSerif(
              fontWeight: FontWeight.w400,
              fontSize: 32.0,
              color: Colors.black,
            ),
            brownIndexes: pages[currentPage].brownIndex,
          ),
          const SizedBox(height: 12.0),
          OffsetText(
            key: ValueKey(pages[currentPage].subtitle),
            textAlignment: TextAlignment.center,
            text: pages[currentPage].subtitle,
            textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(
    OnboardingPageModel pageData,
    BuildContext context,
    OnboardingState state,
  ) {
    return Stack(
      children: [
        Positioned(
          bottom: 70,
          left: 0,
          right: 0,
          child: SlideInUp(
            duration: const Duration(milliseconds: 800),
            child: Image.asset(
              pageData.imagePath,
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 450,
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: MediaQuery.sizeOf(context).width * 0.3,
          child: GestureDetector(
            onTapDown: (_) => _handleNavigation(context, false, state),
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: MediaQuery.sizeOf(context).width * 0.3,
          child: GestureDetector(
            onTapDown: (_) => _handleNavigation(context, true, state),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
