import 'dart:convert';
import 'package:http/http.dart' as http;

class activityHttp {

  var myNoticeHttp = "http://202.120.40.8:30401/api/activities";
  var addActivityHttp = "http://202.120.40.8:30401/api/start";
  var joinHttp = "http://202.120.40.8:30401/api/join/";
  var getJoinHttp = "http://202.120.40.8:30401/api/joined?name=";
  var accuHttp = "http://202.120.40.8:30401/api/accusation?name=";
  var recommandHttp = "http://202.120.40.8:30401/api/recommend?name=";
  var getPriceHttp = "http://202.120.40.8:30401/api/involvePrize?name=";
  var endPrizeHttp = "http://202.120.40.8:30401/api/endPrize?id=";




  myActivity(NetListener net) {
    var client = new http.Client();
    client.get(
      myNoticeHttp,
    ).then((response,) {

      List responseJson = json.decode(response.body);
      print(response.body);
      List<Activity> activityList = responseJson.map((m) => new Activity.fromJson(m)).toList();
      net.onMyNoticeResponse(activityList);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
  addActivity(NetListener net,String name,String tags,String start,String end,
      int num,String sponsor,String location,String description) {
    var client = new http.Client();
     client.post(
      addActivityHttp,
      headers:{
        "Content-Type": "application/json",
      },
      body: json.encode({
        "name": name,
        "tags": tags,
        "status": 0,
        "start": start,
        "end": end,
        "num": num,
        "sponsor": sponsor,
        "location": location,
        "description": description,
      }),
    ).then((
        response,
        ) {
      print('添加活动http');
      print(response.body);
      String res = '';
      net.onAddActivityResponse(res);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
  joinActivity(NetListener net,String name,int id) {
    var client = new http.Client();
    client.get(
      joinHttp+'?name='+name+'&id='+id.toString(),
    ).then((
        response,
        ) {
      print('参加活动http');
      print(response.body);
      String res = '';
      net.onAddActivityResponse(res);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
  joinPrice(NetListener net,String name,int id) {
    var client = new http.Client();
    print(getPriceHttp+name+'&id='+id.toString());
    client.get(
      getPriceHttp+name+'&id='+id.toString(),
    ).then((
        response,
        ) {
      print('参加抽奖http');
      print(response.body);
      String res = '';
      net.onAddActivityResponse(res);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
  endPrice(NetListener net,int id) {
    var client = new http.Client();
    client.get(
      endPrizeHttp+id.toString(),
    ).then((
        response,
        ) {
      print('结束抽奖http');
      print(response.body);
      String res = '';
      net.onAddActivityResponse(res);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
  myJoinActivity(NetListener net,String name) {
    var client = new http.Client();
    client.get(
      getJoinHttp+name,
    ).then((response,) {

      List responseJson = json.decode(response.body);
      print(response.body);
      List<Activity> activityList = responseJson.map((m) => new Activity.fromJson(m)).toList();
      net.onMyNoticeResponse(activityList);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
  recommandActivity(NetListener net,String name) {
    var client = new http.Client();
    client.get(
      recommandHttp+name,
    ).then((response,) {

      List responseJson = json.decode(response.body);
      print(response.body);
      List<Activity> activityList = responseJson.map((m) => new Activity.fromJson(m)).toList();
      net.onMyNoticeResponse(activityList);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
  accuActivity(NetListener net,String name,int id,String content) {
    var client = new http.Client();
    client.get(
      accuHttp+name+'&id='+id.toString()+'&content='+content,
    ).then((
        response,
        ) {
      print('举报活动http');
      print(response.body);
      String res = '';
      net.onAddActivityResponse(res);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }

}
/**
 * 用来回调成功和失败的结果
 */
abstract class NetListener {


  void onMyNoticeResponse(List<Activity> activities);
  void onAddActivityResponse(String result);
  void onError(error);
}
class Activity {
  String name;
  String id;
  String start;
  String end;
  int num;
  String location;
  String description;
  String sponsor;
  String tags;
  String status;
  String imgurl;
  String getName(){
    return this.name;
  }
  String getStart(){
    return this.start;
  }
  String getEnd(){
    return this.end;
  }
  String getId(){
    return this.id;
  }
  String getSponsor(){
    return this.sponsor;
  }
  int getNum(){
    return this.num;
  }
  String getTags(){
    return this.tags;
  }
  String getDescription(){
    return this.description;
  }
  String getStatus(){
    return this.status;
  }
  String getImgurl(){
    return this.imgurl;
  }
  String getLocation(){
    return this.location;
  }
  Activity(this.name,this.id,this.start,this.end,this.num,this.location,
      this.description,this.sponsor,this.tags,this.status,this.imgurl);
  factory Activity.fromJson(Map<String, dynamic> json){
    return new Activity(
      json['name'],
      json['id'].toString(),
      json['start'],
      json['end'],
      json['num'],
      json['location'],
      json['description'],
      json['sponsor'],
      json['tags'],
      json['status'].toString(),
      "http://cms-bucket.ws.126.net/2019/06/20/68fa7f186ffe4479ab27efabd4d94246.png?imageView&thumbnail=190y120",
    );
  }
}





