enum SortOption { name, price }

extension SortOptionExtension on SortOption {
  String get displayName {
    switch (this) {
      case SortOption.name:
        return 'Name';
      case SortOption.price:
        return 'Price';
    }
  }
}