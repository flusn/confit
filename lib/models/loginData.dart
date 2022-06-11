// ignore_for_file: file_names

class AllLoginData {
  final List<dynamic> allLoginData;

  AllLoginData(this.allLoginData);

  bool checkUsername(String username) {
    bool result = false;
    for (var element in allLoginData) {
      if (username == element["username"]) result = true;
    }
    return result;
  }

  bool checkPassword(String username, String password) {
    bool result = false;
    for (var element in allLoginData) {
      if (username == element["username"] && element["password"] == password) {
        result = true;
      }
    }
    return result;
  }

  int getUserId(String username, String password) {
    int result = 0;
    for (var element in allLoginData) {
      if (username == element["username"] && element["password"] == password) {
        result = element["userId"];
      }
    }
    return result;
  }
}
