import 'dart:developer';
import 'dart:io';

void main() async {
  log("Running Future Benchmark");
  await benchmarkFibAtAsync(1);
  await benchmarkFibAtAsync(10);
  await benchmarkFibAtAsync(100);

  log("Running Stream Benchmark");
  await benchmarkFibStream(1);
  await benchmarkFibStream(10);
  await benchmarkFibStream(100);
}

Future<int> fibAtAsync(int step) async => calculateFibAsync(0, 0, step);

Future<int> calculateFibAsync(int p, int n, int step) async {
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
  log("[Benchmarking $step steps] elapsed: ${timer.elapsed}");
}

Stream<int> fibStream(int step) async* {
  yield* calcFibStream(0, 0, step);
}

Stream<int> calcFibStream(int p, int n, int step) async* {
  if (step < 0) {
    yield p;
    return;
  }
  final prevNum = n;
  final newNum = (p == 0 && n == 0) ? 1 : p + n;
  final newStep = step - 1;
  // print("p: $p, n: $n, step: $step");
  sleep(Duration(milliseconds: 1));
  if (step == 0) {
    yield n;
    return;
  }
  yield* calcFibStream(prevNum, newNum, newStep);
}

Future<void> benchmarkFibStream(int step) async {
  Stopwatch timer = Stopwatch();
  timer.start();
  await for (int n in fibStream(step)) {}
  timer.stop();
  log("[Benchmarking $step steps] elapsed: ${timer.elapsed}");
}
