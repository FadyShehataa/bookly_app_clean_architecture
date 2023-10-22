part of 'featured_books_cubit.dart';

@immutable
abstract class FeaturedBooksState {}

class FeaturedBooksInitial extends FeaturedBooksState {}

class FeaturedBooksLoading extends FeaturedBooksState {}

class FeaturedBooksLoaded extends FeaturedBooksState {
  final List<BookEntity> books;

  FeaturedBooksLoaded(this.books);
}

class FeaturedBooksFailure extends FeaturedBooksState {
  final String errMessage;

  FeaturedBooksFailure(this.errMessage);
}
