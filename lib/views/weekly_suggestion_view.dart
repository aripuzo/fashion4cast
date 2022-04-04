import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/models/ad.dart';
import 'package:fashion4cast/models/product.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/view_models/weekly_suggestion_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:fashion4cast/extensions/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import 'weekly_forecast_view.dart';

class WeeklySuggestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.BACKGROUND_COLOR
      ),
      child: _WeeklySuggestionView(args: args),
    );
  }
}

class _WeeklySuggestionView extends StatefulWidget {
  _WeeklySuggestionView({this.args});
  final ScreenArguments args;
  @override
  State<StatefulWidget> createState() => _WeeklySuggestionState();
}

class _WeeklySuggestionState extends State<_WeeklySuggestionView> {

  WeeklySuggestionViewModel _viewModel;
  List<Product> _products = [];
  Ad _highligted;

  @override
  void initState() {

    _viewModel = WeeklySuggestionViewModel(App(), widget.args.place);
    _viewModel.refreshProducts(widget.args.condition);
    _viewModel.loadAd();
    subscribeToViewModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Suggestions for "+widget.args.condition.capitalize()+ " Weather",
            style: TextStyle(
              fontFamily: 'HelveticaNeue',
              color: Colors.white,
              fontSize: ScreenUtil().setSp(20),
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            )
        ),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: <Widget>[
                        Text("Featured",
                            style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              color: Color(0xffffffff),
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                            )
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(26)),
                  ],
              ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return _shopListItem(_products[index]);
                  },
                  childCount: _products.length,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // Container(
                    //   height: ScreenUtil().setHeight(224),
                    //   width: ScreenUtil.defaultSize.width,
                    //   child: ListView.separated(
                    //     separatorBuilder: (context, index) => SizedBox(
                    //       width: ScreenUtil().setWidth(2),
                    //     ),
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: widget.args.weathers.length,
                    //     itemBuilder: (context, index) => _buildCarouselItem(
                    //       context,
                    //       widget.args.weathers[index],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: ScreenUtil().setHeight(52)),
                    Container(
                        width: ScreenUtil().setWidth(354),
                        height: ScreenUtil().setHeight(205),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                        decoration: new BoxDecoration(
                            color: Colors.white.withOpacity(0.1499999910593033),
                            borderRadius: BorderRadius.circular(4)
                        ),
                      child: Stack(
                        children: <Widget>[
                          PositionedDirectional(
                            start: 0,
                            top: 0,
                            child: SizedBox(
                                width: ScreenUtil().setWidth(130),
                                height: ScreenUtil().setHeight(130),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                    Center(
                                      child: Loading(indicator: BallSpinFadeLoaderIndicator(), size: 36.0, color: AppColors.PRIMARY_COLOR)
                                  ),
                                  imageUrl: _highligted != null ? _highligted.imageUrl : "",
                                  fit: BoxFit.cover,
                                ),
                            ),
                          ),
                          PositionedDirectional(
                            start: 0,
                            bottom: 0,
                            child: SizedBox(
                                width: ScreenUtil().setWidth(130),
                                height: ScreenUtil().setHeight(35),
                                child:  RaisedButton(
                                  child: Text(
                                      _highligted != null  && _highligted.addButtonLabel.isNotEmpty ? _highligted.addButtonLabel :"Buy now",
                                      style: TextStyle(
                                          color:  Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "HelveticaNeue",
                                          fontStyle:  FontStyle.normal,
                                          fontSize: ScreenUtil().setSp(12.0)
                                      ),
                                      textAlign: TextAlign.center
                                  ),
                                  onPressed: _highligted != null
                                      ?
                                      () {
                                    _launchURL(context, _highligted.addLink);
                                  }
                                      :
                                  null,
                                )
                            ),
                          ),
                          PositionedDirectional(
                            top: ScreenUtil().setHeight(31),
                            end: ScreenUtil().setWidth(7),
                            child:
                            SizedBox(
                                width: ScreenUtil().setWidth(161),
                                height: ScreenUtil().setHeight(136),
                                child:   Text(
                                    _highligted != null ? _highligted.addText ?? "" : "",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: ScreenUtil().setSp(13.0
                                    )
                                  )
                                ),
                            ),
                          ),
                          PositionedDirectional(
                            top: ScreenUtil().setHeight(3),
                            start: ScreenUtil().setSp(156),
                            child:
                            SizedBox(
                                //width: ScreenUtil().setWidth(49),
                                height: ScreenUtil().setHeight(21),
                                child:   Text(
                                    _highligted != null ? _highligted.adTitle ?? "Today" : "Today",
                                    style: TextStyle(
                                        color:  AppColors.PRIMARY_COLOR,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: ScreenUtil().setSp(11.0)
                                    )
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12.0)),
              ),
            ],
          )
        ),
      ),
    );
  }

  void subscribeToViewModel() {
    _viewModel.getAd().listen((ad){
      if(ad != null) {
        setState(() {
          _highligted = ad;
        });
      }
    });
    _viewModel.getProducts().listen((products){
      if(products != null && products.isNotEmpty) {
        setState(() {
          if(products.length > 1) {
            _products = new List.from(products.reversed);
            //_products = products;
          }
        });
      }
    });
  }

  Widget _shopListItem(Product item) {
    return new GestureDetector(
        onTap: () => _launchURL(context, item.externalLink),
        child: Container(
          width: ScreenUtil().setWidth(174),
          height: ScreenUtil().setHeight(164),
          decoration: BoxDecoration(
              color: const Color(0xffd8d8d8)
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Center(
                        child: Loading(indicator: BallSpinFadeLoaderIndicator(), size: 36.0, color: AppColors.BACKGROUND_COLOR)
                    ),
                    imageUrl: item.url,
                    fit: BoxFit.cover,
                  )
              ),
              PositionedDirectional(
                bottom: ScreenUtil().setHeight(0.0),
                end: ScreenUtil().setWidth(0.0),
                child: Container(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
                  color: AppColors.BACKGROUND_COLOR,
                  child: Text(
                    capitalize(item.label),
                    style: TextStyle(
                        color:  Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "HelveticaNeue",
                        fontStyle:  FontStyle.normal,
                        fontSize: ScreenUtil().setSp(14.0)
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
//     try {
//       await launch(
//         url,
//         option: new CustomTabsOption(
//           toolbarColor: Theme.of(context).primaryColor,
//           enableDefaultShare: true,
//           enableUrlBarHiding: true,
//           showPageTitle: true,
//           animation: new CustomTabsAnimation.slideIn(),
// //          extraCustomTabs: <String>[
// //            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
// //            'org.mozilla.firefox',
// //            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
// //            'com.microsoft.emmx',
// //          ],
//         ),
//       );
//     } catch (e) {
//     // An exception is thrown if browser app is not installed on Android device.
//     debugPrint(e.toString());
//     }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
