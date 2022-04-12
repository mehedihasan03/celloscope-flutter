class Login {
  late String userId;
  late String password;

//<editor-fold desc="Data Methods">

  Login({
    required this.userId,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Login &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          password == other.password);

  @override
  int get hashCode => userId.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'Login{' + ' userId: $userId,' + ' password: $password,' + '}';
  }

  Login copyWith({
    String? userId,
    String? password,
  }) {
    return Login(
      userId: userId ?? this.userId,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'password': this.password,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      userId: map['userId'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}
