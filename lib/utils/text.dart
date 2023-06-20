getTextSize(String text) {
  if (text.length <= 5) {
    return 48.0;
  } else if (text.length <= 8) {
    return 24.0;
  } else {
    return 18.0;
  }
}

getTextSizeBig(String text) {
  if (text.length <= 3) {
    return 56.0;
  } else if (text.length <= 6) {
    return 32.0;
  } else {
    return 28.0;
  }
}
