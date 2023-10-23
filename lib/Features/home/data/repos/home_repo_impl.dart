import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_sources/home_local_data_source.dart';
import '../data_sources/home_remote_data_source.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeLocalDataSource, required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks({required int pageNumber}) async {
    try {
      List<BookEntity> books = homeLocalDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      if (books.isEmpty) {
        books = await homeRemoteDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() async {
    try {
      List<BookEntity> books = homeLocalDataSource.fetchNewestBooks();
      if (books.isEmpty) {
        books = await homeRemoteDataSource.fetchNewestBooks();
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
