part of '../app_utils.dart';

extension IterableExtensions<T> on Iterable<T>? {
  /// Returns `true` if this nullable iterable is either `null` or empty.
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  /// Returns `false` if this nullable iterable is either `null` or empty.
  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty;
  }

  /// Returns `true` if at least one element matches the given [predicate].
  bool any(bool predicate(T element)) {
    if (isNullOrEmpty()) return false;
    for (final element in this!) {
      if (predicate(element)) return true;
    }
    return false;
  }

  /// Returns count of elements that matches the given [predicate].
  /// Returns -1 if iterable is null
  int countWhere(bool predicate(T element)) {
    if (this == null) return -1;
    return this!.where(predicate).length;
  }

  /// Convert iterable to set
  Set<T> toSet() => Set.from(this!);

  /// Returns a set containing all elements that are contained
  /// by both this set and the specified collection.
  Set<T> intersect(Iterable other) {
    final set = this.toSet();
    set.retainAll(other);
    return set;
  }

  /// Returns a set containing all elements that are contained
  /// by this collection and not contained by the specified collection.
  Set<T> subtract(Iterable<T> other) {
    final set = toSet();
    set.removeAll(other);
    return set;
  }

  /// Returns a set containing all distinct elements from both collections.
  Set<T> union(Iterable<T> other) {
    final set = toSet();
    set.addAll(other);
    return set;
  }

  /// Performs the given action on each element on iterable, providing sequential index with the element.
  /// [element!] the element on the current iteration
  /// [index!] the index of the current iteration
  ///
  /// example:
  /// ["ss","tt","xx"].forEachIndexed((it, index) {
  ///    print("it, $index");
  ///  });
  /// result:
  /// ss, 0
  /// tt, 1
  /// xx, 2
  void forEachIndexed(void Function(T element, int index) action) {
    var index = 0;
    for (var element in this!) {
      action(element, index++);
    }
  }

  /// Groups elements of the original collection by the key returned by the given [keySelector] function
  /// applied to each element and returns a map where each group key is associated with a list of corresponding elements.
  ///
  /// The returned map preserves the entry iteration order of the keys produced from the original collection.
  Map<K, List<T>> groupBy<T, K>(K keySelector(T e)) {
    if (this == null) return {};
    var map = <K, List<T>>{};

    for (final element in this!) {
      var list = map.putIfAbsent(keySelector(element as T), () => []);
      list.add(element);
    }
    return map;
  }

  /// Returns a list containing only elements matching the given [predicate!]
  List<T> filter(bool test(T element)) {
    if (this == null) return <T>[];
    final result = <T>[];
    this!.forEach((e) {
      if (test(e)) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing all elements not matching the given [predicate!]
  List<T> filterNot(bool test(T element)) {
    if (this == null) return <T>[];
    final result = <T>[];
    this!.forEach((e) {
      if (!test(e)) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing all elements that are not null
  List<T> filterNotNull() {
    if (this == null) return <T>[];
    final result = <T>[];
    this!.forEach((e) {
      if (e != null) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing first [n] elements.
  List<T> take(int n) {
    if (this == null) return <T>[];
    if (n <= 0) return [];

    var list = <T>[];
    if (this is Iterable) {
      if (n >= this!.length) return this!.toList();

      var count = 0;
      var thisList = this!.toList();
      for (var item in thisList) {
        list.add(item);
        if (++count == n) break;
      }
    }
    return list;
  }

  ///  Maps each element and its index to a new value.
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
    var index = 0;
    for (var element in this!) {
      yield convert(index++, element);
    }
  }

  /// Returns first element or null otherwise
  T? get firstOrNull => isNullOrEmpty() ? null : this!.first;

  T? get lastOrNull => isNullOrEmpty() ? null : this!.last;

  /// Returns first element by given predicate or null otherwise
  T? firstWhereOrNull(bool Function(T element) test) {
    if (this == null) return null;
    final list = this!.where(test);
    return list.isEmpty ? null : list.first;
  }

  T? elementAtOrNull(int? index) {
    if (index == null || this == null) return null;
    if (index >= this!.length || index < 0) return null;
    return this?.elementAt(index);
  }
}
