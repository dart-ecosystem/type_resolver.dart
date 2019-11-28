import 'dart:convert';

class TypeResolverCache {
  List<String> classNames;
  List<String> genericTypeNames;

  TypeResolverCache({
    this.classNames = const [],
    this.genericTypeNames = const [],
  });

  TypeResolverCache.fromJson(Map json) {
    this.classNames = List<String>.from(json['classNames']);
    this.genericTypeNames = List<String>.from(json['genericTypeNames']);
  }

  Map toJson() {
    return {
      "classNames": classNames,
      "genericTypeNames": genericTypeNames,
    };
  }

  @override
  String toString() => json.encode(toJson());
}
