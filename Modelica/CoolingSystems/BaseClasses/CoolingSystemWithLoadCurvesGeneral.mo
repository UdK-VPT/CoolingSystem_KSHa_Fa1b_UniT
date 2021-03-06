within CoolingSystems.BaseClasses;
partial model CoolingSystemWithLoadCurvesGeneral
  "Simplified model of a building energy supply system based on a compression chiller"
  extends Modelica.Icons.Example;
  package Medium1 = BuildingSystems.Media.Water;
  package Medium2 = BuildingSystems.Media.Air;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal= 0.1;
  BuildingSystems.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium1,
    nPorts=1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, origin={120,-6})));
  BuildingSystems.Fluid.Sources.MassFlowSource_T sou1(
    redeclare package Medium = Medium2,
    use_T_in=true,
    m_flow=200,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{114,2},{106,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow load
    annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
  BuildingSystems.Fluid.Sources.MassFlowSource_T sou2(
    use_T_in=true,
    redeclare package Medium = Medium1,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{114,-22},{106,-14}})));
  BuildingSystems.Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium2,
    nPorts=1)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, origin={74,6})));
  Modelica.Blocks.Sources.Constant TSetRet(
    k=273.15 + 12.0)
    annotation (Placement(transformation(extent={{138,2},{134,6}})));
    CoolingSystems.ColdStorage cooSto(
    V=4.0,
    TMax=273.15 + 12.0,
    TMin=273.15 + 6.0,
    chargeLevel_start=0.5)
    annotation (Placement(transformation(extent={{2,-10},{22,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow source
    annotation (Placement(transformation(extent={{42,-10},{22,10}})));
  Modelica.Blocks.Math.Gain gain1(
    k=1)
    annotation (Placement(transformation(extent={{-34,-4},{-26,4}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(
    realTrue=0.0,
    realFalse=78.6/3600*1000)
    annotation (Placement(transformation(extent={{48,14},{60,26}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=0.2,
    uHigh=1.0)
    annotation (Placement(transformation(extent={{16,14},{28,26}})));
  BuildingSystems.Technologies.Chillers.CompressionChiller chi(
    redeclare package Medium1 = Medium2,
    redeclare package Medium2 = Medium1,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    dp1_nominal=1,
    dp2_nominal=1,
    redeclare BuildingSystems.Technologies.Chillers.Data.CompressionChillers.TurboCoreTT400 chillerData)
    annotation (Placement(transformation(extent={{102,-10},{82,10}})));
  Modelica.Blocks.Sources.Constant partLoad(
    k=0.7)
    annotation (Placement(transformation(extent={{102,30},{98,34}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{48,44},{60,56}})));
  Modelica.Blocks.Sources.CombiTimeTable coolingLoadKonzertsaal(
    tableOnFile=true,
    tableName="tab1",
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Sources.CombiTimeTable coolingLoadUnit(
    tableOnFile=true,
    tableName="tab1",
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-90,-62},{-70,-42}})));
  Modelica.Blocks.Sources.CombiTimeTable coolingLoadAltbau(
    tableOnFile=true,
    tableName="tab1",
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  BuildingSystems.Climate.WeatherData.WeatherDataReader weaDat
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Blocks.Math.Sum sum(
    nin=3)
    annotation (Placement(transformation(extent={{-52,-6},{-40,6}})));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort TSup(
    redeclare package Medium=Medium1,
    m_flow_nominal=78.6/3600*1000)
    annotation (Placement(transformation(extent={{106,-10},{114,-2}})));
equation
  connect(load.port,cooSto. port_a1)
    annotation (Line(points={{2,0},{2,0},{8,0}}, color={191,0,0}));
  connect(cooSto.port_a2, source.port)
    annotation (Line(points={{16,0},{16,0},{22,0}}, color={191,0,0}));
  connect(sou2.T_in, TSetRet.y) annotation (Line(points={{114.8,-16.4},{126.4,-16.4},
          {126.4,4},{133.8,4}},   color={0,0,127}));
  connect(gain1.y, load.Q_flow)
    annotation (Line(points={{-25.6,0},{-25.6,0},{-18,0}}, color={0,0,127}));
  connect(booleanToReal.y, sou2.m_flow_in) annotation (Line(points={{60.6,20},{130,
          20},{130,-14.8},{114.8,-14.8}},                    color={0,0,127}));
  connect(hysteresis.y, booleanToReal.u)
    annotation (Line(points={{28.6,20},{46.8,20}}, color={255,0,255}));
  connect(hysteresis.u,cooSto. chargeLevel)
    annotation (Line(points={{14.8,20},{12,20},{12,8}}, color={0,0,127}));
  connect(chi.Q_flow_eva, source.Q_flow)
    annotation (Line(points={{83.8,2},{78,2},{78,0},{42,0}}, color={0,0,127}));
  connect(sou1.ports[1], chi.port_a1)
    annotation (Line(points={{106,6},{102,6}}, color={0,127,255}));
  connect(chi.port_b1, bou2.ports[1])
    annotation (Line(points={{82,6},{78,6}}, color={0,127,255}));
  connect(sou2.ports[1], chi.port_a2) annotation (Line(points={{106,-18},{78,-18},
          {78,-6},{82,-6}}, color={0,127,255}));
  connect(partLoad.y, chi.load)
    annotation (Line(points={{97.8,32},{92,32},{92,7.6}}, color={0,0,127}));
  connect(hysteresis.y, not1.u) annotation (Line(points={{28.6,20},{38,20},{38,50},
          {46.8,50}}, color={255,0,255}));
  connect(not1.y, chi.on)
    annotation (Line(points={{60.6,50},{96,50},{96,7.6}}, color={255,0,255}));
  connect(coolingLoadKonzertsaal.y[1], sum.u[1]) annotation (Line(points={{-69,50},
          {-53.2,50},{-53.2,-0.8}}, color={0,0,127}));
  connect(sum.y, gain1.u)
    annotation (Line(points={{-39.4,0},{-34.8,0}}, color={0,0,127}));
  connect(coolingLoadAltbau.y[1], sum.u[2])
    annotation (Line(points={{-69,0},{-53.2,0}}, color={0,0,127}));
  connect(coolingLoadUnit.y[1], sum.u[3]) annotation (Line(points={{-69,-52},{-53.2,
          -52},{-53.2,0.8}}, color={0,0,127}));
  connect(weaDat.TAirRef, sou1.T_in) annotation (Line(points={{83,59},{83,56},{118,
          56},{118,7.6},{114.8,7.6}}, color={0,0,127}));
  connect(chi.port_b2, TSup.port_a)
    annotation (Line(points={{102,-6},{106,-6}}, color={0,127,255}));
  connect(TSup.port_b, bou1.ports[1]) annotation (Line(points={{114,-6},{116,-6},
          {116,-5.2}}, color={0,127,255}));
  connect(TSup.port_b, bou1.ports[2]) annotation (Line(points={{114,-6},{116,-6},
          {116,-6.8}}, color={0,127,255}));

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
April 27, 2021, by Christoph Nytsch-Geusen:<br/>
Adaptation of model parameters to the planning process.
</li>
<li>
October 07, 2020, by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
end CoolingSystemWithLoadCurvesGeneral;
