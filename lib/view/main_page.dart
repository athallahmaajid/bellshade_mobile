import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bellshade_mobile/model/leaderboard.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PRLeaderboard prLeaderboard;

  Future<void> fetchPRLeaderboard() async {
    final response = await http.get(Uri.parse("https://bellshade-server.herokuapp.com/leaderboard/pr"));
    prLeaderboard = PRLeaderboard.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Bellshade PRLeaderboard"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchPRLeaderboard(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DataTable(
                columnSpacing: 0,
                dataRowHeight: 56,
                columns: [
                  DataColumn(
                    label: Text("Rank", style: TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                  DataColumn(
                    label: Container(
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        child: Text("Avatar", style: TextStyle(color: Theme.of(context).primaryColor))),
                  ),
                  DataColumn(
                    label: Container(
                        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.4),
                        child: Text("Username", style: TextStyle(color: Theme.of(context).primaryColor))),
                  ),
                  DataColumn(
                    label: Text("PRs", style: TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ],
                rows: prLeaderboard.users
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(
                            Text((prLeaderboard.users.indexOf(e) + 1).toString(), style: TextStyle(color: Theme.of(context).primaryColor)),
                          ),
                          DataCell(
                            Container(
                              margin: const EdgeInsets.only(bottom: 5, top: 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(e.avatar),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(e.name, style: TextStyle(color: Theme.of(context).primaryColor)),
                          ),
                          DataCell(
                            Text(e.prCount.toString(), style: TextStyle(color: Theme.of(context).primaryColor)),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
