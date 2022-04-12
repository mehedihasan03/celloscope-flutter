class User {
  late String userId;
  late String password;
  late String mobile;

//<editor-fold desc="Data Methods">

  User({
    required this.userId,
    required this.password,
    required this.mobile,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          password == other.password &&
          mobile == other.mobile);

  @override
  int get hashCode => userId.hashCode ^ password.hashCode ^ mobile.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' userId: $userId,' +
        ' password: $password,' +
        ' mobile: $mobile,' +
        '}';
  }

  User copyWith({
    String? userId,
    String? password,
    String? mobile,
  }) {
    return User(
      userId: userId ?? this.userId,
      password: password ?? this.password,
      mobile: mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'password': this.password,
      'mobile': this.mobile,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      password: map['password'] as String,
      mobile: map['mobile'] as String,
    );
  }

//</editor-fold>
}
