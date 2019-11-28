import 'package:type_resolver/type_resolver.dart';

import 'B.dart' as p_1;

@TypeResolvable()
class A<T> {
  List<int> a;
  Map<String, List<Map>> b;
  Map<Object, Deprecated> c;
  A<p_1.B> d;
  A<A<p_1.B>> e;

  void main(dynamic Rson) {
    Rson.serialize<Map<int, A>>();
  }
}
