import 'package:gallery_test/app/resources/app_strings.dart';

abstract class LoadMode {}

class NewLoadMode extends LoadMode {
  @override
  String toString() {
    return AppStrings.photoModeNew;
  }
}

class PopularLoadMore extends LoadMode {
  @override
  String toString() {
    return AppStrings.photoModePopular;
  }
}
