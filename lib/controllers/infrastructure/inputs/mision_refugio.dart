import 'package:formz/formz.dart';

// Define input validation errors
enum MisionError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Mision extends FormzInput<String, MisionError> {
  // Call super.pure to represent an unmodified form input.
  const Mision.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Mision.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == MisionError.length) return 'Maximo de Caracteres "1000"';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  MisionError? validator(String value) {
    if (value.length > 1000) return MisionError.length;

    return null;
  }
}