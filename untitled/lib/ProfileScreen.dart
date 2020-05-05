import 'package:flutter/material.dart';
import 'User.dart';
import 'main.dart';
class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() => ProfileScreenState(user: this.user);
}


class ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin{
  final User user;
  ProfileScreenState({@required this.user});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(this.user.username);
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

                      this.user.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      this.user.password,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
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
}




