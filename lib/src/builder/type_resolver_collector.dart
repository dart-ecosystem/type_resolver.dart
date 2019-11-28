import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:type_resolver/src/annotation/type_resolvable.dart';
import 'package:type_resolver/src/builder/cache/type_resolver_cache.dart';
import 'package:type_resolver/src/builder/util/class_element_constructor_utils.dart';
import 'package:type_resolver/src/builder/util/type_utils.dart';
import 'package:source_gen/source_gen.dart';

class TypeResolverCollector extends Builder {
  static TypeChecker typeChecker = TypeChecker.fromRuntime(TypeResolvable);

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    List<String> classNames = [];

    // read classNames
    LibraryReader libReader = LibraryReader(await buildStep.inputLibrary);
    Iterable<Element> elements = libReader.annotatedWith(typeChecker).map((e) => e.element);
    for (var element in elements) {
      if (element is! ClassElement) {
        continue;
      }

      if (!ClassElementConstructorUtils.containsDefaultConstructor(element as ClassElement)) {
        continue;
      }

      classNames.add(element.name);
    }

    // read genericClassNames
    String content = await buildStep.readAsString(buildStep.inputId);
    List<String> genericTypeNames = TypeUtils.findGenericTypeStringsFromStrings(content);

    // stop when no classNames found
    if (classNames.isEmpty && genericTypeNames.isEmpty) {
      return;
    }

    // write to cache
    TypeResolverCache cache = TypeResolverCache(
      classNames: classNames,
      genericTypeNames: genericTypeNames,
    );
    AssetId outputId = buildStep.inputId.changeExtension(".type_resolver.json");
    await buildStep.writeAsString(outputId, cache.toString());
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        ".dart": [".type_resolver.json"]
      };
}
