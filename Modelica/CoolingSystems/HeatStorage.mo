within CoolingSystems;
model HeatStorage
  extends CoolingSystems.BaseClasses.ThermalStorage(
  TMax = 273.15 + 60.0,
  TMin = 273.15 + 20.0,
  Q_nominal = BuildingSystems.Utilities.Psychrometrics.Constants.cpWatLiq * V * rhoWat * (TMax - TMin));
end HeatStorage;
