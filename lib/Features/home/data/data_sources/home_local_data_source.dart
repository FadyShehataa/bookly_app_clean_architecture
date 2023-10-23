import 'package:bookly/constants.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/book_entity.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks({required int pageNumber});
  List<BookEntity> fetchNewestBooks();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks({required int pageNumber}) {
    int startIndex = pageNumber * 10;
    int endIndex = startIndex + 10;

    var box = Hive.box<BookEntity>(kFeaturedBooks);
    int lengthList = box.values.toList().length;
    if (startIndex >= lengthList || endIndex > lengthList) { // Todo: check last page
    print('startIndex: $startIndex, endIndex: $endIndex, lengthList: $lengthList');
      return [];
    }
    print(lengthList);
print(box.values.toList().sublist(startIndex, endIndex));
    return box.values.toList().sublist(startIndex, endIndex).toList();
  }

  @override
  List<BookEntity> fetchNewestBooks() {
    var box = Hive.box<BookEntity>(kNewestBooks);
    return box.values.toList();
  }
}
