import 'dart:async';

void main() {
  StreamSubscription sub =
      Stream.periodic(const Duration(seconds: 1), (v) => 'V is $v').listen((event) {
    print(event);
  });

  Future.delayed(Duration(seconds: 6), () => sub..cancel());

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
