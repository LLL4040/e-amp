import 'package:flutter/material.dart';
import 'User.dart';
import 'Activity.dart';
import 'detail.dart';
  List<Activity> sets = [];
class EmailScreen extends StatefulWidget {
  final User user;
  EmailScreen({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() => EmailScreenState(user: this.user);
}

class EmailScreenState extends State<EmailScreen> with NetListener{
  final User user;
  EmailScreenState({@required this.user});//导航栏
  activityHttp manager = new activityHttp();
  @override
  Widget build(BuildContext context) {
    print(this.user.username);
    return Scaffold(
      appBar: AppBar(
        title: Text('活动管理'),
      ),
      body: ListViewWidget(user: user,),
    );
  }
  _getActivity() async {
    print("aaaaaaaaa");

    await manager.myJoinActivity(this,user.getUsername());
    return true;
  }

  @override
  void initState() {
    super.initState();
    _getActivity();
  }
  @override
  onMyNoticeResponse(List<Activity> activities){
    sets = activities;
  }
  @override
  void onAddActivityResponse(String result) {
    // TODO: implement onAddActivityResponse
  }
  @override
  void onError(error) {}
}


class ListViewWidget extends StatefulWidget {
  final User user;
  ListViewWidget({@required this.user});//导航栏
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ListViewState(user: user);
  }
}

class ListViewState extends State<ListViewWidget> {
  final User user;
  ListViewState({@required this.user});//导航栏
  List<ItemWidget> list = new List<ItemWidget>();

  add() {
    print('回调了add()');
    setState(() {
      sets.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    // TODO: implement build
    //sets.add(new Activity('广场舞','1','2020-05-05 11:11:11','2020-05-06 11:11:11',20,'东十五',
    //'快来玩呀，非常好玩后i过后i分工i法施工i十点过后i法国哈佛i额度过后i范国洪i额我发给i哦额后i反围攻i围攻i范围广i哦分是我','武仙神','舞蹈','0',"http://cms-bucket.ws.126.net/2019/06/20/68fa7f186ffe4479ab27efabd4d94246.png?imageView&thumbnail=190y120"));
    return new Scaffold(
      body: new ListView(
        children: sets.map((p) {
          return new ItemWidget(p,user);
        }).toList(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: add,
//        onPressed: null,
        tooltip: 'add',
        child: new Icon(Icons.cached),
        backgroundColor: Colors.blue[400],
      ),
    );
  }

}
//数据实体
//liveview子项
class ItemWidget extends StatelessWidget {
  final User user;
  final Activity _activity;

  ItemWidget(this._activity,this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListTile(
      leading: new CircleAvatar(
        child: new Text(_activity.getName()[0]),
        backgroundColor: Colors.blue[400],
      ),
      title: new Text(_activity.getName()),
      subtitle: new Text(_activity.getDescription()),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.push<String>(context,
            new MaterialPageRoute(builder: (context) {
              return new detail(activity: _activity,user: user,);
            }));
      },
    );
  }
}
