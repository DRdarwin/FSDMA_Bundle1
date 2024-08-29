import 'package:driver_flutter/core/entities/profile_full.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'verify_otp_response.freezed.dart';

// Google Sign-In configuration
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

void handleGoogleSignIn(BuildContext context) async {
  try {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      // Successful Google Sign-In
      // Handle post-authentication logic
      // Example: Navigator.of(context).pushNamed('/home');
    }
  } catch (error) {
    // Use a logger instead of print
    // Example: Logger().e("Error during Google Sign-In: $error");
  }
}

void handleAppleSignIn(BuildContext context) async {
  try {
    await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Handle the credential data, for example:
    // Navigator.of(context).pushNamed('/home');
  } catch (error) {
    // Use a logger instead of print
    // Example: Logger().e("Error during Apple Sign-In: $error");
  }
}

@freezed
class VerifyOtpResponse with _$VerifyOtpResponse {
  const factory VerifyOtpResponse({
    required String jwtToken,
    required ProfileFullEntity driverFullProfile,
    required bool hasPassword,
  }) = _VerifyOtpResponse;
}
