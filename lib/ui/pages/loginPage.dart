import 'package:flutter/material.dart';
import '../../data/bloc/accountBloc.dart';
import '../../data/bloc/provider/provider.dart';
import '../../ui/widgets/accountTextField.dart';

class LoginPage extends StatelessWidget {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff0022c0), Color(0xff006bff)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(60, 40),
                    bottomLeft: Radius.elliptical(60, 40))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Center(
              child: Text(
                'Welcome back',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: BlocProvider<AccountBloc>(
                blocSource: () => AccountBloc(context),
                builder: (BuildContext context, AccountBloc bloc) {
                  return Column(
                    children: [
                      StreamBuilder(
                          stream: bloc.userNameValidationStream,
                          builder: (context, snapshot) {
                            return MyTextField(
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Username',
                              prefixIcon: Icons.note_outlined,
                              errorText: snapshot.data,
                              onChanged: bloc.onUserNameChanged,
                              onTap: () {
                                controller.animateTo(
                                    MediaQuery.of(context).size.height * 0.5,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                              },
                            );
                          }),
                      StreamBuilder(
                          stream: bloc.passwordValidationStream,
                          builder: (context, snapshot) {
                            return MyTextField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              hintText: 'Password',
                              prefixIcon: Icons.lock,
                              errorText: snapshot.data,
                              onChanged: bloc.onPasswordChanged,
                              onTap: () {
                                controller.animateTo(
                                    MediaQuery.of(context).size.height * 0.5,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                              },
                            );
                          }),
                      Align(
                          alignment: Alignment.centerRight,
                          child:
                              /*TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Color(0xcc006bff)),
                            ))*/
                              Container(height: 30)),
                      Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 10),
                        child: RaisedButton(
                            child: Text(
                              'Log in',
                              style: TextStyle(color: Colors.white),
                            ),
                            padding: EdgeInsets.only(
                                left: 150, right: 150, top: 15, bottom: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: Color(0xff006bff),
                            onPressed: bloc.onLogInClicked),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                child: Divider(
                                  color: Colors.black38,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'or',
                                style: TextStyle(color: Color(0x99006bff)),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                child: Divider(
                                  color: Colors.black38,
                                ))
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: OutlinedButton(
                          onPressed: bloc.onLoginPageSignUpClick,
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Color(0xff006bff)),
                          ),
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.only(
                                  left: 145, right: 145, top: 15, bottom: 15),
                              side: BorderSide(color: Color(0xff006bff)),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    ));
  }
}
