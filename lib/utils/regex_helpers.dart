String fixIm(String text) {
  // Replace standalone "Im" with "I'm"
  return text.replaceAll(RegExp(r'\bIm\b'), "I'm");
}