import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bellshade_mobile/utilities/date_parser.dart';

class PrDetails extends StatelessWidget {
  final List<dynamic> pullRequests;
  final String username;
  const PrDetails({Key? key, required this.pullRequests, required this.username}) : super(key: key);

  void launchURL(url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username + "'s PRs"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: OutlinedButton(
                onPressed: () {
                  launchURL("https://github.com/" + username);
                },
                child: Text(username + " Profile"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: pullRequests.length,
              itemBuilder: (context, index) {
                var createdDate = dateParse(pullRequests[index]['created_at']);
                var mergedDate = dateParse(pullRequests[index]['merged_at']);
                return Container(
                  margin: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: () {
                      launchURL(pullRequests[index]['html_url']);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pullRequests[index]['repo'], style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 36)),
                        Text(
                          pullRequests[index]['title'] + " #" + pullRequests[index]['number'].toString(),
                          style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          "Created at: " + createdDate.day.toString() + "-" + createdDate.month.toString() + "-" + createdDate.year.toString(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.001,
                        ),
                        Text(
                          "Merged at: " + mergedDate.day.toString() + "-" + mergedDate.month.toString() + "-" + mergedDate.year.toString(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
