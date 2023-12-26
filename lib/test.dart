import 'dart:async';

void main() {
  var s = 50.normalized(0, 60);
  print(s);
  
}

extension Normalize on num {
  num normalized(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num normalizeMaxRange = 1.0,
  ]) =>
      (normalizeMaxRange - normalizedRangeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizedRangeMin;
}
