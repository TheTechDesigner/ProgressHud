import 'dart:async';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'Progress Hub';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Center(
          child: Builder(
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            padding: EdgeInsets.all(16.0),
                            color: Color(0xFFC41A3B),
                            onPressed: () {
                              _showSuccess(context);
                            },
                            child: Text(
                              'Success',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFBE0E6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            padding: EdgeInsets.all(16.0),
                            color: Color(0xFFC41A3B),
                            onPressed: () {
                              _showError(context);
                            },
                            child: Text(
                              'Error',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFBE0E6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            padding: EdgeInsets.all(16.0),
                            color: Color(0xFFC41A3B),
                            onPressed: () {
                              _showLoading(context);
                            },
                            child: Text(
                              'Loading',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFBE0E6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            padding: EdgeInsets.all(16.0),
                            color: Color(0xFFC41A3B),
                            onPressed: () {
                              _showProgress(context);
                            },
                            child: Text(
                              'Progress',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFBE0E6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _showSuccess(BuildContext context) {
    ProgressHud.of(context).showAndDismiss(ProgressHudType.success, 'Success');
  }

  _showError(BuildContext context) {
    ProgressHud.of(context).showAndDismiss(ProgressHudType.error, 'Error');
  }

  _showLoading(BuildContext context) async {
    ProgressHud.of(context).show(ProgressHudType.loading, 'Loading...');
    await Future.delayed(
      Duration(seconds: 1),
    );
    ProgressHud.of(context).dismiss();
  }

  _showProgress(BuildContext context) {
    var _progress = ProgressHud.of(context);
    _progress.show(
        ProgressHudType.progress, 'Progress'); // you can use like this also

    double _current = 0;
    Timer.periodic(
      Duration(milliseconds: 1000.0 ~/ 60),
      (timer) {
        _current += 1;
        var _progress1 = _current / 100;
        _progress.updateProgress(_progress1, 'Loading... $_current');
        if (_progress1 == 1) {
          _progress.showAndDismiss(ProgressHudType.success, 'Success');
          timer.cancel();
        }
      },
    );
  }
}
