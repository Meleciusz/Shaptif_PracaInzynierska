import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/sign_up/sign_up.dart';
import 'package:formz/formz.dart';
import 'header_title.dart';

const Color mainColor = Color.fromARGB(255, 105, 70, 70);

/*
 * Main description:
This file describes sign up page
 */
class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state){
        if(state.status.isSuccess){
          Navigator.of(context).pop();
        } else if(state.status.isFailure){
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1/3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HeaderTitle(),
            const SizedBox(height: 8),
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            _ConfirmPasswordInput(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SubmitButton(),
                Tooltip(
                  message: "Go back",
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                      icon: const Icon(Icons.transit_enterexit_rounded)),
                )
              ],
            )
          ]
        ),
      ),
    );
  }
}

//this class describes email input
class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: state.email.displayError != null ? 'Invalid Email' : null,
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
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText: state.password.displayError != null ? 'Invalid Password' : null,
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
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
        );
      }
    );
  }
}

//this class describes password confirmation input
class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.confirmedPassword != current.confirmedPassword || previous.password != current.password,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            helperText: '',
            errorText: state.confirmedPassword.displayError != null ? 'Passwords do not match' : null,
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
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmedPassword) => context.read<SignUpCubit>().confirmedPasswordChanged(confirmedPassword),
          obscureText: true,
        );
      }
    );
  }
}

//this class describes submit button
class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
            key: const Key('signUpForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              backgroundColor: Colors.orangeAccent
            ),
            onPressed: state.isValid
              ? () => context.read<SignUpCubit>().signUpFormSubmitted()
              : null,
            child: const Text('Sign Up'),
          );
      }
    );
  }
}
