void main() {
  final list = [null, 1, 4, 'g '];
  Iterable f = list.check();
  print(f);

  print(list.check<int>((v) {
    if (v is int) {
      return v;
    } else {
      return 111;
    }
  }));
}

extension TestMap<T> on Iterable<T?> {
  Iterable<T?> check<E>([E? Function(T?)? fun]) {
    return map(
      fun ?? (e) => e,
    ).where((element) => element != null).cast();
  }
}

extension OnList<T> on List? {
  List? checkNull() {
    if (this != null) {
      return this as List<T>;
    } else {
      return ['THis is null'] as List<T>;
    }
  }
}
