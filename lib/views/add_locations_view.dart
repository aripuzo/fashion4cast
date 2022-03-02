import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/models/place.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/add_location_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

class AddLocations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddLocationsState();
}

class _AddLocationsState extends State<AddLocations> {

  AddLocationViewModel _viewModel;

  List<Place> _places = [];

  @override
  void initState() {

    _viewModel = AddLocationViewModel(App());
    subscribeToViewModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context)
          .backgroundColor,
    ));

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: ScreenUtil.defaultSize.width,
                      child: Text(
                          "Locations",
                          style: titleTextStyle
                      )
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(52),
                  ),
                  Theme(
                    data: new ThemeData.dark(),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _viewModel.queryController,
                      decoration: InputDecoration(
                        hintText: "Enter city name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(27)),
                          borderSide: BorderSide(
                            color: AppColors.TEXT_BORDER_COLOR,
                            width: ScreenUtil().setWidth(1),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.TEXT_BORDER_COLOR,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(27))
                        ),
                      ),
                      style: new TextStyle(
                        fontFamily: "HelveticaNeue",
                        fontSize: ScreenUtil().setSp(16)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(22),
                  ),
                  Text("Relevant results found",
                      style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      color: Colors.white.withOpacity(0.6000000238418579),
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      )
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Expanded(
                    child: _viewModel.isLoading ?
                    Center(
                      child: Loading(indicator: BallSpinFadeLoaderIndicator(), size: 48.0, color: Colors.white),
                    ) :
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.white,
                      ),
                      itemCount: _places.length,
                      itemBuilder: (context, index) => _locationListItem(
                        item: _places[index],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(60),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: ScreenUtil().setHeight(30),
              child:
              SizedBox(
                //height: 21,
                  width: size.width,
                  child: !_keyboardIsVisible() ?
                  Text(
                      appName,
                      style: smallLogoStyle,
                      textAlign: TextAlign.center
                  )
                      :
                  SizedBox()
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  void subscribeToViewModel() {
    _viewModel.getPlaces()
        .listen((places){
          _viewModel.isLoading = false;
          if(places != null) {
            setState(() {
              _places = places;
            });
          }
        });

    _viewModel.getPlaceResultStream()
        .listen((message){
          _viewModel.isLoading = false;
          if(message != null && message.isNotEmpty) {
            Fluttertoast.showToast(msg: message);
          }
          else{
            _viewModel.refreshWeather();
            _viewModel.clear();
            Navigator.pop(context, false);
          }
        });
  }

  Future<void> _showAddDialog(String placeId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add location'),
          content: Text('Are you sure you want to add location?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                _viewModel.addPlace(placeId);
                Navigator.of(context).pop();
                setState(() {
                  _viewModel.isLoading = true;
                });
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _locationListItem({@required Place item}) {
    return new InkWell(
        onTap: () => _showAddDialog(item.externalId),
        child: Container(
          height: ScreenUtil().setHeight(45),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(item.description,
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    )
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(70),
                child: FlatButton(
                  child: Text("+ Add",
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        color: AppColors.PRIMARY_COLOR,
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      )
                  ),
                  onPressed: null,
                ),
              )
            ],
          ),
        )
    );
  }
}