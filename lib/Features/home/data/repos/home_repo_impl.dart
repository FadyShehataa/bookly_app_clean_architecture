import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/home_local_data_source.dart';
import '../data_sources/home_remote_data_source.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeLocalDataSource localDataSource;
  final HomeRemoteDataSource remoteDataSource;

  HomeRepoImpl({required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() async {
    try {
      List<BookEntity> books = localDataSource.fetchFeaturedBooks();
      if (books.isEmpty) {
        books = await remoteDataSource.fetchFeaturedBooks();
      }
      return right(books);
    } on Exception {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() async {
    try {
      List<BookEntity> books = localDataSource.fetchNewestBooks();
      if (books.isEmpty) {
        books = await remoteDataSource.fetchNewestBooks();
      }
      return right(books);
    } on Exception {
      return left(Failure());
    }
  }
}
