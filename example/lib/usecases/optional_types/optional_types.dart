import 'another_class.dart';
import 'custom_item.dart';
import 'item_status.dart';

class OptionalTypes {
  int sumNullable(int? a, int? b) {
    return (a ?? 0) + (b ?? 0);
  }

  String greet(String name, [String? prefix]) {
    if (prefix != null) return '$prefix $name';
    return 'Hello $name';
  }

  int calculate(int x, {int y = 0, int? z}) {
    return x + y + (z ?? 0);
  }

  String formatStatus(ItemStatus status, {bool uppercase = false}) {
    final s = status.name;
    return uppercase ? s.toUpperCase() : s;
  }

  int processItem(CustomItem item, {int multiplier = 1}) {
    return item.id * multiplier;
  }

  AnotherClass getAnother(int i) {
    return AnotherClass('Title $i', i.toDouble());
  }

  int? findId(String name) {
    if (name == 'admin') return 1;
    if (name == 'guest') return 0;
    return null;
  }

  CustomItem? findItem(int id) {
    if (id == 1) return const CustomItem(id: 1, name: "Item 1");
    return null;
  }
}
