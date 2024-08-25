
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

void _handleGoogleSignIn() async {
  try {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      // Successful Google Sign-In
      // Handle post-authentication logic
    }
  } catch (error) {
    print('Error during Google Sign-In: \$error');
  }
}

void _handleAppleSignIn() async {
  final credential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );

  // Handle the credential data
}


import 'package:driver_flutter/core/entities/profile_full.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_response.freezed.dart';

@freezed
class VerifyOtpResponse with _$VerifyOtpResponse {
  const factory VerifyOtpResponse({
    required String jwtToken,
    required ProfileFullEntity driverFullProfile,
    required bool hasPassword,
  }) = _VerifyOtpResponse;
}
