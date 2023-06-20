getTextSize(String text) {
  if (text.length <= 5) {
    return 48.0;
  } else if (text.length <= 10) {
    return 24.0;
  } else {
    return 24.0;
  }
}

getTextSizeBig(String text) {
  if (text.length <= 3) {
    return 56.0;
  } else if (text.length <= 10) {
    return 32.0;
  } else {
    return 24.0;
  }
}
