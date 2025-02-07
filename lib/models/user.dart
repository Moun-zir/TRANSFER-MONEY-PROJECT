class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}

List<User> Users = [
  User(email: 'user@gmail.com', password: '1234'),
  User(email: 'admin@gmail.com', password: '1234'),
];