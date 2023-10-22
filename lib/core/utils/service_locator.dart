import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../Features/home/data/data_sources/home_remote_data_source.dart';
import '../../Features/home/domain/use_cases/fetch_newest_books_use_case.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));
  getIt.registerSingleton<HomeLocalDataSourceImpl>(HomeLocalDataSourceImpl());
  getIt.registerSingleton<HomeRemoteDataSourceImpl>(
      HomeRemoteDataSourceImpl(getIt<ApiService>()));

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
        homeLocalDataSource: getIt<HomeLocalDataSourceImpl>(),
        homeRemoteDataSource: getIt<HomeRemoteDataSourceImpl>()),
  );

  getIt.registerSingleton<FetchFeaturedBooksUseCase>(
      FetchFeaturedBooksUseCase(getIt<HomeRepoImpl>()));

  getIt.registerSingleton<FetchNewestBooksUseCase>(
      FetchNewestBooksUseCase(getIt<HomeRepoImpl>()));
}
