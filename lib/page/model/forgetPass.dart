class ForgetPass {
  late String userId;

//<editor-fold desc="Data Methods">

  ForgetPass({
    required this.userId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ForgetPass &&
          runtimeType == other.runtimeType &&
          userId == other.userId);

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'ForgetPass{' + ' userId: $userId,' + '}';
  }

  ForgetPass copyWith({
    String? userId,
  }) {
    return ForgetPass(
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
    };
  }

  factory ForgetPass.fromMap(Map<String, dynamic> map) {
    return ForgetPass(
      userId: map['userId'] as String,
    );
  }

//</editor-fold>
}
