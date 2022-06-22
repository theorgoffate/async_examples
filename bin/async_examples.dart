import 'dart:io';

void main() async {
  await benchmarkFibAtAsync(1);
  await benchmarkFibAtAsync(10);
  await benchmarkFibAtAsync(100);
  await benchmarkFibAtAsync(1000);
}

Future<int> fibAtAsync(int step) async => calculateFibAsync(0, 0, step);

Future<int> calculateFibAsync(int p, int n, int step) async {
//   print("p: $p, n: $n, step: $step");
  if (step < 0) {
    return p;
  }
  final prevNum = n;
  final newNum = (p == 0 && n == 0) ? 1 : p + n;
  final newStep = step - 1;
  sleep(Duration(milliseconds: 1));
  return (step == 0)
      ? Future(() => n)
      : calculateFibAsync(prevNum, newNum, newStep);
}

Future<void> benchmarkFibAtAsync(int step) async {
  Stopwatch timer = Stopwatch();
  timer.start();
  await fibAtAsync(step);
  timer.stop();
  print("[Benchmarking $step steps] elapsed: ${timer.elapsed}");
}
