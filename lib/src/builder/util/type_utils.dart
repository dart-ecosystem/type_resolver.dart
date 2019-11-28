abstract class TypeUtils {
  static List<String> splitTypeStringsFromTypeString(String type) {
    List<String> splitTypeStrings = [];
    var reg = RegExp(r"\b((\w+)\s?\w*\s?\w*)\b");
    Iterable<RegExpMatch> matches = reg.allMatches(type);
    for (var match in matches) {
      splitTypeStrings.add(match.group(2));
    }
    return splitTypeStrings;
  }

  static List<String> findGenericTypeStringsFromStrings(String content) {
    List<String> genericTypeStrings = [];
    var reg = RegExp(r"\w+<[.\w\,\s<>]+>");
    Iterable<RegExpMatch> matches = reg.allMatches(content);
    for (var match in matches) {
      genericTypeStrings.add(match.group(0).replaceAll(RegExp(r"[\w\d_]+\."), ""));
    }
    return genericTypeStrings;
  }
}
