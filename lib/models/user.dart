class User {
  final String username; // Remplacer 'email' par 'username'
  final String password;

  User({required this.username, required this.password});
}

List<User> Users = [
  User(username: 'user', password: '1234'),
  User(username: 'admin', password: '1234'),
];
