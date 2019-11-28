# TypeResolver
TypeResolver provides Type and String with the ability to ultimately resolve to an instance or Type.

## Usage
#### Annotate class that need to resolve with `@TypeResolvable` 
```dart
@TypeResolvable()
class Animal {}
```
#### Remember to initialize at main function
```dart
void main() {
  initializeTypeResolver();
}
```

#### Resolve `String` to `Type`
```dart
void fn() {
  TypeResolver.parseTypeFromTypeString("Animal");
}
```

#### Resolve `Type` to instance
```dart
void fn() {
  TypeResolver.createInstanceFromType(Animal);
}
```

#### Resolve `String` to instance
```dart
void fn() {
  TypeResolver.createInstanceFromTypeString("Animal");
}
```
