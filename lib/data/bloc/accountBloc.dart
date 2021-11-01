import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../data/models/user.dart';
import '../../util/apiQuery.dart';
import '../../util/preferenceKeys.dart';
import '../../util/abstracts/disposable.dart';

class AccountBloc extends Disposable {
  final BuildContext context;
  final _fullName =
      GetIt.instance.get<BehaviorSubject>(instanceName: 'FullName');
  final _email = GetIt.instance.get<BehaviorSubject>(instanceName: 'Email');
  final _userName =
      GetIt.instance.get<BehaviorSubject>(instanceName: 'UserName');
  final _password =
      GetIt.instance.get<BehaviorSubject>(instanceName: 'Password');
  final _passwordRepeat =
      GetIt.instance.get<BehaviorSubject>(instanceName: 'PasswordRepeat');
  final _api = GetIt.instance.get<ApiQuery>();
  final _preference = GetIt.instance.get<SharedPreferences>();

  AccountBloc(this.context);

  Stream<String> get nameValidationStream =>
      _fullName.map((data) => validateName(data));

  Stream<String> get emailValidationStream =>
      _email.map((data) => validateEmail(data));

  Stream<String> get userNameValidationStream =>
      _userName.map((data) => validateUserName(data));

  Stream<String> get passwordValidationStream =>
      _password.map((data) => validatePassword(data));

  Stream<String> get passwordRepeatValidationStream =>
      _passwordRepeat.map((data) => validateRepeatPassword(data));

  void onNameChanged(String name) => _fullName.add(name);

  void onEmailChanged(String email) => _email.add(email);

  void onUserNameChanged(String userName) => _userName.add(userName);

  void onPasswordChanged(String password) => _password.add(password);

  void onRepeatPasswordChanged(String password) =>
      _passwordRepeat.add(password);

  String validateName(String textFieldInput) {
    if (textFieldInput == '' || textFieldInput == null)
      return '';
    else if (isNameValid(textFieldInput))
      return '';
    else
      return 'Name must be at least 5 characters long and two words';
  }

  bool isNameValid(String textFieldInput) =>
      (textFieldInput.contains(' ') && textFieldInput.length > 5)
          ? true
          : false;

  String validateUserName(String textFieldInput) {
    if (textFieldInput == '' || textFieldInput == null)
      return '';
    else if (isUserNameValid(textFieldInput))
      return '';
    else
      return 'UserName must be at least 3 characters long';
  }

  bool isUserNameValid(String textFieldInput) =>
      textFieldInput.length > 3 ? true : false;

  String validateEmail(String textFieldInput) {
    if (textFieldInput == '' || textFieldInput == null)
      return '';
    else if (isEmailValid(textFieldInput))
      return '';
    else
      return 'Invalid email';
  }

  bool isEmailValid(String textFieldInput) => (textFieldInput.length > 11 &&
          textFieldInput.contains('.com') &&
          textFieldInput.contains('@'))
      ? true
      : false;

  String validatePassword(String textFieldInput) {
    if (textFieldInput == '' || textFieldInput == null)
      return '';
    else if (isPasswordValid(textFieldInput))
      return '';
    else
      return 'Password must be at least 4 characters long';
  }

  bool isPasswordValid(String textFieldInput) =>
      textFieldInput.length > 4 ? true : false;

  String validateRepeatPassword(String textFieldInput) {
    if (textFieldInput == '' || textFieldInput == null)
      return '';
    else if (isPasswordSame(textFieldInput))
      return '';
    else
      return 'Passwords must match';
  }

  bool isPasswordSame(String textFieldInput) =>
      textFieldInput == _password.value ? true : false;

  void clearStreams() {
    _fullName.add(null);
    _userName.add(null);
    _email.add(null);
    _password.add(null);
    _passwordRepeat.add(null);
  }

  Future<bool> onSignUp() async {
    if (isNameValid(_fullName.value) &&
        isEmailValid(_email.value) &&
        isUserNameValid(_userName.value) &&
        isPasswordValid(_password.value) &&
        isPasswordSame(_passwordRepeat.value)) {
      QueryResult result = await _api.createUser(User(
          fullName: _fullName.value,
          userName: _userName.value,
          email: _email.value,
          passWord: _password.value));
      if (!result.hasException) {
        _preference.setInt(PreferenceKeys.userIdKey,
            result.data['insert_users']['returning'][0]['id']);
        _preference.setString(PreferenceKeys.createdAtKey,
            result.data['insert_users']['returning'][0]['created_at']);
        return true;
      }
    }
    return false;
  }

  Future<bool> login() async {
    QueryResult result = await _api
        .checkUser(User(userName: _userName.value, passWord: _password.value));
    bool isAUser = result.data['users'].isNotEmpty;
    if (isAUser) {
      _preference.setInt(
          PreferenceKeys.userIdKey, result.data['users'][0]['id']);
      _preference.setString(
          PreferenceKeys.createdAtKey, result.data['users'][0]['created_at']);
      return true;
    }
    return false;
  }

  onLogInClicked() async {
    bool isLoggedIn = await login();
    if (isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(context, '/homePage', (_) => false);
    } else {
      Toast.show('Unable to Log in. Check your inputs and internet connection',
          context,
          duration: 2);
    }
  }

  void onLoginPageSignUpClick() {
    clearStreams();
    Navigator.pushReplacementNamed(context, '/signUpPage');
  }

  void onSignUpPageSignUpClick()async{
    bool isSignedIn = await onSignUp();
    if (isSignedIn) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/homePage',(_)=>false);
    } else {
      Toast.show(
          'Unable to SignUp. Check your inputs and internet connection',
          context,
          duration: 2);
    }
  }

  Future<bool> onLogout() async =>
      await _preference.remove(PreferenceKeys.userIdKey) &&
      await _preference.remove(PreferenceKeys.createdAtKey);

  Future<void> onOk() async {
    if (await onLogout())
      Navigator.pushNamedAndRemoveUntil(context, '/openingPage', (_) => false);
    else
      Toast.show("Couldn't Log out. Please try again", context);
  }

  @override
  void dispose() {
    _fullName.close();
    _email.close();
    _userName.close();
    _password.close();
    _passwordRepeat.close();
  }
}
