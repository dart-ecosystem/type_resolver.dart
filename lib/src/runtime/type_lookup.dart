class TypeLookup {
  bool _isInitialized = false;

  Map<String, Type> _stringToTypeDict;

  Map<Type, Function> _typeCreator;

  void initialize(
    Map<String, Type> stringToTypeDict,
    Map<Type, Function> typeCreator,
  ) {
    this._stringToTypeDict = stringToTypeDict;
    this._typeCreator = typeCreator;
    _isInitialized = true;
  }

  Type getTypeFromString(String typeString) {
    assert(_isInitialized, "TypeResolver is not initialized yet.");
    if (!_stringToTypeDict.containsKey(typeString)) {
      throw Exception("[TypeResolver]: Type is NOT registered.");
    }
    return _stringToTypeDict[typeString];
  }

  Object createInstanceFromType(Type type) {
    assert(_isInitialized, "TypeResolver is not initialized yet.");
    if (!_typeCreator.containsKey(type)) {
      throw Exception("[TypeResolver]: Creator is NOT registered.");
    }
    return _typeCreator[type]();
  }
}
