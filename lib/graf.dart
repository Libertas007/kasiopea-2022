class Graf<N extends Node, E extends Edge> {
  List<N> nodes = [];

  void addEdge(int first, int second) {
    nodes[first].neighbours.add(Edge(node: nodes[second], nodeId: second));
    nodes[second].neighbours.add(Edge(node: nodes[first], nodeId: first));
  }

  int addNode(N node) {
    int newId = nodes.length;
    nodes.add(node);
    nodes[newId].nodeId = newId;
    return newId;
  }

  void dfs(void Function(List<N> nodesInComponent) inComponent) {
    List<bool> visited = [];
    for (var i = 0; i < nodes.length; i++) {
      visited.add(false);
    }

    int componentId = 0;
    List<N> nodesInComponent = [];

    void projdi(int u) {
      visited[u] = true;
      nodes[u].componentId = componentId;
      nodesInComponent.add(nodes[u]);

      for (var v in nodes[u].neighbours) {
        if (!visited[v.nodeId]) {
          projdi(v.nodeId);
        }
      }
    }

    for (var i = 0; i < nodes.length; i++) {
      if (!visited[i]) {
        projdi(i);

        componentId++;
        inComponent(nodesInComponent);

        nodesInComponent = [];
      }
    }
  }
}

class Node {
  List<Edge> neighbours = [];
  int componentId = -1;
  int nodeId = -1;
}

class NodeWithPosition extends Node {
  Position2D position;

  NodeWithPosition(this.position) : super();

  @override
  String toString() {
    return "{NodeWithPos: pos: $position; neighbours: $neighbours; id: $nodeId}";
  }
}

class Position2D {
  int x;
  int y;

  Position2D(this.x, this.y);

  @override
  String toString() {
    return "Pos2D{$x, $y}";
  }
}

class Edge<N extends Node> {
  N node;
  int nodeId;
  Edge({required this.node, required this.nodeId});

  @override
  String toString() {
    return "(-> $nodeId)";
  }
}
