import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../data/bloc/accountBloc.dart';
import '../../data/bloc/provider/provider.dart';
import '../../ui/widgets/accountTextField.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              height: MediaQuery.of(context).size.height * 0.31,
              child: Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: BlocProvider(
                    blocSource: () => AccountBloc(),
                    builder: (BuildContext context, AccountBloc bloc) {
                      return Column(children: [
                        StreamBuilder(
                            stream: bloc.nameValidationStream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return MyTextField(
                                  hintText: 'Bob Steven',
                                  prefixIcon: Icons.note_outlined,
                                  errorText: snapshot.data,
                                  onChanged: bloc.onNameChanged);
                            }),
                        StreamBuilder(
                            stream: bloc.emailValidationStream,
                            builder: (context, snapshot) {
                              return MyTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'XYZ@gmail.com',
                                  prefixIcon: Icons.email,
                                  errorText: snapshot.data,
                                  onChanged: bloc.onEmailChanged);
                            }),
                        StreamBuilder(
                            stream: bloc.userNameValidationStream,
                            builder: (context, snapshot) {
                              return MyTextField(
                                  hintText: 'Username',
                                  prefixIcon: Icons.note_outlined,
                                  errorText: snapshot.data,
                                  onChanged: bloc.onUserNameChanged);
                            }),
                        StreamBuilder(
                            stream: bloc.passwordValidationStream,
                            builder: (context, snapshot) {
                              return MyTextField(
                                  hintText: 'Password',
                                  obscureText: true,
                                  prefixIcon: Icons.lock,
                                  errorText: snapshot.data,
                                  onChanged: bloc.onPasswordChanged);
                            }),
                        StreamBuilder(
                            stream: bloc.passwordRepeatValidationStream,
                            builder: (context, snapshot) {
                              return MyTextField(
                                  hintText: 'Repeat Password',
                                  obscureText: true,
                                  prefixIcon: Icons.lock,
                                  errorText: snapshot.data,
                                  onChanged: bloc.onRepeatPasswordChanged);
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 10),
                          child: RaisedButton(
                              child: Text(
                                'Sign up',
                                style: TextStyle(color: Colors.white),
                              ),
                              padding: EdgeInsets.only(
                                  left: 145, right: 145, top: 15, bottom: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Color(0xff006bff),
                              onPressed: () async {
                                bool isSignedIn = await bloc.onSignUp();
                                if (isSignedIn) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/homePage',(_)=>false);
                                } else {
                                  Toast.show(
                                      'Unable to SignUp. Check your inputs and internet connection',
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
                              bloc.clearStreams();
                              Navigator.pushReplacementNamed(
                                  context, '/loginPage');
                            },
                            child: Text(
                              'Log in',
                              style: TextStyle(color: Color(0xff006bff)),
                            ),
                            style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.only(
                                    left: 150, right: 150, top: 15, bottom: 15),
                                side: BorderSide(color: Color(0xff006bff)),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        )
                      ]);
                    })),
          ],
        ),
      ),
    );
  }
}
