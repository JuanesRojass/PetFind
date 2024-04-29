import 'package:formz/formz.dart';

// Define input validation errors
enum TelefonoError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Telefono extends FormzInput<String, TelefonoError> {
  // Call super.pure to represent an unmodified form input.
  const Telefono.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Telefono.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TelefonoError.empty) return 'El campo es requerido';
    if (displayError == TelefonoError.length) return 'No existe numero de telefono con mas de 20 numeros';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TelefonoError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TelefonoError.empty;
    if (value.length > 20) return TelefonoError.length;

    return null;
  }
}