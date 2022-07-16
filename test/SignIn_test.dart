import 'package:flutter_golang_yt/screens/signin.dart';
import 'package:flutter_golang_yt/screens/signup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test ValidatorForm', () {});
  test('Empty email returns error string', () {
    var result = emailFieldValidator.validate('');
    expect(result, "Coloca un email correcto");
  });

  test('Empty password returns error string', () {
    var result = passwordFieldValidator.validate('');
    expect(result, "La casilla está vacía");
  });

  test('Empty name returns error string', () {
    var result = nameFieldFormValidator.validate('');
    expect(result, "Coloca tus nombres correctamente");
  });

  test('Empty dni returns error string', () {
    var result = dniFieldFormValidator.validate('');
    expect(result, "Coloca un DNI correcto");
  });
  test('Empty phone returns error string', () {
    var result = phoneFieldValidator.validate('');
    expect(result, "Coloca un celular correcto");
  });
}
