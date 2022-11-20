import 'package:flutter/material.dart';

class _UserDescription extends StatelessWidget {
  const _UserDescription({
    required this.username,
    required this.issuesSolved,
  });

  final String username;
  final int issuesSolved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                username,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                issuesSolved.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    super.key,
    required this.username,
    required this.issuesSolved,
  });

  final String username;
  final int issuesSolved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _UserDescription(
                  username: username,
                  issuesSolved: issuesSolved,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return            ListView(
              children: [
                ListTile(
                  onTap: () => print('Tapped ListTileObject TheSun'),
                  leading: Icon(Icons.sunny),
                  title : Text('The Sun'),
                  subtitle: Text('Fire'),
                  trailing: Icon(Icons.arrow_right),
                ),
                ListTile(
                  onTap: () => print('Tapped ListTileObject TheEarth'),
                  leading: Icon(Icons.circle_sharp),
                  title : Text('The Earth'),
                  subtitle: Text('Life'),
                  trailing: Icon(Icons.arrow_right),
                ),
                ListTile(
                  onTap: () => print('Tapped ListTileObject TheMoon'),
                  leading: Icon(Icons.shield_moon_rounded),
                  title : Text('The Moon'),
                  subtitle: Text('White Heart'),
                  trailing: Icon(Icons.arrow_right),
                ),
                GestureDetector(
                  onTap: () => print('Tapped CardObject GALAXY'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Text('GALAXY',style: TextStyle(fontWeight: FontWeight.bold)),
                            Spacer(),
                            Icon(Icons.more_vert_sharp)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => print('Tapped ContainerObject TheWaterland'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      color: Colors.indigoAccent,
                      child: Center(child: Text('WATERLAND',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
              ],
            );
  }
}
