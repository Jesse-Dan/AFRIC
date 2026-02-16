enum Direction { credit, debit }

extension DirectionExtension on Direction {
  String toJson() {
    return name.toUpperCase();
  }

  static Direction fromJson(String json) {
    return Direction.values.firstWhere(
      (direction) => direction.name.toLowerCase() == json.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid direction: $json'),
    );
  }

  static Direction? fromJsonOrNull(String? json) {
    if (json == null) return null;
    try {
      return Direction.values.firstWhere(
        (direction) => direction.name.toLowerCase() == json.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
