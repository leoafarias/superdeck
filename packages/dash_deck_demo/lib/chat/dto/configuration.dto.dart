abstract class Configuration {
  final int? topK;
  final double? topP;
  final double? temperature;

  Configuration({
    this.topK,
    this.topP,
    this.temperature,
  });
}

class FocusedConfiguration extends Configuration {
  FocusedConfiguration() : super(topK: 10, topP: 0.95, temperature: 0.2);
}

class CreativeConfiguration extends Configuration {
  CreativeConfiguration() : super(topK: 100, topP: 0.3, temperature: 1.0);
}

class BalancedConfiguration extends Configuration {
  BalancedConfiguration() : super(topK: 50, topP: 0.8, temperature: 0.7);
}
