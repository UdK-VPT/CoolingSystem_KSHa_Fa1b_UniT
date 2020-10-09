within CoolingSystems.Examples;
model CoolingSystemWithLoadCurves_Schoenefeld
  extends CoolingSystems.BaseClasses.CoolingSystemWithLoadCurvesGeneral(
  coolingLoadKonzertsaal(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Konzertsaal/KS_Schoenefeld.csv")),
  coolingLoadUnit(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Unit/UNIT_Schoenefeld.csv")),
  coolingLoadAltbau(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Altbau/Altbau_Schoenefeldf.csv")),
  weaDat(redeclare block WeatherData = BuildingSystems.Climate.WeatherDataMeteonorm.Germany_Berlin_Meteonorm_ASCII));
  annotation(
    __Dymola_Commands(file="modelica://CoolingSystems/Resources/Scripts/Dymola/Examples/CoolingSystemWithLoadCurves_Schoenefeld.mos" "Simulate and plot"));
end CoolingSystemWithLoadCurves_Schoenefeld;
