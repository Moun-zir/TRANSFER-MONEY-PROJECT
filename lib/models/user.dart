class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}


List <User> Users = [
    User(email: 'mailto:user@gmail.com', password: '1234'),
    User(email: 'mailto:admin@gmail.com', password: '1234'),
  ];