import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPref{

      static final  String _userIdKey ="userId";
      static  get UserId async {
        var id = 0;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        id = prefs.getInt(_userIdKey);
        return id;

      }

    static SetUserID(int userId) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt( _userIdKey, userId);
    }
}