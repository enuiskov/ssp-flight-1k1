"use strict";

stuff
({
	uses :
	[
		'Math',
		'Math.Geometry',
		'System.Drawing',
	],
	//'UVS.Equipment' : {},
	'UVS.Equipment.HUD' :
	 {
		'Indicators/Generic' : 
		 {
			'DebugInfo : Indicator' :
			 {
				Draw : function(iCtx, iObj)
				 {
					iCtx.ZoomIn(0,100);
					{
//						iCtx.Font         = "15% courier";
						iCtx.Font         = "15% quartz";
						iCtx.TextAlign    = "left";
						iCtx.TextBaseline = "top";

						iCtx.Save();
						{
							iCtx.Translate(10,0);

							var _Table =
							[
								["Position", iObj.Position],
								//["Rotation", iObj.Rotation],
								["Velocity", iObj.Velocity.Linear],
								
								//["AngVel", iObj.Velocity.Angular],
								["Wind", gSIM.Vehicle.Data.Wind],
							];

							//for(var _NN = ["PosV","PosD","RotV","RotD"], cV,cN,Ni = 0; cN = _NN[Ni], cV = gApp.Vehicle.Dynamics[cN]; Ni++)
							for(var cR,Ri = 0; cR = _Table[Ri]; Ri++)
							{
								iCtx.BeginPath(), iCtx.MoveTo(2,32), iCtx.LineTo(2,90), iCtx.Stroke();

								iCtx.FillStyle  = "rgba(255,255,255,0.7)";
								iCtx.FontWeight = "bold";
									iCtx.FillText  (cR[0],          0, 10);

								iCtx.FillStyle  = this.Color;
								iCtx.FontWeight = "normal";
									iCtx.FillText  ("X:" + cR[1].X.ToString2(), 10, 30);
									iCtx.FillText  ("Y:" + cR[1].Y.ToString2(), 10, 45);
									iCtx.FillText  ("Z:" + cR[1].Z.ToString2(), 10, 60);

								var _L = cR[1].Length; if(_L != undefined)
								{
									iCtx.FillStyle  = "#ffffff";
									iCtx.FillText("M:" + _L.ToString2(), 10, 75);
								}
								
								if(cR[1] instanceof Quaternion) iCtx.FillText  ("W:" + cR[1].W.ToString2(), 10, 75);
								//if(cR[1] instanceof Rotation)   iCtx.FillText  ("A:" + cR[1].A.ToString2(), 10, 75);

								iCtx.Translate(120,0);
							}
						}
						iCtx.Restore();
					}
					iCtx.ZoomOut();
				 }
			 },
			'Watch     : Indicator' :
			 {
				Draw : function(iCtx, iObj)
				{
					var _Time     = new Date();
					var _MinAngle = _Time.Minute / 60 * (PI * 2);
					var _SecAngle = _Time.Second / 60 * (PI * 2);
					var _MsAngle  = (_Time.ValueOf() % 1000 / 1e3) * (PI * 2);
					
					iCtx.ZoomIn(100);
					iCtx.Translate(50,50);
					{
						Clock:
						{
							Scale:
							{
								var _InR = 35, _OuR = 45; iCtx.LineWidth = 2;
								{
									iCtx.BeginPath(); for(var cA = 0; cA < D360; cA += D360 / 4)
									{
										iCtx.MoveTo(Sin(cA) * _InR, Cos(cA + PI) * _InR);
										iCtx.LineTo(Sin(cA) * _OuR, Cos(cA + PI) * _OuR);
									}
									iCtx.Stroke();
								}
								var _InR = 40, _OuR = 45; iCtx.LineWidth = 1;
								{
									iCtx.BeginPath(); for(var cA = 0; cA < D360; cA += D360 / 12)
									{
										iCtx.MoveTo(Sin(cA) * _InR, Cos(cA + PI) * _InR);
										iCtx.LineTo(Sin(cA) * _OuR, Cos(cA + PI) * _OuR);
									}
									iCtx.Stroke();
								}
							}
							Minutes:
							{
								var _Radius = 40; iCtx.LineWidth = 10; iCtx.GlobalAlpha = 0.7; 
								
								iCtx.BeginPath();
								iCtx.AddArc(0,0, _Radius, -D090, _MinAngle - D090, _Time.Minute >= 30);
								iCtx.Stroke();
							}
							Seconds:
							{
								var _InR = 40, _OuR = 45;
								
								iCtx.BeginPath();
								iCtx.MoveTo(Sin(_SecAngle) * _InR, Cos(_SecAngle + PI) * _InR);
								iCtx.LineTo(Sin(_SecAngle) * _OuR, Cos(_SecAngle + PI) * _OuR);
								
								iCtx.LineWidth   = 5;
								iCtx.GlobalAlpha = 1;
								iCtx.Stroke();
							}
						}
						Text : 
						{
							iCtx.Font = "30% tahoma";
							iCtx.TextBaseline = "middle";
							
							iCtx.TextAlign = "center";
							iCtx.FillText(_Time.Minute < 30 ? _Time.Hour : _Time.AddHours(1).Hour, 0, -1);
						}
					}
					iCtx.ZoomOut();
				}
			 },
		 }
	 },
});