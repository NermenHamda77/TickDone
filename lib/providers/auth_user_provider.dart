import 'package:flutter/widgets.dart';
import 'package:tick_done_app/model/my_user.dart';

class AuthUserProvider extends ChangeNotifier{
  MyUser? currentUser;
  void updateUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }
}