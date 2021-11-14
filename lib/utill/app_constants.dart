

import 'images.dart';

class AppConstants {

  // API list

  static const String BASE_URL='http://kilagbay.com/api';
  static const String Login_Uri='/auth/login';
  static const String Registration_Uri='/addAdmin';
  static const String UserInfo_Uri='/getAdmin/1';
  static const String PackageList_Uri='/dataProcessingPackage';
  static const String ScheduleLlist_Uri='/dataProcessingSchedule';
  static const String ScheduleAdd_Uri='/addSchedule';
  static const String ScheduleUpdate_Uri='/updateSchedule/';
  static const String ClientList_Uri='/dataProcessingClient';
  static const String AddClient_Uri='/addClient';
  static const String Trip_Uri='/dataProcessingTrip';
  static const String TripDetails_Uri='/getTrip/';
  static const String AddAccount_Uri='/addAccount';

  // Shared Key

  static const String TOKEN = 'token';
  static const String THEME = 'theme';
  static const String CURRENCY = 'currency';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String ADDRESS_ID = 'address_id';
  static const String USER_EMAIL = 'user_email';

  /*static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.united_kindom, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.bangladesh, languageName: 'Bangla', countryCode: 'BD', languageCode: 'bn'),
    ];*/
}
