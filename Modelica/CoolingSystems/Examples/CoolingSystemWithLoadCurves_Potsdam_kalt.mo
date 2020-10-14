within CoolingSystems.Examples;
model CoolingSystemWithLoadCurves_Potsdam_kalt
  extends CoolingSystems.BaseClasses.CoolingSystemWithLoadCurvesGeneral(
  coolingLoadKonzertsaal(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Konzertsaal/KS_Potsdam_kalt.csv")),
  coolingLoadUnit(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Unit/UNIT_Potsdam_kalt.csv")),
  coolingLoadAltbau(fileName=Modelica.Utilities.Files.loadResource("modelica://CoolingSystems/Resources/BoundaryConditions/CoolingLoad/Altbau/Altbau_Potsdam_kalt.csv")),
  weaDat(redeclare block WeatherData = BuildingSystems.Climate.WeatherDataDWD.Germany_Potsdam_cold_DWD_ASCII));
  annotation(
    __Dymola_Commands(file="modelica://CoolingSystems/Resources/Scripts/Dymola/Examples/CoolingSystemWithLoadCurves_Potsdam_kalt.mos" "Simulate and plot"));
end CoolingSystemWithLoadCurves_Potsdam_kalt;
