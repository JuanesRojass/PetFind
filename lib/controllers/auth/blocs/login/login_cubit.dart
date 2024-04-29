import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:formz/formz.dart';
// import 'package:mascotas_bga/controllers/infrastructure/inputs/description_refugio.dart';
import 'package:mascotas_bga/controllers/infrastructure/inputs.dart';
// import 'package:mascotas_bga/controllers/infrastructure/inputs/mision_refugio.dart';

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
      telefono: Telefono.dirty(state.telefono.value),
      description: Description.dirty(state.description.value),
      mision: Mision.dirty(state.mision.value),
      


      isValid: Formz.validate([
        state.username,
        state.email,
        state.password,
        state.telefono,
        state.description,
        state.mision,
      ])
    ));

    print('cubit Submit: $state');
  }

  void usernameChanged(String value) {
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

  void telefonoChanged(String value) {
    final telefono = Telefono.dirty(value);

    emit(state.copyWith(
        telefono: telefono,
        isValid: Formz.validate([telefono, state.username, state.email, state.password])));
  }


  void descriptionChanged(String value) {
    final description = Description.dirty(value);

    emit(state.copyWith(
        description: description,
        isValid: Formz.validate([description, state.email, state.password, state.username])));
  }

  void misionChanged(String value) {
    final mision = Mision.dirty(value);

    emit(state.copyWith(
        mision: mision,
        isValid: Formz.validate([mision, state.description, state.email, state.password, state.username])));
  }

}
