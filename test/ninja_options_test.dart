import 'package:decisioninja/pages/ninja_page.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pins how the Ninja page's single text field turns input into options.
void main() {
  test('one name is one option, trimmed', () {
    expect(newOptionNames('  Pizza ', []), ['Pizza']);
  });

  test('a pasted list splits on commas and newlines', () {
    expect(newOptionNames('Pizza, Sushi,Tacos\nRamen', []),
        ['Pizza', 'Sushi', 'Tacos', 'Ramen']);
  });

  test('blanks are dropped', () {
    expect(newOptionNames(' , ,\n', []), isEmpty);
    expect(newOptionNames('Pizza,, ,Sushi,', []), ['Pizza', 'Sushi']);
  });

  test('names already in the list are skipped, ignoring case', () {
    expect(newOptionNames('pizza, Burger', ['Pizza', 'Sushi']), ['Burger']);
  });

  test('duplicates within one paste are added once', () {
    expect(newOptionNames('Tacos, tacos, TACOS', []), ['Tacos']);
  });

  test('no length or count limit', () {
    final long = 'A really quite long option name';
    final many = List.generate(20, (i) => 'Option $i').join(',');
    expect(newOptionNames(long, []), [long]);
    expect(newOptionNames(many, []), hasLength(20));
  });
}
