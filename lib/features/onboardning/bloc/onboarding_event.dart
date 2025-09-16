part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class PageChanged extends OnboardingEvent {
  final int page;

  const PageChanged(this.page);

  @override
  List<Object> get props => [page];
}

class SkipOnboarding extends OnboardingEvent {}

class NextPage extends OnboardingEvent {
  final int currentPage;

  const NextPage(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class PreviousPage extends OnboardingEvent {
  final int currentPage;

  const PreviousPage(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
