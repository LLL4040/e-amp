import 'package:flutter/material.dart';
import 'package:untitled/mainpage.dart';
import 'User.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final User user;
  MyApp({Key key,@required this.user}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MainApp',
      home: LoginWidget(),
    );
  }
}
class LoginWidget extends StatefulWidget {
  @override
  _Login createState() {
    return new _Login();
  }
}
class _Login extends State<LoginWidget> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    print("初始化登陆界面");
  }
  final TextEditingController _username =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));
  final TextEditingController _password =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));

  bool loginSuccess = false;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
            title: '小区登录',
            home: new Scaffold(
              appBar: new AppBar(
                title: new Text('账号登录'),
              ),
              body: new SingleChildScrollView(
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new SizedBox(
                      height: 200,
                      child: new Image.asset(
                        'images/app.png',
                        scale: 4.0,
                      ),
                    ),
                    new Padding(
                      padding:
                      new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Padding(
                              padding: new EdgeInsets.fromLTRB(
                                  0.0, 0.0, 5.0, 0.0),
                              child: Icon(Icons.account_circle),
                            ),
                            new Expanded(
                                child: new TextField(
                                  controller: _username,
                                  decoration: new InputDecoration(
                                    hintText: '请输入用户名',

                                  ),
                                ))
                          ]),
                    ),
                    new Padding(
                      padding:
                      new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 40.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Padding(
                              padding: new EdgeInsets.fromLTRB(
                                  0.0, 0.0, 5.0, 0.0),
                              child: Icon(Icons.lock),
                            ),
                            new Expanded(
                                child: new TextField(
                                  controller: _password,
                                  decoration: new InputDecoration(
                                    hintText: '请输入密码',
                                  ),
                                  obscureText: true,
                                ))
                          ]),
                    ),
                    //forgetSession,
                    new Padding(
                      padding:
                      new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 40.0),
                      child: new FlatButton(
                        color: Colors.blue[300],
                        child: new Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Text(
                            '登录',
                            style: new TextStyle(color: Colors.grey[900], fontSize: 16.0),
                          ),
                        ),
                        onPressed:(){
                          Navigator.of(context).pushAndRemoveUntil(
                              new MaterialPageRoute(builder: (context) => new MysApp(user: User(_username.text,_password.text),)
                              ), (route) => route == null);
                        } ,
                      ),
                    ),
                  ],
                ),
              ),
            )
    );
      }
  }

