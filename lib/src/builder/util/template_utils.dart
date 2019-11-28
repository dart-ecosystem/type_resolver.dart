import 'package:type_resolver/src/builder/util/basic_type_utils.dart';
import 'package:type_resolver/src/builder/util/string_utils.dart';

abstract class TemplateUtils {
  static String generateString(Set<String> validClassNames, Set<String> genericTypeNames) {
    return [
      "import 'package:type_resolver/type_resolver.dart';",
      "import \"exporter.dart\";",
      "Type _t<T>() => T;",
      "typedef Object TypeCreator();"
          "final Map<String, Type> stringToTypeDict = {",
      ...validClassNames.map((e) => "${StringUtils.quote(e)}: $e,"),
      ...genericTypeNames.map((e) => "${StringUtils.quote(e)}: _t<$e>(),"),
      "};",
      "final Map<Type, TypeCreator> typeCreator = {",
      ...validClassNames
          .where((e) => !BasicTypeUtils.NOT_INITIALIZABLE_BASIC_TYPE.contains(e))
          .map((e) => "$e: () => $e(),"),
      ...genericTypeNames.map((e) => "_t<$e>(): () => $e(),"),
      "};",
      "initializeTypeResolver() {",
      "TypeResolver.typeLookup.initialize(stringToTypeDict, typeCreator);",
      "}",
    ].join("\n");
  }
}
