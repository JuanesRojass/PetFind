part of 'login_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class LoginState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Username username;
  final Email email;
  final Password password;
  final Telefono telefono;
  final Description description;
  final Mision mision;

  const LoginState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.telefono = const Telefono.pure(),
    this.username = const Username.pure(),
    this.description = const Description.pure(),
    this.mision = const Mision.pure(),
  });

  LoginState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Email? email,
    Password? password,
    Telefono? telefono,
    Username? username,
    Description? description,
    Mision? mision,
  }) =>
      LoginState(
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        telefono:  telefono ?? this.telefono,
        username: username ?? this.username,
        description: description ?? this.description,
        mision: mision ?? this.mision,
      );

  @override
  List<Object> get props =>
      [formStatus, isValid, email, password, telefono, username, description, mision];
}
