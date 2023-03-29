class Authentication {
  final String uid;
  final String token;
  final int expiredToken;

  Authentication({
    required this.uid,
    required this.token,
    required this.expiredToken,
  });
}
