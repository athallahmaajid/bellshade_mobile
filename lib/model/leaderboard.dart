class User {
  String name;
  String avatar;
  List<dynamic> pullRequests;
  int prCount;
  User(this.name, this.avatar, this.pullRequests, this.prCount);
}

class PRLeaderboard {
  List<User> users;

  PRLeaderboard(this.users);

  factory PRLeaderboard.fromJson(List<dynamic> json) {
    List<User> contributors = [];
    for (var item = 0; item < json.length; item++) {
      contributors.add(User(json[item]['user']['login'], json[item]['user']['avatar_url'], json[item]['pull_requests'], json[item]['prs_count']));
    }
    return PRLeaderboard(contributors);
  }

  int get length {
    return users.length;
  }
}
