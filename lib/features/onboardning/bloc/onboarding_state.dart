part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int page;

  const OnboardingPageChanged(this.page);

  @override
  List<Object> get props => [page];
}

class OnboardingNextPage extends OnboardingState {
  final int page;

  const OnboardingNextPage(this.page);

  @override
  List<Object> get props => [page];
}

class OnboardingCompleted extends OnboardingState {}
