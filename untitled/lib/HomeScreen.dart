import 'package:flutter/material.dart';
import 'package:untitled/Activity.dart';
import 'package:untitled/detail.dart';
import 'User.dart';
import 'AddActivity.dart';
const TITLE  = '标题标题标题标题标题标题标题';
const SUB_TITLE = '二级标题二级标题二级标题二级标题二级标题二级标题二级标题二级标题二';
const IMAGE_SRC =
    'http://cms-bucket.ws.126.net/2019/06/20/68fa7f186ffe4479ab27efabd4d94246.png';
List<Activity> newsList = [];
class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() => HomeScreenState(user: this.user);
}

class HomeScreenState extends State<HomeScreen> with NetListener{
  final User user;
  HomeScreenState({@required this.user});
  activityHttp manager = new activityHttp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (context) {
                    return new AddActivity(user: user,);
                  }));
            },
          ),
        ],
      ),
      body: HomeContent(user: user,),
      floatingActionButton: new FloatingActionButton(
        onPressed:(){
          manager.recommandActivity(this,user.getUsername());
          setState(() {

          });
        },
//        onPressed: null,
        tooltip: 'add',
        child: new Icon(Icons.cached),
        backgroundColor: Colors.blue[400],
      ),
    );
  }
  _getActivity() async {
    print("aaaaaaaaa");
    await manager.myActivity(this);
    return true;
  }
  @override
  void initState() {
    super.initState();
    _getActivity();
  }
  @override
  onMyNoticeResponse(List<Activity> activities){
    newsList = activities;
  }
  @override
  void onAddActivityResponse(String result) {
    // TODO: implement onAddActivityResponse
  }
  @override
  void onError(error) {}
}

class HomeContent extends StatelessWidget {
  final User user;
  HomeContent({@required this.user});
  Widget buildItem(BuildContext context, int index) {
    Activity news = newsList[index];
    print(news.getName());
    return CardItem2(
      name: news.getName(),
      id: news.getId(),
      start: news.getStart(),
      end: news.getEnd(),
      num: news.getNum(),
      location: news.getLocation(),
      description: news.getDescription(),
      sponsor: news.getSponsor(),
      tags: news.getTags(),
      status: news.getStatus(),
      imgurl: news.getImgurl(),
      user: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: buildItem,
    );
    // return ListView(
    //   children: <Widget>[
    //     CardItem(),
    //     CardItem2(),
    //     CardItem2(),
    //   ],
    //   padding: EdgeInsets.only(top: 20),
    // );
  }
}



class CardItem2 extends StatelessWidget {
  CardItem2({
    this.name,
    this.id,
    this.start,
    this.end,
    this.num,
    this.location,
    this.description,
    this.sponsor,
    this.tags,
    this.status,
    this.imgurl,
    this.user,
  });
  final String name;
  final String id;
  final String start;
  final String end;
  final int num;
  final String location;
  final String description;
  final String sponsor;
  final String tags;
  final String status;
  final String imgurl;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          /*AspectRatio(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(this.imgurl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ),
            aspectRatio: 16 / 9,
          ),*/
          ListTile(
            title:
            Text(this.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(this.location,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            leading: ClipOval(
              child: CircleAvatar(backgroundImage: NetworkImage(this.imgurl)),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (context) {
                    return new detail(activity: new Activity(this.name,this.id,this.start,this.end,
                        this.num,this.location,this.description,this.sponsor,this.tags,this.status,this.imgurl),user: user,);
                  }));
            },
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
    );
  }
}
