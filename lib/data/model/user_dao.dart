class UserDao {
  int? id;
  String? login;
  String? avatarUrl;
  String? name;
  String? company;
  String? blog;

  UserDao({
    this.id,
    this.login,
    this.avatarUrl,
    this.name,
    this.company,
    this.blog,
  });

  // Convert JSON to UserModel
  factory UserDao.fromJson(Map<String, dynamic> json) {
    return UserDao(
      id: json['id'],
      login: json['login'],
      avatarUrl: json['avatar_url'],
      name: json['name'],
      company: json['company'],
      blog: json['blog'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
      'name': name,
      'company': company,
      'blog': blog,
    };
  }
}