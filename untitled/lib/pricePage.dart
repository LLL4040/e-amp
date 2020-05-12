import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Activity.dart';
import 'package:untitled/User.dart';
import 'package:untitled/price.dart';
import 'dart:async';
import 'mainpage.dart';
import 'package:fluttertoast/fluttertoast.dart';
class pricePage extends StatefulWidget {
  final User user;
  final Activity activity;
  pricePage({Key key,@required this.user,@required this.activity}):super(key:key);
  @override
  State<StatefulWidget> createState() => _DateTimeDemoState(user: user,activity: activity);
}

class _DateTimeDemoState extends State<pricePage> with SingleTickerProviderStateMixin,PriceListener{
  String res = '';
  final User user;
  final Activity activity;
  _DateTimeDemoState({@required this.user,@required this.activity});
  final TextEditingController _alocation =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));
  final TextEditingController _anum =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));
  //http
  priceHttp manager = new priceHttp();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('发起活动'),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check_circle_outline),
              onPressed: (){
                _addActivity();
                Fluttertoast.showToast(
                  msg: "添加抽奖成功",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: new SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  color: Colors.white,
                  height: 30.0,
                  width: 0.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(
                            0.0, 0.0, 5.0, 0.0),
                        child: Icon(Icons.location_city),
                      ),
                      new Expanded(
                          child: new TextField(
                            controller: _alocation,
                            decoration: new InputDecoration(
                              hintText: '奖品',
                            ),
                            obscureText: false,
                          )),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(
                            0.0, 0.0, 5.0, 0.0),
                        child: Icon(Icons.people),
                      ),
                      new Expanded(
                          child: new TextField(
                            controller: _anum,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              hintText: '数量',
                            ),
                            obscureText: true,
                          )),
                    ]
                ),

              ],
            ),
          ),
        )
    );
  }
  _addActivity() async {
    print(activity.getEnd());

    await manager.startPrice(this,user.getUsername(),activity.getId(),_alocation.text,int.parse(_anum.text));
    print("发送成功"+res);
  }
  @override
  onMessageResponse(String res){

  }
  @override
  void onError(error) {}
}
