import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingPageChanged(0)) {
    on<PageChanged>(_onPageChanged);
    on<SkipOnboarding>(_onSkipOnboarding);
    on<NextPage>(_onNextPage);
    on<PreviousPage>(_onPreviousPage);
  }

  void _onPageChanged(PageChanged event, Emitter<OnboardingState> emit) {
    emit(OnboardingPageChanged(event.page));
  }

  void _onSkipOnboarding(SkipOnboarding event, Emitter<OnboardingState> emit) {
    emit(OnboardingCompleted());
  }

  void _onNextPage(NextPage event, Emitter<OnboardingState> emit) {
    if (event.currentPage < 2) {
      emit(OnboardingPageChanged(event.currentPage + 1));
    } else {
      emit(OnboardingCompleted());
    }
  }

  void _onPreviousPage(PreviousPage event, Emitter<OnboardingState> emit) {
    if (event.currentPage > 0) {
      emit(OnboardingPageChanged(event.currentPage - 1));
    }
  }
}
