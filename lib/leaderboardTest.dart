import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MaterialApp(home: LeaderBoardNew()));

const Color avtar_backGround = Color(0xff3977ff);
const Color avtar_backGround1 = Color(0xff3977ff);
const Color prof_Card = Color(0xff3977ff);
const Color grade1 = Color(0xff3977ff);
const Color grade2 = Color(0xff3977ff);
const Color cool = Color(0xff3977ff);
const clickedColor = Color(0xff3977ff);
const unclickedColor = Color(0xff3977ff);
Color probtn = Color(0xff3977ff);
Color leadbtn = Color(0xff3977ff);
Color gold = Color(0xFFD0B13E);
Color silver = Color(0xFFE7E7E7);
Color bronze = Color(0xFFA45735);

//Color list_item = Colors.grey[200];

class LeaderBoardNew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<LeaderBoardNew> {
  List<String> names = [
    "Regina Ali",
    "Keith Austin",
    "Sharon Ball",
    "Claire Bedford",
    "Robert Brown",
    "Emma Burditt",
    "Harry Campion",
    "Samantha Cawley",
    "Tony Cheng",
    "Christopher Cox",
    "Alan Davies",
    "Elaine Dean",
    "Earnest Dean",
    "James Dolan",
    "Patricia Green",
"Ben Holden",
"Peter Kendall",
"Jonathan King",
"Christian Lawrence",
"Paul Lawther",
"Jeremy Lewis",
"Josephine Lowe",
"William MacKay",
"Iain McArthur",
"Stewart McDonald",
"Carlton McLeod",
"Jayne Morris",
"Bernadette Nolan",
"Natalie Overton",
"Doreen Palmer",
"David Peach",
"Alistair Pike",
"Donald Ross",
"Julia Sargeant",
"Ian Scott",
"Imran Shakir",
"Paul Simpson",
"Benjamin Spark",
"John Sutcliffe",
"Peter Taylor",
"Michael Toon",
"Marcia Wakeham",
"Michael Whitchurch",
"David White",
"Anna Williams",
"Lorraine Williams",
"Anna Wood",
"Randall Wooster",
"Rachel Wynn"
  ];
  List<String> litems = [
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4"
  ];  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(      
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: probtn,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 150.0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: Container(
                  color: avtar_backGround1,
                  height: 50,
                  child: Container(
                    child: Row(

                      children: [
                        SizedBox(width: 35),
                        Text("Postion",
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 52),

                        Text(
                          "Name",
                          style:
                          TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 100),

                        Text(
                          "Score",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),),),),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[leadbtn.withOpacity(0.5), cool])),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Text(
                          "LEADERBOARD",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 9.0,
            ),
SliverList(
    delegate: SliverChildBuilderDelegate(
  (BuildContext context,int index)=>buildList(context,index),
      childCount: litems.length,
))
          ],
        ),
      ),
    );

  }
  Widget buildList(BuildContext txt, int index) {
    int ind = index + 1;
    final pos = litems[index];
    final name = names[index];

    Widget listItem;

    if (ind == 1) {
      listItem = Card(
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: gold,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(pos,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
                      SizedBox(width:  2),
               Text(
                "Ernie Town",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
             SizedBox(width:  10),
              Text(
                "21",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    } else if (ind == 2) {
      listItem = Card(
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: silver,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(pos,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
                      SizedBox(width:  2),
              Text(
                "János Csampai",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
SizedBox(width:  10),
              Text(
                "16",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    } else if (ind == 3) {
      listItem = Card(
        shadowColor: Colors.grey[200],
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        color: bronze,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(pos,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
                      SizedBox(width:  2),
              Text(
                "Joe Morris",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),SizedBox(width:  10),
              Text(
                "10",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    } else {
      listItem = Card(
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(ind.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
                      SizedBox(width:  2),
              Text(
                names[Random().nextInt(names.length - 1)],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),SizedBox(width:  10),
              Text(
                "1",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          color: Colors.grey[200],
          child: listItem,
        ),
      ],
    );
  }

}