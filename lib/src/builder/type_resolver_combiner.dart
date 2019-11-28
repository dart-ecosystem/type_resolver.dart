import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:type_resolver/src/builder/cache/type_resolver_cache.dart';
import 'package:type_resolver/src/builder/util/basic_type_utils.dart';
import 'package:type_resolver/src/builder/util/template_utils.dart';
import 'package:type_resolver/src/builder/util/type_utils.dart';

class TypeResolverCombiner extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // prepare sources
    final List<AssetId> typeResolverAssetIds =
        await buildStep.findAssets(Glob("**/*.type_resolver.json")).toList();

    final List<TypeResolverCache> typeResolverAssetCaches = [];

    // deserialize
    for (var assetId in typeResolverAssetIds) {
      var code = json.decode(await buildStep.readAsString(assetId));
      typeResolverAssetCaches.add(TypeResolverCache.fromJson(code));
    }

    // find valid classes
    Set<String> validClassNames = {...BasicTypeUtils.BASIC_TYPE};
    Set<String> genericTypeNames = {};

    for (var cache in typeResolverAssetCaches) {
      validClassNames.addAll(cache.classNames);
    }

    // add all generic types without unregistered class
    for (var cache in typeResolverAssetCaches) {
      for (var genericTypeName in cache.genericTypeNames) {
        List<String> splitGenericTypeNames =
            TypeUtils.splitTypeStringsFromTypeString(genericTypeName);
        if (splitGenericTypeNames.every(validClassNames.contains)) {
          genericTypeNames.add(genericTypeName);
        }
      }
    }

    // write to file
    String content = TemplateUtils.generateString(validClassNames, genericTypeNames);
    String package = buildStep.inputId.package;
    AssetId outputId = AssetId(package, "lib/generated/type_resolver.dart");
    await buildStep.writeAsString(outputId, content);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        "main.dart": ["/generated/type_resolver.dart"],
      };
}
