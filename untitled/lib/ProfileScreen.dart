import 'package:flutter/material.dart';
import 'package:untitled/friend.dart';
import 'User.dart';
import 'main.dart';
import 'message.dart';
import 'dart:convert';
class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() => ProfileScreenState(user: this.user);
}

String message;
class ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin,UserListener{
  final User user;
  ProfileScreenState({@required this.user});
  userHttp manager = userHttp();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(this.user.username);
    manager.recommandActivity(this, user.getUsername());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
        ],
        title: Text('个人中心'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    child: Image.asset(
                      "images/app.png",
                      width: 80,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '账号名:'+this.user.username,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: ClipOval(
                    child: RaisedButton(
                      child: Text('更多'),
                      color: Colors.white,
                      textColor: Colors.lightBlue,
                      onPressed: () {
                        showDialog<Null>(
                          context: context,
                          builder: (BuildContext context) {
                            return new SimpleDialog(
                              title: new Text('个人信息'),
                              children: <Widget>[
                                new SimpleDialogOption(
                                  child: new Text('积分'+json.decode(message)['grade'].toString()),
                                ),
                                new SimpleDialogOption(
                                ),
                                new SimpleDialogOption(
                                  child: new Text('经验'+json.decode(message)['experience'].toString()),
                                ),
                              ],
                            );
                          },
                        ).then((val) {
                          print(val);
                        });
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.people_outline),
                    title: const Text('我的好友'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    Navigator.push<String>(context,
                        new MaterialPageRoute(builder: (context) {
                          return new friend(user: user,);
                        }));
                  },

                ),

              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new MyApp(user: User("sss","dds"),)
              ), (route) => route == null);
        },
        tooltip: '退出登录',
        child: Icon(Icons.keyboard_return),
      ),
    );
  }

  @override
  void onMessageResponse(String res) {
    // TODO: implement onAddActivityResponse
    message = res;
    print(message);
  }
  @override
  void onError(error) {}
}




