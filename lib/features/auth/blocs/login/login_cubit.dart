import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:formz/formz.dart';
import 'package:mascotas_bga/infrastructure/inputs/inputs.dart';

import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void onSubmit() {
    emit(state.copyWith(
      formStatus: FormStatus.validating,
      username: Username.dirty(state.username.value),
      email: Email.dirty(state.email.value),
      password: Password.dirty(state.password.value),


      isValid: Formz.validate([
        state.username,
        state.email,
        state.password,
      ])
    ));

    print('cubit Submit: $state');
  }

  void UsernameChanged(String value) {
    final username = Username.dirty(value);

    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.email, state.password])));
  }


  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.username, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username, state.email])));
  }
}
