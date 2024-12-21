import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

void decodeJWT(String token) {
  const publicKeyPem = '''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAlbG+6SU9zFPIWgwaLJEI
IUP2kPiQ309St5zZ9CwOPnBPD5Jx2gTiPxo9N6Vo1uj9Mi/BDyNKr2kzII7P5I7j
v9ITTAnCcm1jZVbxUwciVxAXtvMjLK9RYG1CQPEO5gGoacA+XKIqMhY4ysqBtDM3
M5mbDN0lE9p4CcTR2rAl1SIpH2f4KsA+eDrlmZQU3avBrw6/xHhwiIqYQ5IhrEO0
T2btYW3V2utmL1rElIynveYKuhmEyqPCJMuTdR/iRXHqfkWYocICt3tByHKuPMv6
LTmIw6Sdj7ED6B5jPTOdwYvCY1kwPyDfyqcxpDXchKkwJjcTvQ6PgraqySRXH78u
BwIDAQAB
-----END PUBLIC KEY-----
''';
  try {
    final publicKey = RSAPublicKey(publicKeyPem);
    final jwt = JWT.verify(token, publicKey);

    print("Token is valid and the payload is ${jwt.payload}");
  } catch (e) {
    print("E: Can't verify the JWT");
  }
}
