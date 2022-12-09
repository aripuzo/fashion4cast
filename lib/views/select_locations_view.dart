import 'package:circle_checkbox/redev_checkbox.dart';
import 'package:fashion4cast/app/app.dart';
import 'package:fashion4cast/app/app_routes.dart';
import 'package:fashion4cast/resources/values/app_colors.dart';
import 'package:fashion4cast/resources/values/text_styles.dart';
import 'package:fashion4cast/view_models/select_location_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../databases/app_database.dart';

class SelectLocations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectCitiesState();
}

class _SelectCitiesState extends State<SelectLocations> {

  SelectLocationViewModel _viewModel;

  int _selected;

  List<Place> _savedPlaces = [];

  @override
  void initState() {

    _viewModel = SelectLocationViewModel(App());
    subscribeToViewModel();

    _selected = App().getAppPreferences().getDefaultPlace();

    _viewModel.loadPlaces();

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
                    height: ScreenUtil().setHeight(38),
                    width: ScreenUtil.defaultSize.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Locations",
                            style: titleTextStyle
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(110),
                          child: TextButton(
                            onPressed:() => Navigator.pushNamed(context, AppRoutes.APP_ROUTE_ADD_LOCATIONS),
                            child: Text("+ Add City",
                                style: TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  color: Color(0xffffffff),
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(51),
                  ),
                  Text("Select a city below to make it your default",
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        color: Colors.white.withOpacity(0.6000000238418579),
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      )
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(28),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.white,
                      ),
                      itemCount: _savedPlaces.length,
                      itemBuilder: (context, index) => _locationListItem(
                        item: _savedPlaces[index],
                        isSelected: _savedPlaces[index].id == _selected,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
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
                  child:   Text(
                      appName,
                      style: smallLogoStyle,
                      textAlign: TextAlign.center
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  void subscribeToViewModel() {
    _viewModel.getMyPlaces()
        .listen(
            (places){
          if(places != null && places.isNotEmpty) {
            setState(() {
              _savedPlaces = places;
            });
          }
        });
  }

  Widget _locationListItem({@required Place item, bool isSelected = false}) {
    return new InkWell(
        onTap: (){
          _viewModel.setDefaultPlace(item.id);
          setState(() {
            _selected = item.id;
          });
        },
        child: Container(
          height: ScreenUtil().setHeight(45),
          child: Stack(
            children: <Widget>[
              PositionedDirectional(
                top: ScreenUtil().setHeight(8.0),
                start: 0,
                child: Text(
                    item.name,
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    )
                ),
              ),
              PositionedDirectional(
                top: 0.0,
                end: 0,
                bottom: 0.0,
                child: Center(
                  child: isSelected ?
                  SizedBox(
                    width: ScreenUtil().setWidth(12),
                    height: ScreenUtil().setWidth(12),
                    child: CircleCheckbox(
                      value: true,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (bool x) {
                        //someBooleanValue = !someBooleanValue;
                      },
                      activeColor: AppColors.PRIMARY_COLOR,
                    ),
                  ):
                  SizedBox(),
                ),
              ),
            ],
          ),
        )
    );
  }
}