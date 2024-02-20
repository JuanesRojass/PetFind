part of 'login_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class LoginState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Username username;
  final Email email;
  final Password password;

  const LoginState(
      {this.formStatus = FormStatus.invalid,
      this.isValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.username = const Username.pure(),
      });
       

  LoginState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Email? email,
    Password? password,
    Username? username,
  }) =>
      LoginState(
          formStatus: formStatus ?? this.formStatus,
          isValid: isValid ?? this.isValid,
          email: email ?? this.email,
          password: password ?? this.password,
          username: username ?? this.username
          );
          

  @override
  List<Object> get props => [formStatus, isValid, email, password, username];
}
