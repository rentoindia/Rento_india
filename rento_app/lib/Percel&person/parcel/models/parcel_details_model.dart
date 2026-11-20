enum ParcelType { documents, electronics, food, clothing, fragile, other }

enum ParcelSize { small, medium, large }

extension ParcelTypeX on ParcelType {
  String get label {
    switch (this) {
      case ParcelType.documents:
        return 'Documents';
      case ParcelType.electronics:
        return 'Electronics';
      case ParcelType.food:
        return 'Food';
      case ParcelType.clothing:
        return 'Clothing';
      case ParcelType.fragile:
        return 'Fragile Item';
      case ParcelType.other:
        return 'Other';
    }
  }
}

extension ParcelSizeX on ParcelSize {
  String get label {
    switch (this) {
      case ParcelSize.small:
        return 'Small';
      case ParcelSize.medium:
        return 'Medium';
      case ParcelSize.large:
        return 'Large';
    }
  }
}

class ParcelDetailsModel {
  const ParcelDetailsModel({
    required this.type,
    required this.size,
    required this.weightKg,
    this.needsSpecialHandling = false,
    this.instructions,
  });

  final ParcelType type;
  final ParcelSize size;
  final double weightKg;
  final bool needsSpecialHandling;
  final String? instructions;

  String get weightLabel =>
      weightKg < 1 ? 'Under 1 kg' : '${weightKg.toStringAsFixed(1)} kg';

  ParcelDetailsModel copyWith({
    ParcelType? type,
    ParcelSize? size,
    double? weightKg,
    bool? needsSpecialHandling,
    String? instructions,
  }) {
    return ParcelDetailsModel(
      type: type ?? this.type,
      size: size ?? this.size,
      weightKg: weightKg ?? this.weightKg,
      needsSpecialHandling: needsSpecialHandling ?? this.needsSpecialHandling,
      instructions: instructions ?? this.instructions,
    );
  }
}
