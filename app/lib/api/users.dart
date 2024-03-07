class Users {
  final List<User> _users = [];

  Users() {
    _users.add(User(
      id: 'A101',
      img: 'assets/images/vk.png',
      name: 'Vikramaditya Dhumal',
      email: 'dhumalvikramaditya287@gmail.com',
      phone: '8899968330',
      username: 'vicky',
      password: 'vk1234',
      role: 'admin',
      memberSince: '01 Jan 2024',
      flat: 'A-101',
    ));
    _users.add(User(
      id: 'B302',
      img: 'assets/images/sid.jpg',
      name: 'Siddharaj Ghatge',
      email: 'siddharajghatge@gmail.com',
      phone: '9307426214',
      username: 'sidd',
      password: 'sidd1234',
      role: 'resident',
      memberSince: '12 Jan 2024',
      flat: 'B-302',
    ));
    _users.add(User(
      id: 'C201',
      img: 'assets/images/ssk.jpg',
      name: 'Shreyash Kakade',
      email: 'shreyashkakade10@gmail.com',
      phone: '8010227283',
      username: 'ssk',
      password: 'ssk1234',
      role: 'admin',
      memberSince: '03 Jan 2024',
      flat: 'C-201',
    ));
    _users.add(User(
      id: 'D105',
      img: 'assets/images/ameya.jpg',
      name: 'Ameya Ukande',
      email: 'ameya19@gmail.com',
      phone: '7507288088',
      username: 'ameya19',
      password: 'ameya1234',
      role: 'resident',
      memberSince: '01 Feb 2024',
      flat: 'D-105',
    ));
  }

  List<User> get users => _users;

  User login(String username, String password) {
    return _users.firstWhere((user) => user.username == username && user.password == password, orElse: () => emptyUser());
  }

  static User emptyUser() {
    return User(id: '', img: '', name: '', email: '', phone: '', username: '', password: '', role: '', memberSince: '', flat: '');
  }

  static User dummyUser() {
    return User(
      id: 'A101',
      img: 'assets/images/vk.jpg',
      name: 'Vikramaditya Dhumal',
      email: 'dhumalvikramaditya287@gmail.com',
      phone: '8899968330',
      username: 'vicky',
      password: 'vk1234',
      role: 'admin',
      memberSince: '01 Jan 2024',
      flat: 'A-101',
    );
  }
}

class User {
  final String id;
  final String img;
  final String name;
  final String email;
  final String phone;
  final String username;
  final String password;
  final String role;
  final String memberSince;
  final String flat;

  User({required this.id, required this.img, required this.name, required this.email, required this.phone, required this.username, required this.password, required this.role, required this.memberSince, required this.flat});
}
