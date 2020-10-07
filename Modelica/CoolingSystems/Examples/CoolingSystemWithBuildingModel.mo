within CoolingSystems.Examples;
model CoolingSystemWithBuildingModel
  "Simplified model of a building energy supply system based on a compression chiller"
  extends Modelica.Icons.Example;
  package Medium1 = BuildingSystems.Media.Water;
  package Medium2 = BuildingSystems.Media.Water;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal= 0.1;
  BuildingSystems.Buildings.Ambience ambience(
    nSurfaces=building.nSurfacesAmbience, redeclare block WeatherData =
        BuildingSystems.Climate.WeatherDataMeteonorm.Brazil_Manaus_Meteonorm_ASCII)
    "Ambience model"
    annotation (Placement(transformation(extent={{-94,16},{-74,36}})));
  BuildingSystems.Buildings.BuildingTemplates.Building1Zone1DDistrict building(
    heightWindow1=2.72,
    heightWindow2=2.61,
    heightWindow3=2.72,
    heightWindow4=2.61,
    widthWindow1=2.72,
    widthWindow2=2.61,
    widthWindow3=2.72,
    widthWindow4=2.61,
    calcIdealLoads=true,
    redeclare BuildingSystems.Buildings.Data.Constructions.Thermal.OuterWallSingle2014 constructionWall1,
    redeclare BuildingSystems.Buildings.Data.Constructions.Thermal.OuterWallSingle2014 constructionWall2,
    redeclare BuildingSystems.Buildings.Data.Constructions.Thermal.OuterWallSingle2014 constructionWall3,
    redeclare BuildingSystems.Buildings.Data.Constructions.Thermal.OuterWallSingle2014 constructionWall4,
    redeclare BuildingSystems.Buildings.Data.Constructions.Thermal.RoofSingle2014 constructionCeiling,
    redeclare BuildingSystems.Buildings.Data.Constructions.Thermal.BasePlateSingle2014 constructionBottom,
    redeclare BuildingSystems.Buildings.Data.Constructions.Thermal.IntermediateWallSingle2014 constructionWallsInterior,
    redeclare BuildingSystems.Buildings.Data.Constructions.Thermal.IntermediateCeilingSingle2014 constructionCeilingsInterior,
    width=8.91,
    length=9.64,
    heightSto=2.55,
    nSto=2,
    redeclare BuildingSystems.Buildings.Data.Constructions.Transparent.HeatProtectionDoubleGlazingUVal14 constructionWindow1,
    redeclare BuildingSystems.Buildings.Data.Constructions.Transparent.HeatProtectionDoubleGlazingUVal14 constructionWindow2,
    redeclare BuildingSystems.Buildings.Data.Constructions.Transparent.HeatProtectionDoubleGlazingUVal14 constructionWindow3,
    redeclare BuildingSystems.Buildings.Data.Constructions.Transparent.HeatProtectionDoubleGlazingUVal14 constructionWindow4,
    nZones=1)
    "Building model (single family house EnEV 2014)"
    annotation (Placement(transformation(extent={{-64,16},{-44,36}})));
  Modelica.Blocks.Sources.Constant airchange(k=2.0)
    annotation (Placement(transformation(extent={{-2,-2},{2,2}},rotation=180,origin={-38,26})));
  BuildingSystems.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium =Medium1, nPorts=1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, origin={110,-6})));
  BuildingSystems.Fluid.Sources.MassFlowSource_T sou1(
    redeclare package Medium = Medium2,
    use_T_in=true,
    m_flow=0.5,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{114,2},{106,10}})));
  Modelica.Blocks.Sources.Constant TAirSetCooling(k=273.15 + 26.0) annotation (
      Placement(transformation(
        extent={{-2,-2},{2,2}},
        rotation=180,
        origin={-32,30})));
  Modelica.Blocks.Sources.Constant TAirSetHeating(k=273.15 + 20.0) annotation (
      Placement(transformation(
        extent={{-2,-2},{2,2}},
        rotation=180,
        origin={-26,36})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow load
    annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
  BuildingSystems.Fluid.Sources.MassFlowSource_T sou2(
    use_T_in=true,
    redeclare package Medium = Medium1,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{114,-22},{106,-14}})));
  BuildingSystems.Fluid.Sources.Boundary_pT sin2(
    redeclare package Medium =Medium2, nPorts=1)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, origin={74,6})));
  Modelica.Blocks.Sources.Constant TSetRet(k=273.15 + 20.0)
    annotation (Placement(transformation(extent={{130,2},{126,6}})));
    CoolingSystems.ColdStorage cooSto(
    V=2.0,
    TMax=291.15,
    TMin=285.15,
    chargeLevel_start=0.5)
    annotation (Placement(transformation(extent={{2,-10},{22,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow source
    annotation (Placement(transformation(extent={{42,-10},{22,10}})));
  Modelica.Blocks.Math.Gain gain1(
                                 k=-1)
    annotation (Placement(transformation(extent={{-34,-4},{-26,4}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=0.0, realFalse=0.7)
    annotation (Placement(transformation(extent={{48,14},{60,26}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.2, uHigh=1.0)
    annotation (Placement(transformation(extent={{16,14},{28,26}})));
  BuildingSystems.Technologies.Chillers.CompressionChiller chi(
    redeclare package Medium1 = Medium2,
    redeclare package Medium2 = Medium1,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    dp1_nominal=1,
    dp2_nominal=1,
    redeclare
      BuildingSystems.Technologies.Chillers.Data.CompressionChillers.StandardChiller3000W
      chillerData)
    annotation (Placement(transformation(extent={{102,-10},{82,10}})));
  Modelica.Blocks.Sources.Constant partLoad(k=0.5)
    annotation (Placement(transformation(extent={{102,30},{98,34}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{48,44},{60,56}})));
equation
   connect(ambience.toSurfacePorts, building.toAmbienceSurfacesPorts) annotation (Line(
    points={{-75,30},{-63,30}},
    color={0,255,0},
    smooth=Smooth.None));
  connect(ambience.toAirPorts, building.toAmbienceAirPorts) annotation (Line(
    points={{-75,22},{-63,22}},
    color={85,170,255},
    smooth=Smooth.None));
  connect(ambience.TAirRef, building.TAirAmb) annotation (Line(
      points={{-93,33},{-94,33},{-94,38},{-47.8,38},{-47.8,35.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ambience.xAir, building.xAirAmb) annotation (Line(
      points={{-93,31},{-96,31},{-96,40},{-45.6,40},{-45.6,35.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(building.airchange[1], airchange.y) annotation (Line(
      points={{-44.2,30},{-42,30},{-42,26},{-40.2,26}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(building.T_setCooling[1], TAirSetCooling.y) annotation (Line(points={{-44.2,
          32},{-40,32},{-40,30},{-34.2,30}},       color={0,0,127}));
  connect(building.T_setHeating[1], TAirSetHeating.y) annotation (Line(points={{-44.2,
          34},{-36,34},{-36,36},{-28.2,36}},      color={0,0,127}));
  connect(load.port,cooSto. port_a1)
    annotation (Line(points={{2,0},{2,0},{8,0}}, color={191,0,0}));
  connect(cooSto.port_a2, source.port)
    annotation (Line(points={{16,0},{16,0},{22,0}}, color={191,0,0}));
  connect(ambience.TAirRef, sou1.T_in) annotation (Line(points={{-93,33},{-98,33},
          {-98,42},{118,42},{118,7.6},{114.8,7.6}}, color={0,0,127}));
  connect(sou2.T_in, TSetRet.y) annotation (Line(points={{114.8,-16.4},{122.4,-16.4},
          {122.4,4},{125.8,4}},   color={0,0,127}));
  connect(gain1.y, load.Q_flow)
    annotation (Line(points={{-25.6,0},{-25.6,0},{-18,0}}, color={0,0,127}));
  connect(booleanToReal.y, sou2.m_flow_in) annotation (Line(points={{60.6,20},{94,
          20},{94,26},{120,26},{120,-14.8},{114.8,-14.8}},   color={0,0,127}));
  connect(hysteresis.y, booleanToReal.u)
    annotation (Line(points={{28.6,20},{46.8,20}}, color={255,0,255}));
  connect(hysteresis.u,cooSto. chargeLevel)
    annotation (Line(points={{14.8,20},{12,20},{12,8}}, color={0,0,127}));

  connect(chi.Q_flow_eva, source.Q_flow)
    annotation (Line(points={{83.8,2},{78,2},{78,0},{42,0}}, color={0,0,127}));
  connect(sou1.ports[1], chi.port_a1)
    annotation (Line(points={{106,6},{102,6}}, color={0,127,255}));
  connect(chi.port_b1, sin2.ports[1])
    annotation (Line(points={{82,6},{78,6}}, color={0,127,255}));
  connect(chi.port_b2, sin1.ports[1])
    annotation (Line(points={{102,-6},{106,-6}}, color={0,127,255}));
  connect(sou2.ports[1], chi.port_a2) annotation (Line(points={{106,-18},{78,-18},
          {78,-6},{82,-6}}, color={0,127,255}));
  connect(partLoad.y, chi.load)
    annotation (Line(points={{97.8,32},{92,32},{92,7.6}}, color={0,0,127}));
  connect(building.Q_flow_cooling[1], gain1.u)
    annotation (Line(points={{-63,15},{-63,0},{-34.8,0}}, color={0,0,127}));
  connect(hysteresis.y, not1.u) annotation (Line(points={{28.6,20},{38,20},{38,50},
          {46.8,50}}, color={255,0,255}));
  connect(not1.y, chi.on)
    annotation (Line(points={{60.6,50},{96,50},{96,7.6}}, color={255,0,255}));

  annotation(experiment(StopTime=31536000),
    __Dymola_Commands(file="modelica://WaveSave/Resources/Scripts/Dymola/AbstractSystems/HeatPumpSystem.mos" "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{140,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,40}})),
  Documentation(info="<html>
  <p>
  Example that simulates a energy system based on an air / water heat pump and
  a thermal storage.
  </p>
  </html>",
  revisions="<html>
  <ul>
  <li>
  October 07, 2020, by Christoph Nytsch-Geusen:<br/>
  First implementation.
  </li>
  </ul>
  </html>"));
end CoolingSystemWithBuildingModel;
