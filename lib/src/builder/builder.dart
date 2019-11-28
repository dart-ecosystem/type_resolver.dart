import 'package:build/build.dart';
import 'package:type_resolver/src/builder/type_resolver_collector.dart';
import 'package:type_resolver/src/builder/type_resolver_combiner.dart';

Builder typeResolverCollector(BuilderOptions ops) => TypeResolverCollector();
Builder typeResolverCombiner(BuilderOptions ops) => TypeResolverCombiner();
