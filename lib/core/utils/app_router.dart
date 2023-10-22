import 'package:bookly/Features/home/presentation/views/book_details_view.dart';
import 'package:bookly/Features/home/presentation/views/home_view.dart';
import 'package:bookly/Features/search/presentation/views/search_view.dart';
import 'package:bookly/core/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Features/Splash/presentation/views/splash_view.dart';
import '../../Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import '../../Features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import '../../Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import '../../Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  FeaturedBooksCubit(getIt.get<FetchFeaturedBooksUseCase>())..fetchFeaturedBooks(),
            ),
            BlocProvider(
              create: (context) =>
                  NewestBooksCubit(getIt.get<FetchNewestBooksUseCase>())..fetchNewestBooks(),
            ),
          ],
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) => const BookDetailsView(),
      ),
    ],
  );
}
