import 'package:fashion4cast/databases/app_database.dart';
import 'package:fashion4cast/databases/app_preferences.dart';
import 'package:fashion4cast/repository/ad_repository.dart';
import 'package:fashion4cast/repository/forgot_password_repository.dart';
import 'package:fashion4cast/repository/location_repository.dart';
import 'package:fashion4cast/repository/login_repository.dart';
import 'package:fashion4cast/repository/product_repository.dart';
import 'package:fashion4cast/repository/register_repository.dart';
import 'package:fashion4cast/repository/reset_password_repository.dart';
import 'package:fashion4cast/repository/user_repository.dart';
import 'package:fashion4cast/repository/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app_routes.dart';

/// App Class -> Application Class
class App extends StatelessWidget {
  //-------------------------------------------------------------- Singleton-Instance --------------------------------------------------------------
  // Singleton-Instance
  static final App _instance = App._internal();

  AppDatabase appDatabase;

  /// App Private Constructor -> App
  /// @param -> _
  /// @usage -> Create Instance of App
  App._internal();

  /// App Factory Constructor -> App
  /// @dependency -> _
  /// @usage -> Returns the instance of app
  factory App() => _instance;

  bool _requireConsent = true;

//  AppDatabase appDatabase;

  //------------------------------------------------------------ Widget Methods --------------------------------------------------------------------

  /// @override Build Method -> Widget
  /// @param -> context -> BuildContext
  /// @returns -> Returns widget as MaterialApp class instance
  @override
  Widget build(BuildContext context) {
    initPlatformState();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: getAppRoutes().getRoutes,
    );
  }

  //------------------------------------------------------------- App Methods -------------------------------------------------------------------------

  /// Get App Routes Method -> AppRoutes
  /// @param -> _
  /// @usage -> Returns the instance of AppRoutes class
  AppRoutes getAppRoutes(){
    return AppRoutes();
  }

  /// Get App Preferences Method -> AppPreferences
  /// @param -> _
  /// @usage -> Returns the instance of AppPreferences class
  AppPreferences getAppPreferences(){
    return AppPreferences();
  }

  Future<AppDatabase> getAppDatabase() async {
    final database = AppDatabase();
    return database;
  }

  void logout() {
    var _appPreferences = getAppPreferences();
    _appPreferences.setLoggedIn(isLoggedIn: false);
    _appPreferences.setToken(token: null);
    _appPreferences.setUser(user: null);
    _appPreferences.logout();
    App().appDatabase.placeDao.deleteAllPlaces();
  }

//  Future<AppDatabase> getAppDatabase() async {
//    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
//    return database;
//  }
//
  /// Get Login Repository Method -> LoginRepository
  /// @param -> appPreferences -> AppPreferences
  /// @usage -> Returns the instance of LoginRepository class by injecting AppPreferences dependency
  LoginRepository getLoginRepository({@required AppPreferences appPreferences}){
    return LoginRepository(appPreferences: appPreferences);
  }

  RegisterRepository getRegisterRepository({@required AppPreferences appPreferences}){
    return RegisterRepository(appPreferences: appPreferences);
  }

  ForgotPasswordRepository getForgotPasswordRepository({AppPreferences appPreferences}) {
    return ForgotPasswordRepository(appPreferences: appPreferences);
  }

  ResetPasswordRepository getResetPasswordRepository({AppPreferences appPreferences}) {
    return ResetPasswordRepository(appPreferences: appPreferences);
  }

  LocationRepository getLocationRepository({AppPreferences appPreferences}) {
    return LocationRepository(appPreferences: appPreferences);
  }

  WeatherRepository getWeatherRepository({AppPreferences appPreferences}) {
    return WeatherRepository(appPreferences: appPreferences);
  }

  ProductRepository getProductRepository({AppPreferences appPreferences}) {
    return ProductRepository(appPreferences: appPreferences);
  }

  UserRepository getUserRepository({AppPreferences appPreferences}) {
    return UserRepository(appPreferences: appPreferences);
  }

  AdRepository getAdRepository({AppPreferences appPreferences}) {
    return AdRepository(appPreferences: appPreferences);
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init(
        "e6f14b42-3e13-4903-8f9d-a912d4ec78fb",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    //await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

    var status = await OneSignal.shared.getPermissionSubscriptionState();

    if(!status.permissionStatus.hasPrompted)
      OneSignal.shared.addTrigger("prompt_ios", "true");
  }

//  void _handleGetTags() {
//    OneSignal.shared.getTags().then((tags) {
//      if (tags == null) return;
//
//      setState((() {
//        _debugLabelString = "$tags";
//      }));
//    }).catchError((error) {
//      setState(() {
//        _debugLabelString = "$error";
//      });
//    });
//  }
//
//  void _handleSendTags() {
//    print("Sending tags");
//    OneSignal.shared.sendTag("test2", "val2").then((response) {
//      print("Successfully sent tags with response: $response");
//    }).catchError((error) {
//      print("Encountered an error sending tags: $error");
//    });
//  }
//
//  void _handlePromptForPushPermission() {
//    print("Prompting for Permission");
//    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//      print("Accepted permission: $accepted");
//    });
//  }
//
//  void _handleGetPermissionSubscriptionState() {
//    print("Getting permissionSubscriptionState");
//    OneSignal.shared.getPermissionSubscriptionState().then((status) {
//      this.setState(() {
//        _debugLabelString = status.jsonRepresentation();
//      });
//    });
//  }
//
//  void _handleSetEmail() {
//    if (_emailAddress == null) return;
//
//    print("Setting email");
//
//    OneSignal.shared.setEmail(email: _emailAddress).whenComplete(() {
//      print("Successfully set email");
//    }).catchError((error) {
//      print("Failed to set email with error: $error");
//    });
//  }
//
//  void _handleLogoutEmail() {
//    print("Logging out of email");
//    OneSignal.shared.logoutEmail().then((v) {
//      print("Successfully logged out of email");
//    }).catchError((error) {
//      print("Failed to log out of email: $error");
//    });
//  }
//
//  void _handleConsent() {
//    print("Setting consent to true");
//    OneSignal.shared.consentGranted(true);
//
//    print("Setting state");
//    this.setState(() {
//      _enableConsentButton = false;
//    });
//  }
//
//  void _handleSetLocationShared() {
//    print("Setting location shared to true");
//    OneSignal.shared.setLocationShared(true);
//  }
//
//  void _handleDeleteTag() {
//    print("Deleting tag");
//    OneSignal.shared.deleteTag("test2").then((response) {
//      print("Successfully deleted tags with response $response");
//    }).catchError((error) {
//      print("Encountered error deleting tag: $error");
//    });
//  }
//
//  void _handleSetExternalUserId() {
//    print("Setting external user ID");
//    OneSignal.shared.setExternalUserId(_externalUserId);
//    this.setState(() {
//      _debugLabelString = "Set External User ID";
//    });
//  }
//
//  void _handleRemoveExternalUserId() {
//    OneSignal.shared.removeExternalUserId();
//    this.setState(() {
//      _debugLabelString = "Removed external user ID";
//    });
//  }
//
//  void _handleSendNotification() async {
//    var status = await OneSignal.shared.getPermissionSubscriptionState();
//
//    var playerId = status.subscriptionStatus.userId;
//
//    var imgUrlString =
//        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";
//
//    var notification = OSCreateNotification(
//        playerIds: [playerId],
//        content: "this is a test from OneSignal's Flutter SDK",
//        heading: "Test Notification",
//        iosAttachments: {"id1": imgUrlString},
//        bigPicture: imgUrlString,
//        buttons: [
//          OSActionButton(text: "test1", id: "id1"),
//          OSActionButton(text: "test2", id: "id2")
//        ]);
//
//    var response = await OneSignal.shared.postNotification(notification);
//
//    this.setState(() {
//      _debugLabelString = "Sent notification with response: $response";
//    });
//  }

//  void _handleSendSilentNotification() async {
//    var status = await OneSignal.shared.getPermissionSubscriptionState();
//
//    var playerId = status.subscriptionStatus.userId;
//
//    var notification = OSCreateNotification.silentNotification(
//        playerIds: [playerId], additionalData: {'test': 'value'});
//
//    var response = await OneSignal.shared.postNotification(notification);
//
//    this.setState(() {
//      _debugLabelString = "Sent notification with response: $response";
//    });
//  }
//
//  oneSignalInAppMessagingTriggerExamples() async {
//    /// Example addTrigger call for IAM
//    /// This will add 1 trigger so if there are any IAM satisfying it, it
//    /// will be shown to the user
//    OneSignal.shared.addTrigger("trigger_1", "one");
//
//    /// Example addTriggers call for IAM
//    /// This will add 2 triggers so if there are any IAM satisfying these, they
//    /// will be shown to the user
//    Map<String, Object> triggers = new Map<String, Object>();
//    triggers["trigger_2"] = "two";
//    triggers["trigger_3"] = "three";
//    OneSignal.shared.addTriggers(triggers);
//
//    // Removes a trigger by its key so if any future IAM are pulled with
//    // these triggers they will not be shown until the trigger is added back
//    OneSignal.shared.removeTriggerForKey("trigger_2");
//
//    // Get the value for a trigger by its key
//    Object triggerValue = await OneSignal.shared.getTriggerValueForKey("trigger_3");
//    print("'trigger_3' key trigger value: " + triggerValue);
//
//    // Create a list and bulk remove triggers based on keys supplied
//    List<String> keys = new List<String>();
//    keys.add("trigger_1");
//    keys.add("trigger_3");
//    OneSignal.shared.removeTriggersForKeys(keys);
//
//    // Toggle pausing (displaying or not) of IAMs
//    OneSignal.shared.pauseInAppMessages(false);
//  }

//  oneSignalOutcomeEventsExamples() async {
//    // Await example for sending outcomes
//    outcomeAwaitExample();
//
//    // Send a normal outcome and get a reply with the name of the outcome
//    OneSignal.shared.sendOutcome("normal_1");
//    OneSignal.shared.sendOutcome("normal_2").then((outcomeEvent) {
//      print(outcomeEvent.jsonRepresentation());
//    });
//
//    // Send a unique outcome and get a reply with the name of the outcome
//    OneSignal.shared.sendUniqueOutcome("unique_1");
//    OneSignal.shared.sendUniqueOutcome("unique_2").then((outcomeEvent) {
//      print(outcomeEvent.jsonRepresentation());
//    });
//
//    // Send an outcome with a value and get a reply with the name of the outcome
//    OneSignal.shared.sendOutcomeWithValue("value_1", 3.2);
//    OneSignal.shared.sendOutcomeWithValue("value_2", 3.9).then((outcomeEvent) {
//      print(outcomeEvent.jsonRepresentation());
//    });
//  }
//
//  Future<void> outcomeAwaitExample() async {
//    var outcomeEvent = await OneSignal.shared.sendOutcome("await_normal_1");
//    print(outcomeEvent.jsonRepresentation());
//  }

}