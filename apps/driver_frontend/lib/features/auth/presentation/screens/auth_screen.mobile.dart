import 'package:auto_route/auto_route.dart';
import 'package:driver_flutter/config/locator/locator.dart';
import 'package:driver_flutter/core/blocs/auth_bloc.dart';
import 'package:driver_flutter/core/blocs/onboarding_cubit.dart';
import 'package:driver_flutter/core/router/app_router.dart';
import 'package:driver_flutter/features/auth/presentation/blocs/login.dart';
import 'package:driver_flutter/features/auth/presentation/screens/onboarding_screen.mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/core/extensions/extensions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' show AppleIDAuthorizationScopes, SignInWithApple;

// Ініціалізація GoogleSignIn
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

// Функція для обробки входу через Google
Future<void> _handleGoogleSignIn(BuildContext context) async {
  try {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      // Успішний вхід через Google
      // Обробка логіки після аутентифікації
      print('Google Sign-In successful: ${account.email}');
    }
  } catch (error) {
    print('Error during Google Sign-In: $error');
  }
}

// Функція для обробки входу через Apple
Future<void> _handleAppleSignIn(BuildContext context) async {
  try {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    // Обробка даних облікових даних
    print('Apple Sign-In successful: ${credential.email}');
  } catch (error) {
    print('Error during Apple Sign-In: $error');
  }
}

class AuthScreenMobile extends StatelessWidget {
  const AuthScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = locator<OnboardingCubit>();
    return PopScope(
      canPop: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: locator<OnboardingCubit>(),
          ),
          BlocProvider.value(
            value: locator<LoginBloc>(),
          ),
        ],
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.jwtToken != null) {
              locator<AuthBloc>().onLoggedIn(
                jwtToken: state.jwtToken!,
                profile: state.profileFullEntity!.toEntity,
              );
            }
            state.loginPage.mapOrNull(
              success: (value) {
                locator<AuthBloc>().onLoggedIn(
                  jwtToken: state.jwtToken!,
                  profile: value.profile,
                );
                locator<OnboardingCubit>().skip();
                locator<LoginBloc>().clear();
                locator<LoginBloc>().reset();
                context.router.replaceAll(
                  [
                    const HomeRoute(),
                  ],
                );
              },
            );
          },
          child: context.responsive(
            BlocBuilder<OnboardingCubit, int>(
                builder: (context, stateOnboarding) {
              return onboardingCubit.isDone
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildGoogleSignInButton(context),
                        const SizedBox(height: 16),
                        _buildAppleSignInButton(context),
                      ],
                    )
                  : const OnboardingScreen();
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _handleGoogleSignIn(context),
      icon: Image.asset(
        'assets/google_icon.png',
        height: 24.0,
        width: 24.0,
      ),
      label: const Text('Sign in with Google'),
    );
  }

  Widget _buildAppleSignInButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _handleAppleSignIn(context),
      icon: const Icon(
        Icons.apple,
        color: Colors.black,
        size: 24.0,
      ),
      label: const Text('Sign in with Apple'),
    );
  }
}
