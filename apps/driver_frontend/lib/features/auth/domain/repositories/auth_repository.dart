import 'package:dartz/dartz.dart';
import 'package:driver_flutter/core/entities/profile.dart';
import 'package:driver_flutter/core/entities/profile_full.dart';
import 'package:driver_flutter/core/error/failure.dart';
import 'package:driver_flutter/features/auth/domain/entities/registration_remote_data.dart';
import 'package:flutter_common/core/enums/gender.dart';
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignIn, GoogleSignInAccount;
import 'package:sign_in_with_apple/sign_in_with_apple.dart'
    show AppleIDAuthorizationScopes, SignInWithApple;

import '../entities/verify_number_response.dart' show VerifyNumberResponse;
import '../entities/verify_otp_response.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

void handleGoogleSignIn() async {
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

void handleAppleSignIn() async {
  await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );

  // Handle the credential data
}

abstract class AuthRepository {
  Future<Either<Failure, VerifyNumberResponse>> verifyNumber({
    required String mobileNumber,
    required String countryIsoCode,
  });

  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
    String hash,
    String otp,
  );

  Future<Either<Failure, VerifyOtpResponse>> verifyPassword(
    String mobileNumber,
    String password,
  );

  Future<Either<Failure, bool>> setPassword(
    String password,
  );

  Future<Either<Failure, RegistrationRemoteData>> getRegistrationData();

  Future<Either<Failure, VerifyNumberResponse>> resendOtp(
    String mobileNumber,
  );

  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String firstName,
    required String lastName,
    required Gender gender,
  });

  Future<Either<Failure, ProfileEntity>> register({
    required ProfileFullEntity profile,
  });
}
