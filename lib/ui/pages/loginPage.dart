import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../data/bloc/accountBloc.dart';
import '../../data/bloc/provider/provider.dart';
import '../../ui/widgets/myTextField.dart';

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
            child: BlocProvider(
                blocSource: () => AccountBloc(),
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
                              onChanged: bloc.validateUserName,
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
                              onChanged: bloc.validatePassword,
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
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Color(0xcc006bff)),
                            )),
                      ),
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
                            onPressed: () async {
                              bool isLoggedIn = await bloc.onLogIn();
                              if (isLoggedIn) {
                                Navigator.pushReplacementNamed(
                                    context, '/homePage');
                              } else {
                                Toast.show(
                                    'Unable to Log in. Check your inputs and internet connection',
                                    context,
                                    duration: 2);
                              }
                            }),
                      ),
                      Center(
                          child: Text(
                        'or',
                        style: TextStyle(color: Color(0x99006bff)),
                      )),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/signUpPage');
                          },
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
