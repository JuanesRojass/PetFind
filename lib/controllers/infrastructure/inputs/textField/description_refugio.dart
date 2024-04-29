import 'package:formz/formz.dart';

// Define input validation errors
enum DescriptionError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Description extends FormzInput<String, DescriptionError> {
  // Call super.pure to represent an unmodified form input.
  const Description.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Description.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DescriptionError.length) return 'Maximo de Caracteres "1000"';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DescriptionError? validator(String value) {
    if (value.length > 1000) return DescriptionError.length;

    return null;
  }
}