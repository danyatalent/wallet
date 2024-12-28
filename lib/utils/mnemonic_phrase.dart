String getMnemonicPhrase(List<String> words) {
  return words.map((e) => e.trim()).join(' ');
}