bool isEmailValid(String value) {
  final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+$');
  return emailRegex.hasMatch(value);
}

String? emailValidator(value) {
  if (value == null || value.isEmpty) {
    return 'El email es requerido';
  }
  if (!isEmailValid(value.trim())) {
    return 'El email no es válido';
  }
  return null; // Return null if the input is valid
}

String? requiredValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Este campo es requerido';
  }
  return null; // Return null if the input is valid
}
