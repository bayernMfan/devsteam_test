import 'dart:ui';

import 'package:devsteam_test/bloc/auth_bloc/auth_bloc.dart';
import 'package:devsteam_test/repo/API/auth_API.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';

import 'gallery_page.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(Auth()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            Image(
              image: AssetImage(
                  "assets/images/elias-maurer-QSwk-0XxDBk-unsplash.jpg"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is IsAuthenticating)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (state is AuthDone)
                SchedulerBinding.instance.addPostFrameCallback(
                  //(_) => Navigator.pushNamed(context, '/GalleryPage'));
                  (_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GalleryPage(authToken: state.getAuthToken)),
                    );
                  },
                );
              else if (state is AuthNotDone)
                return Text(
                  state.getMessage,
                  style: TextStyle(color: Colors.black),
                );
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Please, pick a token below to authenticate:',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    AccountPicker(
                      accountName: 'AuthToken#1',
                      accountToken:
                          'cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0',
                    ),
                    AccountPicker(
                      accountName: 'AuthToken#2',
                      accountToken:
                          'ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9',
                    ),
                    AccountPicker(
                      accountName: 'AuthToken#3',
                      accountToken:
                          '896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043',
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class AccountPicker extends StatelessWidget {
  final String accountName;
  final String accountToken;
  const AccountPicker({
    Key key,
    this.accountName,
    this.accountToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "$accountName",
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            RaisedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(StartAuth("$accountToken"));
              },
              child: Text('AUTH'),
            )
          ],
        ),
      ),
    );
  }
}
