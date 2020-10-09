within CoolingSystems.Examples;
model CoolingSystemWithLoadCurves_Tempelhof
  extends CoolingSystems.BaseClasses.CoolingSystemWithLoadCurvesGeneral(
  coolingLoadKonzertsaal(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Konzertsaal/KS_Tempelhof.csv")),
  coolingLoadUnit(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Unit/UNIT_Tempelhof.csv")),
  coolingLoadAltbau(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Altbau/Altbau_Tempelhof.csv")),
  weaDat(redeclare block WeatherData = BuildingSystems.Climate.WeatherDataMeteonorm.Germany_Berlin_Meteonorm_ASCII));
  annotation(
    __Dymola_Commands(file="modelica://CoolingSystems/Resources/Scripts/Dymola/Examples/CoolingSystemWithLoadCurves_Tempelhof.mos" "Simulate and plot"));
end CoolingSystemWithLoadCurves_Tempelhof;
