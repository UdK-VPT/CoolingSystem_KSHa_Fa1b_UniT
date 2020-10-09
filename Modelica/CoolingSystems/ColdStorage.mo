within CoolingSystems;
model ColdStorage
  extends CoolingSystems.BaseClasses.ThermalStorage(
  TMax = 273.15 + 20.0,
  TMin = 273.15 + 10.0,
  Q_nominal = BuildingSystems.Utilities.Psychrometrics.Constants.cpWatLiq * V * rhoWat * (TMin - TMax));
end ColdStorage;
