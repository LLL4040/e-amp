import 'package:flutter/material.dart';
import 'User.dart';

final Set<Activity> sets = new Set<Activity>();
class EmailScreen extends StatefulWidget {
  final User user;
  EmailScreen({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() => EmailScreenState(user: this.user);
}

class EmailScreenState extends State<EmailScreen> {
  final User user;
  EmailScreenState({@required this.user});
  @override
  Widget build(BuildContext context) {
    print(this.user.username);
    return Scaffold(
      appBar: AppBar(
        title: Text('活动管理'),
      ),
      body: ListViewWidget(),
    );
  }
}


class ListViewWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ListViewState();
  }
}

class ListViewState extends State<ListViewWidget> {

  List<ItemWidget> list = new List<ItemWidget>();

  add() {
    print('回调了add()');
    setState(() {
      sets.add(new Activity('活动 ${sets.length + 1}', '我是第${sets.length + 1}个活动'));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new ListView(
        children: sets.map((p) {
          return new ItemWidget(p);
        }).toList(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: add,
//        onPressed: null,
        tooltip: 'add',
        child: new Icon(Icons.add),
        backgroundColor: Colors.blue[400],
      ),
    );
  }
}
//数据实体
class Activity {
  String name;
  String info;

  Activity(this.name, this.info);
}
//liveview子项
class ItemWidget extends StatelessWidget {
  final Activity _activity;

  ItemWidget(this._activity);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListTile(
      leading: new CircleAvatar(
        child: new Text(_activity.name[0]),
        backgroundColor: Colors.blue[400],
      ),
      title: new Text(_activity.name),
      subtitle: new Text(_activity.info),
    );
  }
}
