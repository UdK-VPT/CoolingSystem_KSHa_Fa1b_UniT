within CoolingSystems;
model ColdStorage
  parameter Modelica.SIunits.Volume V
    "Fluid volume";
  parameter Modelica.SIunits.Temp_K TMax = 273.15 + 20.0
    "Maximal fluid temperature";
  parameter Modelica.SIunits.Temp_K TMin = 273.15 + 10.0
    "Minimal fluid temperature";
  parameter Real chargeLevel_start = 0.0
    "Start charge level";
  constant Modelica.SIunits.Density rhoWat = 1000.0
    "Mean density of water";
  Modelica.SIunits.Energy Q(start=Q_nominal*chargeLevel_start)
    "Energy content";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}}),
      iconTransformation(extent={{-50,-10},{-30,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_a2
    annotation (Placement(transformation(extent={{30,-10},{50,10}}),
      iconTransformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Interfaces.RealOutput chargeLevel
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,origin={0,80}),
      iconTransformation(extent={{-10,-10},{10,10}},rotation=90,origin={0,80})));
protected
  parameter Modelica.SIunits.Energy Q_nominal =
    BuildingSystems.Utilities.Psychrometrics.Constants.cpWatLiq * V * rhoWat * (TMin - TMax)
    "Nominal energy capacity";
equation
  port_a1.T = TMin;
  port_a2.T = TMin;
  chargeLevel = Q / Q_nominal;
  der(Q) = port_a1.Q_flow + port_a2.Q_flow;

  annotation (Icon(graphics={Rectangle(extent={{-40,80},{40,-80}},
    lineColor={28,108,200},fillColor={238,46,47},fillPattern=FillPattern.HorizontalCylinder),
    Text(extent={{-34,-76},{34,-102}}, lineColor={0,0,255},textString="%name")}));
end ColdStorage;
