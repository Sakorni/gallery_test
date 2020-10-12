import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/load_mode.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/pictures_bloc.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/no_pictures.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/photo_widget.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/circular_loader.dart';
import 'package:gallery_test/entity/gateway/picture.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class ListOfPhotoPage<Mode extends LoadMode> extends StatelessWidget {
  ListOfPhotoPage();

  final _refreshController = RefreshController();

  bool _reset = false;
  bool _load = false;

  void _resetPhotos(BuildContext context) {
    _reset = true;
    context.bloc<PicturesBloc<Mode>>().add(ResetPictures());
  }

  void _loadPhotos(BuildContext context) {
    _load = true;
    context.bloc<PicturesBloc<Mode>>().add(LoadMorePictures());
  }

  void _clearLoad() {
    if (_load) {
      _refreshController.loadComplete();
      _load = false;
    }
  }

  void _clearReset() {
    if (_reset) {
      _refreshController.refreshCompleted();
      _reset = false;
    }
  }

  void _clearController() {
    _clearLoad();
    _clearReset();
  }

  Widget photoRefresher(List<Picture> _photo, BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: () => _loadPhotos(context),
      onRefresh: () => _resetPhotos(context),
      header: ClassicHeader(),
      footer: ClassicFooter(),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        children: _photo.map((e) => PhotoWidget(e)).toList(),
      ),
    );
  }

  Widget noPicturesRefresher(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () => _resetPhotos(context),
      header: ClassicHeader(),
      child: NoPictures(),
    );
  }
  // Widget noInternetRefresher() {
  //   Widget _spacer = SizedBox(height: Responsive.height * 0.014);
  //   var horPadding = const EdgeInsets.symmetric(horizontal: 20);
  //   return SmartRefresher(
  //     controller: _refreshController,
  //     enablePullDown: true,
  //     enablePullUp: false,
  //     onRefresh: _resetPhotos,
  //     header: ClassicHeader(),
  //     child: Column(
  //       children: [
  //         Container(
  //             margin: EdgeInsets.only(top: Responsive.height * 0.2),
  //             width: Responsive.respHeight(150),
  //             height: Responsive.respHeight(150),
  //             child: Image.asset(
  //               "assets/no_internet.png",
  //               colorBlendMode: BlendMode.darken,
  //               fit: BoxFit.fill,
  //             )),
  //         _spacer,
  //         Padding(
  //           padding: horPadding,
  //           child: Text(
  //             "Oh shucks!",
  //             textAlign: TextAlign.center,
  //             style: ConstTS.appBarTextStyle.copyWith(fontSize: 20),
  //           ),
  //         ),
  //         _spacer,
  //         Container(
  //           padding: horPadding,
  //           child: Text(
  //             "Slow or no internet connection.\nPlease check your internet settings",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //                 color: Color(0xFF1A1A1A), fontSize: 12, fontFamily: "SFR"),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicturesBloc<Mode>, PicturesState>(
      builder: (context, state) {
        if (state is PicturesScreenState) {
          _clearController();
          if (state.pictures.isEmpty) {
            return noPicturesRefresher(context);
          } else {
            return photoRefresher(state.pictures, context);
          }
        }
        // if (state is NoInternetState) {
        //   _clearController();
        //   return noInternetRefresher();
        // }
        if (state is FirstLoadingPictures) {
          return CircularLoader();
        }
        return Container();
      },
    );
  }
}
