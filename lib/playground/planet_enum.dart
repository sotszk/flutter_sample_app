enum PlanetType { terrestrial, gas, ice }

/// Enum that enumerates the different planets in our solar system
/// and some of their properties.
enum Planet {
  mercury(planetType: PlanetType.terrestrial),
  venus(planetType: PlanetType.terrestrial),
  uranus(planetType: PlanetType.ice),
  neptune(planetType: PlanetType.ice);

  /// A constant generating constructor
  const Planet({
    required this.planetType,
  });

  /// All instance variables are final
  final PlanetType planetType;

  /// Enhanced enums support getters and other methods
  bool get isGiant =>
      planetType == PlanetType.gas || planetType == PlanetType.ice;
}
