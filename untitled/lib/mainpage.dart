import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'EmailScreen.dart';
import 'ProfileScreen.dart';
import 'User.dart';
void main() => runApp(new MysApp());

class MysApp extends StatelessWidget {
 final User user;
 MysApp({Key key,@required this.user}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue
      ),
      home: Scaffold(
        body: new BottomNavigationWidget(user:this.user),
      )
    );
  }
}
class BottomNavigationWidget extends StatefulWidget {
  User user;
  BottomNavigationWidget({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    return new BottomNavigationWidgetState(user: this.user);
  }
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final User user;
  BottomNavigationWidgetState({@required this.user});

  int _currentIndex = 0;
  List<Widget> list = List();
  @override
  void initState(){
    list
      ..add(HomeScreen(user: this.user,))
      ..add(EmailScreen(user: this.user,))
      ..add(ProfileScreen(user: this.user,));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(this.user.username);
    /*
    返回一个脚手架，里面包含两个属性，一个是底部导航栏，另一个就是主体内容
     */
    return new Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //底部导航栏的创建需要对应的功能标签作为子项，这里我就写了3个，每个子项包含一个图标和一个title。
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: new Text(
                '首页',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_border,
              ),
              title: new Text(
                '活动',
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              title: new Text(
                '我的',
              )),
        ],
        //这是底部导航栏自带的位标属性，表示底部导航栏当前处于哪个导航标签。给他一个初始值0，也就是默认第一个标签页面。
        currentIndex: _currentIndex,
        //这是点击属性，会执行带有一个int值的回调函数，这个int值是系统自动返回的你点击的那个标签的位标
        onTap: (int i) {
          //进行状态更新，将系统返回的你点击的标签位标赋予当前位标属性，告诉系统当前要显示的导航标签被用户改变了。
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}
