import 'dart:io';

import 'package:kasiopea2022/kasiopea2022.dart';

void main(List<String> arguments) {
  print("Starting...");
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();

  // File input = File("./A.txt");
  // solveA(input.readAsStringSync());

  // File input = File("./B.txt");
  // solveB(input.readAsStringSync());

  // File input = File("./C.txt");
  // solveC(input.readAsStringSync());

  // File input = File("./D.txt");
  // solveD(input.readAsStringSync());

  File input = File("./E.txt");
  solveE(input.readAsStringSync());

  print("Time elapsed: ${stopwatch.elapsedMilliseconds}ms");
}
