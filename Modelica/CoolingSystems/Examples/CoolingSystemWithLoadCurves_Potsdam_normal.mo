within CoolingSystems.Examples;
model CoolingSystemWithLoadCurves_Potsdam_normal
  extends CoolingSystems.BaseClasses.CoolingSystemWithLoadCurvesGeneral(
  coolingLoadKonzertsaal(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Konzertsaal/KS_Potsdam_normal.csv")),
  coolingLoadUnit(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Unit/UNIT_Potsdam_normal.csv")),
  coolingLoadAltbau(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Altbau/Altbau_Potsdam_normal.csv")),
  weaDat(redeclare block WeatherData = BuildingSystems.Climate.WeatherDataMeteonorm.Germany_Berlin_Meteonorm_ASCII));
  annotation(
    __Dymola_Commands(file="modelica://CoolingSystems/Resources/Scripts/Dymola/Examples/CoolingSystemWithLoadCurves_Potsdam_warm.mos" "Simulate and plot"));
end CoolingSystemWithLoadCurves_Potsdam_normal;
