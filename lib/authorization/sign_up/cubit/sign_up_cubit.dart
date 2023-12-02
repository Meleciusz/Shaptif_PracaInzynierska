import 'package:authorization_repository/authorization_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
part 'sign_up_state.dart';


/*
 * Main description:
This file describes every event that cubit can have and connects those events with the states and repositories
 */
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authorizationRepository) : super(const SignUpState());

  final AuthorizationRepository _authorizationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password, state.confirmedPassword]),
      )
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
        password: password.value,
        value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([state.email, password, confirmedPassword]),
      )
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([state.email, state.password, confirmedPassword]),
      )
    );
  }

  Future<void> signUpFormSubmitted() async{
    if(!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authorizationRepository.signUpWithEmailAndPassword(email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e){
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch(_){
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
