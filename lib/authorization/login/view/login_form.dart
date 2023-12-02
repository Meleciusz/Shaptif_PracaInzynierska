import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/login/login.dart';
import 'package:shaptifii/authorization/sign_up/sign_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'header_title.dart';

//main Color
const Color mainColor = Color.fromARGB(255, 105, 70, 70);

/*
 * Main description:
this class describes login page
 */
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Login Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1/3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeaderTitle(),
              const SizedBox(height: 130),
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              const SizedBox(height: 8),
              _LoginButton(),
              const SizedBox(height: 8),
              _GoogleSignInButton(),
              const SizedBox(height: 8),
              _SignUpButton()
            ]
          )
        ),
      )
    );
  }
}

//this class describes email input
class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            hintStyle: Theme.of(context).textTheme.titleMedium,
            prefixIcon: Transform.rotate(angle: 270 * 3.1416 /180, child: const Icon(Icons.edit_rounded,
              color: mainColor,
              shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
            )),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(18.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          key:  const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
        );
      }
    );
  }
}

//this class describes password input
class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            hintStyle: Theme.of(context).textTheme.titleMedium,
            prefixIcon: Transform.rotate(angle: 270 * 3.1416 /180, child: const Icon(Icons.edit_rounded,
              color: mainColor,
              shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
            )),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(18.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
        );
      }
    );
  }
}

//this class describes login button
class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              backgroundColor: Colors.orangeAccent
            ),
            onPressed: state.isValid
              ? () => context.read<LoginCubit>().logInWithCredentials()
              : null,
            child: const Text('Login'),
          );
      }
    );
  }
}

//this class describes google sign in button
class _GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleSignIn_raisedButton'),
      label: const Text('Sign in with Google', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        backgroundColor: theme.colorScheme.secondary
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

//this class describes sign up button
class _SignUpButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
      return TextButton(
        key: const Key('loginForm_createAccount_raisedButton'),
        onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
        child: Text(
          'Sign Up',
          style: TextStyle(color: theme.primaryColor)
        )
      );
  }
}