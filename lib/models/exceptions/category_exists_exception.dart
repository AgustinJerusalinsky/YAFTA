class CategoryAlreadyExistsException implements Exception {
  final String message;

  CategoryAlreadyExistsException(this.message);
}
