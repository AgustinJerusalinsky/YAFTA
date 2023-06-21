String getAuthErrorMessage(String code) {
  switch (code) {
    case "invalid-email":
      return "El email es inválido.";
    case "wrong-password":
      return "El email o la contraseña son incorrectos.";
    case "user-not-found":
      return "No se encontró un usuario con ese email.";
    case "user-disabled":
      return "El usuario con ese email está deshabilitado.";
    case "too-many-requests":
      return "Demasiados intentos de inicio de sesión fallidos. Intente más tarde.";
    case "operation-not-allowed":
      return "El inicio de sesión con email y contraseña no está habilitado.";
    case "email-already-in-use":
      return "Ya existe una cuenta con ese email.";
    case "weak-password":
      return "La contraseña es muy débil.";
    case "google-sign-in-failed":
      return "No se pudo iniciar sesión con Google. Intente más tarde.";
    default:
      return "Ocurrió un error. Intente más tarde.";
  }
}
