import 'package:flutter/material.dart';
import 'User.dart';
import 'detail.dart';
import 'message.dart';

final Set<String> sets = new Set<String>();
class friend extends StatefulWidget {
  final User user;
  friend({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() => friendState(user: this.user);
}

class friendState extends State<friend> {
  final User user;
  friendState({@required this.user});
  @override
  Widget build(BuildContext context) {
    print(this.user.username);
    return Scaffold(
      appBar: AppBar(
        title: Text('好友列表'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
            },
          ),
        ],
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
      sets.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    sets.clear();
    sets.add('a');
    sets.add('b');
    sets.add('c');
    return new Scaffold(
      body: new ListView(
        children: sets.map((p) {
          return new ItemWidget(p);
        }).toList(),
      ),
    );
  }
}
//数据实体
//liveview子项
class ItemWidget extends StatelessWidget {
  final String _activity;

  ItemWidget(this._activity);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListTile(
      leading: new CircleAvatar(
        child: new Text(_activity),
        backgroundColor: Colors.blue[400],
      ),
      title: new Text(_activity),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.push<String>(context,
            new MaterialPageRoute(builder: (context) {
              return new FriendlychatApp();
            }));
      },
    );
  }
}
