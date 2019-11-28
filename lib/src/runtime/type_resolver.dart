import 'package:type_resolver/src/runtime/type_lookup.dart';

class TypeResolver {
  static TypeLookup typeLookup = TypeLookup();

  static Type parseTypeFromTypeString(String typeString) {
    return typeLookup.getTypeFromString(typeString);
  }

  static Object createInstanceFromType(Type type) {
    return typeLookup.createInstanceFromType(type);
  }

  static Object createInstanceFromTypeString(String typeString) {
    Type type = parseTypeFromTypeString(typeString);
    return createInstanceFromType(type);
  }
}
