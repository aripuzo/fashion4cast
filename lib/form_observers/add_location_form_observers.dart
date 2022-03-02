import 'dart:async';

abstract class AddLocationFormObserverContract {

  //------------------------------------------------------------ Static Constants ------------------------------------------------------------------
  static const int SEARCH_VALID_LENGTH = 2;

  Sink get query;

  Stream<bool> get _isValidQuery;
  Stream<bool> get isSearchEnabled;

  AddLocationFormObserverContract(){
    _init();
  }

  void dispose();
  void invalidCredentials();


  void _init(){
    _handleLoginEnableProcess();
  }
  void _handleLoginEnableProcess();

  //Validation Methods
  bool _checkValidQuery(String query);

}

class AddLocationFormObserver extends AddLocationFormObserverContract{

  //------------------------------------------------------------ Observer variables -----------------------------------------------------------------

  // STREAM CONTROLLERS
  var _queryController = StreamController<String>.broadcast();
  var _isSearchEnabledController = StreamController<bool>.broadcast();

  // bool variable to temporarily store result of username and password validation
  bool _tempValidQuery;

  //------------------------------------------------------------- Constructor -----------------------------------------------------------------------

  AddLocationFormObserver():super();

  //------------------------------------------------------------- Contract Observer Methods ---------------------------------------------------------
  @override
  void _init() {
    super._init();
    _tempValidQuery = false;
  }

  @override
  void _handleLoginEnableProcess() {

    _isValidQuery.listen(
            (isValidQuery){
          if(isValidQuery){
            _tempValidQuery = true;
            _isSearchEnabledController.add(true);
          }else{
            _tempValidQuery = false;
            _isSearchEnabledController.add(false);
          }
        });
  }

  //----------------------------------------------------------- Contract Variables ----------------------------------------------------------------
  @override
  Stream<bool> get _isValidQuery => _queryController.stream.skip(AddLocationFormObserverContract.SEARCH_VALID_LENGTH).map(_checkValidQuery);

  @override
  Stream<bool> get isSearchEnabled =>  _isSearchEnabledController.stream;

  @override
  Sink get query => _queryController;


  //------------------------------------------------------- Contract Validation Methods --------------------------------------------------------------

  @override
  bool _checkValidQuery(String query)=> query != null && query.length >= AddLocationFormObserverContract.SEARCH_VALID_LENGTH;


  //--------------------------------------------------------- Contract Receiver Methods --------------------------------------------------------------

  @override
  void invalidCredentials() {

  }

  @override
  void dispose() {
    _queryController.close();
    _isSearchEnabledController.close();
  }

}