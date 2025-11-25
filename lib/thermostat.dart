class Thermostat {
  double _temperature = 15.0;

  double get temperature => _temperature;

  void setTemperature(double value) {
    if (value < 15.0) {
      _temperature = 15.0;
    } else if (value > 30.0) {
      _temperature = 30.0;
    } else {
      _temperature = value;
    }
  }
}
