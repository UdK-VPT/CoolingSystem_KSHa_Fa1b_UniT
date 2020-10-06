within CoolingSystems;
model HeatStorage
  parameter Modelica.SIunits.Volume V
    "Fluid volume";
  parameter Modelica.SIunits.Temp_K TMax = 273.15 + 60.0
    "Maximal fluid temperature";
  parameter Modelica.SIunits.Temp_K TMin = 273.15 + 20.0
    "Minimal fluid temperature";
  constant Modelica.SIunits.Density rhoWat = 1000.0
    "Mean desnity of water";
  parameter Modelica.SIunits.Energy Q_nominal =
    BuildingSystems.Utilities.Psychrometrics.Constants.cpWatLiq * V * rhoWat * (TMax - TMin)
    "Nominal energy capacity";
  Modelica.SIunits.Energy Q(start= 0.0)
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
equation
  port_a1.T = TMin;
  port_a2.T = TMin;
  chargeLevel = Q / Q_nominal;
  der(Q) = port_a1.Q_flow + port_a2.Q_flow;

  annotation (Icon(graphics={Rectangle(extent={{-40,80},{40,-80}},
    lineColor={28,108,200},fillColor={238,46,47},fillPattern=FillPattern.HorizontalCylinder),
    Text(extent={{-34,-76},{34,-102}}, lineColor={0,0,255},textString="%name")}));
end HeatStorage;
