T enumFromString<T>(List<T> enumValues, String? value) {
  return enumValues.firstWhere(
    (e) => e.toString().split('.')[1] == value,
    orElse: () {
      if (value == null) {
        return enumValues[0];
      } else {
        throw Exception(
          '''Invalid value: $value \n
            Available Values: ${enumValues.map((e) => e.toString().split('.')[1]).join(', ')}''',
        );
      }
    },
  );
}
