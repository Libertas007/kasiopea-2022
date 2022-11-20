import 'dart:io';
import 'dart:math' as math;

import 'package:kasiopea2022/graf.dart';

void solveA(String input) {
  final lines = input.split("\n");
  int pointer = 0;

  final problems = (int.tryParse(lines[pointer]) ?? 0);
  String output = "";

  pointer++;

  for (var i = 0; i < problems; i++) {
    int velkaCena = int.parse(lines[pointer]);
    pointer++;
    int velkaObjem = int.parse(lines[pointer]);
    pointer++;
    int malaCena = int.parse(lines[pointer]);
    pointer++;
    int malaObjem = int.parse(lines[pointer]);
    pointer++;

    final velkaCenaZaLitr = (velkaCena / velkaObjem).floor();
    final malaCenaZaLitr = (malaCena / malaObjem).floor();

    print("Velká: ${velkaCena}Kč / ${velkaObjem}l (${velkaCenaZaLitr}Kč/l)");
    print("Malá: ${malaCena}Kč / ${malaObjem}l (${malaCenaZaLitr}Kč/l)");
    if (velkaCenaZaLitr <= malaCenaZaLitr) {
      print("VELKÁ JE LEPŠÍ!!! ===========");
      output += "VETSI\n";
    } else {
      print("MALÁ JE LEPŠÍ!!! ===========");
      output += "MENSI\n";
    }

    print("Solved ${i + 1}/$problems problems");
  }

  final outputFile = File("./A.out");
  outputFile.writeAsStringSync(output);
}

void solveB(String input) {
  final lines = input.split("\n");
  int pointer = 0;

  final problems = (int.tryParse(lines[pointer]) ?? 0);
  String output = "";

  pointer++;
  for (var i = 0; i < problems; i++) {
    int dny = int.tryParse(lines[pointer]) ?? 0;
    pointer++;
    List<int> teploty =
        lines[pointer].split(" ").map((e) => int.tryParse(e) ?? 0).toList();
    pointer++;

    List<int> rozdily = [];
    for (var j = 0; j < teploty.length - 1; j++) {
      rozdily.add((teploty[j] - teploty[j + 1]).abs());
    }

    output += rozdily.reduce(math.max).toString();
    output += "\n";
    print("Solved ${i + 1}/$problems problems");
  }

  final outputFile = File("./B.out");
  outputFile.writeAsStringSync(output);
}

void solveC(String input) {
  final lines = input.split("\n");
  int pointer = 0;

  final problems = (int.tryParse(lines[pointer]) ?? 0);
  String output = "";

  pointer++;

  for (var i = 0; i < problems; i++) {
    int pocetRostlin = int.tryParse(lines[pointer]) ?? 0;
    pointer++;
    Map<String, int> rostliny = {};

    for (var j = 0; j < pocetRostlin; j++) {
      final data = lines[pointer].split(" ");
      pointer++;

      String nazev = data[0];
      int pocet = int.tryParse(data[1]) ?? 0;
      if (rostliny.containsKey(nazev)) {
        rostliny[nazev] = (rostliny[nazev] ?? 0) + pocet;
      } else {
        rostliny.addAll({nazev: pocet});
      }
    }
    output += "${rostliny.length}\n";
    rostliny.forEach((key, value) {
      output += "$key $value\n";
    });
    print("Solved ${i + 1}/$problems problems");
  }

  final outputFile = File("./C.out");
  outputFile.writeAsStringSync(output);
}

void solveD(String input) {
  final lines = input.split("\n");
  int pointer = 0;

  final problems = (int.tryParse(lines[pointer]) ?? 0);
  String output = "";

  pointer++;

  for (var i = 0; i < problems; i++) {
    final data = lines[pointer].split(" ");
    pointer++;

    final sirka = int.tryParse(data[0]) ?? 0;
    final vyska = int.tryParse(data[1]) ?? 0;
    final pocetLesu = int.tryParse(data[2]) ?? 0;

    Graf<NodeWithPosition, Edge> graf = Graf();

    for (var j = 0; j < pocetLesu; j++) {
      final data = lines[pointer].split(" ");
      pointer++;
      final x = int.parse(data[0]);
      final y = int.parse(data[1]);
      int id = graf.addNode(NodeWithPosition(Position2D(x, y)));

      final neighbours = graf.nodes.where(
        (node) =>
            (node.position.x == x && node.position.y == y + 1) ||
            (node.position.x == x && node.position.y == y - 1) ||
            (node.position.x == x + 1 && node.position.y == y) ||
            (node.position.x == x - 1 && node.position.y == y),
      );

      if (neighbours.isNotEmpty) {
        neighbours.forEach(
          (neighbour) {
            graf.addEdge(id, neighbour.nodeId);
          },
        );
      }
    }

    int totalArea = 0;

    graf.dfs((nodesInComponent) {
      final xs = nodesInComponent.map((e) => e.position.x);
      final ys = nodesInComponent.map((e) => e.position.y);

      final xmin = xs.reduce(math.min);
      final xmax = xs.reduce(math.max);
      final ymin = ys.reduce(math.min);
      final ymax = ys.reduce(math.max);

      final area = ((xmax - xmin + 1) * (ymax - ymin + 1));
      totalArea += area;
    });

    output += "$totalArea\n";

    print("Solved ${i + 1}/$problems problems");
  }

  final outputFile = File("./D.out");
  outputFile.writeAsStringSync(output);
}

int pocetJednicek(String input) {
  return "1".allMatches(input).length;
}

void solveE(String input) {
  final lines = input.split("\n");
  int pointer = 0;

  final problems = (int.tryParse(lines[pointer]) ?? 0);
  String output = "";

  pointer++;

  for (var i = 0; i < problems; i++) {
    final data = lines[pointer].split(" ");
    pointer++;

    final pocetSymbolu = int.parse(data[0]);
    final maxJednicek = int.parse(data[1]);

    List<List<String>> vyznamy = [];

    for (var i = 0; i < pocetSymbolu; i++) {
      final pocetVyznamu = int.parse(lines[pointer]);
      pointer++;
      vyznamy.add([]);
      final mozneVyznamy = lines[pointer].split(" ");
      pointer++;
      vyznamy.last
          .addAll(mozneVyznamy.map((e) => int.parse(e).toRadixString(2)));
    }

    int moznosti = 0;

    void deeper(int layer, int used) {
      for (var i = 0; i < vyznamy[layer].length; i++) {
        final vyznam = vyznamy[layer][i];
        int jednicky = pocetJednicek(vyznam);

        // print(" " * layer * 4 + "$vyznam: (využito $used)");

        if (jednicky + used > maxJednicek) continue; // Konec
        // print(" " * layer * 4 + "|Míň než max");
        if (jednicky + used == maxJednicek) {
          if (layer + 1 == vyznamy.length) {
            // print(" " * layer * 4 + "|Možnost!");
            moznosti++;
            continue;
          }
          // print(" " * layer * 4 +
          //     "|Stejný, ale moc brzo... (možná tem něco bude)");
        }

        if (layer + 1 == vyznamy.length) {
          // print(" " * layer * 4 + "|Na konci...");
          continue;
        }
        // print(" " * layer * 4 + "|Jdeme hlouběji...");
        deeper(layer + 1, used + jednicky);
      }
    }

    deeper(0, 0);
    print(moznosti);
    print("Solved ${i + 1}/$problems problems");
    output += "$moznosti\n";
  }

  final outputFile = File("./E.out");
  outputFile.writeAsStringSync(output);
}
