within CoolingSystems.Examples;
model HeatPumpSystem
  "Simplified model of a building energy supply system based on a heat pump"
  extends Modelica.Icons.Example;
  package Medium1 = BuildingSystems.Media.Water;
  package Medium2 = BuildingSystems.Media.Air;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal= 0.1;
  BuildingSystems.Buildings.Ambience ambience(
    nSurfaces=building.nSurfacesAmbience,
    redeclare block WeatherData = BuildingSystems.Climate.WeatherDataMeteonorm.Germany_Berlin_Meteonorm_ASCII)
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
    redeclare BuildingSystems.Buildings.Data.Constructions.Transparent.HeatProtectionDoubleGlazingUVal14 constructionWindow4)
    "Building model (single family house EnEV 2014)"
    annotation (Placement(transformation(extent={{-64,16},{-44,36}})));
  Modelica.Blocks.Sources.Constant airchange(
    k=0.5)
    annotation (Placement(transformation(extent={{-2,-2},{2,2}},rotation=180,origin={-38,26})));
  Modelica.Blocks.Sources.Constant TSetSup(k=273.15 + 35.0)
    annotation (Placement(transformation(extent={{112,18},{108,22}})));
  BuildingSystems.Fluid.HeatPumps.Carnot_TCon heaPum(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    QCon_flow_nominal=4000,
    use_eta_Carnot_nominal=false,
    COP_nominal=3.4,
    dp1_nominal=10,
    dp2_nominal=10,
    QCon_flow_max=4000,
    TCon_nominal=308.15,
    TEva_nominal=275.15)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  BuildingSystems.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium =Medium2, nPorts=1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, origin={110,-6})));
  BuildingSystems.Fluid.Sources.MassFlowSource_T sou1(
    redeclare package Medium = Medium2,
    use_T_in=true,
    m_flow=0.5,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{114,-20},{106,-12}})));
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
    nPorts=1,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{114,2},{106,10}})));
  BuildingSystems.Fluid.Sources.Boundary_pT sin2(
    redeclare package Medium =Medium1,
    nPorts=1)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, origin={72,6})));
  Modelica.Blocks.Sources.Constant TSetRet(k=273.15 + 25.0)
    annotation (Placement(transformation(extent={{130,2},{126,6}})));
    CoolingSystems.HeatStorage heaSto(
    Q(start=0),
    V=2.0,
    TMax=308.15,
    TMin=298.15)
    annotation (Placement(transformation(extent={{2,-10},{22,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow source
    annotation (Placement(transformation(extent={{42,-10},{22,10}})));
  Modelica.Blocks.Math.Gain gain1(
                                 k=-1)
    annotation (Placement(transformation(extent={{-34,-4},{-26,4}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=0.0, realFalse=0.7)
    annotation (Placement(transformation(extent={{34,14},{46,26}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.2, uHigh=1.0)
    annotation (Placement(transformation(extent={{16,14},{28,26}})));
equation
   connect(ambience.toSurfacePorts, building.toAmbienceSurfacesPorts) annotation (Line(
    points={{-76,30},{-63,30}},
    color={0,255,0},
    smooth=Smooth.None));
  connect(ambience.toAirPorts, building.toAmbienceAirPorts) annotation (Line(
    points={{-76,22},{-63,22}},
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

  connect(TSetSup.y, heaPum.TSet)
    annotation (Line(points={{107.8,20},{102,20},{102,9}},  color={0,0,127}));
  connect(building.T_setCooling[1], TAirSetCooling.y) annotation (Line(points={{-44.2,
          32},{-40,32},{-40,30},{-34.2,30}},       color={0,0,127}));
  connect(building.T_setHeating[1], TAirSetHeating.y) annotation (Line(points={{-44.2,
          34},{-36,34},{-36,36},{-28.2,36}},      color={0,0,127}));
  connect(sin2.ports[1], heaPum.port_b1)
    annotation (Line(points={{76,6},{78,6},{80,6}},    color={0,127,255}));
  connect(load.port, heaSto.port_a1)
    annotation (Line(points={{2,0},{2,0},{8,0}}, color={191,0,0}));
  connect(heaSto.port_a2, source.port)
    annotation (Line(points={{16,0},{16,0},{22,0}}, color={191,0,0}));
  connect(ambience.TAirRef, sou1.T_in) annotation (Line(points={{-93,33},{-98,33},
          {-98,42},{118,42},{118,-14.4},{114.8,-14.4}},
                                                    color={0,0,127}));
  connect(heaPum.port_a1, sou2.ports[1])
    annotation (Line(points={{100,6},{103,6},{106,6}},    color={0,127,255}));
  connect(sou2.T_in, TSetRet.y) annotation (Line(points={{114.8,7.6},{120.4,7.6},
          {120.4,4},{125.8,4}},   color={0,0,127}));
  connect(building.Q_flow_heating[1], gain1.u)
    annotation (Line(points={{-45,15},{-45,0},{-34.8,0}}, color={0,0,127}));
  connect(gain1.y, load.Q_flow)
    annotation (Line(points={{-25.6,0},{-25.6,0},{-18,0}}, color={0,0,127}));
  connect(heaPum.QCon_flow, source.Q_flow) annotation (Line(points={{79,9},{79,16},
          {50,16},{50,0},{42,0}}, color={0,0,127}));
  connect(heaPum.port_b2, sin1.ports[1])
    annotation (Line(points={{100,-6},{103,-6},{106,-6}}, color={0,127,255}));
  connect(sou1.ports[1], heaPum.port_a2) annotation (Line(points={{106,-16},{90,
          -16},{74,-16},{74,-6},{80,-6}}, color={0,127,255}));
  connect(booleanToReal.y, sou2.m_flow_in) annotation (Line(points={{46.6,20},{
          46.6,20},{94,20},{94,26},{120,26},{120,9.2},{114.8,9.2}},
                                                             color={0,0,127}));
  connect(hysteresis.y, booleanToReal.u)
    annotation (Line(points={{28.6,20},{32.8,20}}, color={255,0,255}));
  connect(hysteresis.u, heaSto.chargeLevel)
    annotation (Line(points={{14.8,20},{12,20},{12,8}}, color={0,0,127}));

  annotation(experiment(StartTime=0, StopTime=31536000),
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
  April 25, 2017, by Christoph Nytsch-Geusen:<br/>
  First implementation.
  </li>
  </ul>
  </html>"));
end HeatPumpSystem;
