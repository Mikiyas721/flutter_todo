import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/data/models/user.dart';
import 'package:todo/util/apiQuery.dart';
import '../../util/abstracts/disposable.dart';

class AccountBloc extends Disposable {
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
      return result.hasException ? false : true;
    } else
      return false;
  }

  Future<bool> onLogIn() async {
    QueryResult result = await _api
        .checkUser(User(userName: _userName.value, passWord: _password.value));
    return result.data['users'].isEmpty ? false : true;
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
