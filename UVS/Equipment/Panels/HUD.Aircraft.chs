"use strict";

stuff
({
	uses :
	[
		'System.Drawing: *, -Vector',
		'Math',
		'Math.Geometry',

		'UVS.Equipment',
	],
	
	'UVS.Equipment.HUD' :
	 {
		'Layouts' : 
		 {
			'Vehicles/Aircraft' : jso
			 ({
				Indicators :
				[
					{ID : "Vehicles/Aircraft/Heading",        Bounds : [.25, .175, .50, .07]},
					{ID : "Vehicles/Aircraft/Attitude",       Bounds : [.25, .25,  .50, .50]},
					
					{ID : "Vehicles/Aircraft/Speeds",         Bounds : [.08, .25,  .165, .165]},
					{ID : "Vehicles/Aircraft/Misc1",          Bounds : [.08, .415, .165, .165]},
					{ID : "Vehicles/Aircraft/Surfaces",       Bounds : [.08, .58,  .165, .165]},
					

					{ID : "Vehicles/Aircraft/Altimeter",      Bounds : [.755, .25,  .165, .165]},
					{ID : "Vehicles/Aircraft/Situation",      Bounds : [.755, .415, .165, .165]},
					{ID : "Vehicles/Aircraft/Inputs",         Bounds : [.755, .58,  .165, .165]},
					//{ID : "Generic/Watch",               Bounds : [.755, .58,  .165, .165]},

					//{ID : "Generic/DebugInfo",                Bounds : [.08, .755,  .84, .15]},
					{ID : "Generic/DebugInfo",                Bounds : [.23, .755,  .84, .15]},
				]
			 }),
		 },
		'Indicators' : 
		 {
			'Vehicles/Aircraft' :
			 {
				'Heading        : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						if(isNaN(iObj.Data.Attitude.Heading))
						{
							Indicator.Drawing.DrawError(iCtx, this.Bounds);
							return;
						}

						iCtx.ZoomIn(0, 100);
						{
							//iCtx.Font = "75% lucida sans";
							iCtx.Font = "75% quartz";
							iCtx.TextBaseline = "middle";
							iCtx.TextAlign    = "center";
							
							iCtx.FillText(Round(iObj.Data.Attitude.Heading), iCtx.W / 2, iCtx.H / 2);
						}
						iCtx.ZoomOut();
					}
				 },
				'Attitude       : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						var _IsPrimaryIndicator = iCtx.W > 200;
						var _Data = iObj.Data.Attitude;

						if(isNaN(_Data.Pitch * _Data.Bank *  _Data.Heading))
						{
							Indicator.Drawing.DrawError(iCtx, true);
							return;
						}
						
						iCtx.BeginPath();
						iCtx.AddRect(0,0,iCtx.W,iCtx.H);
						iCtx.Clip();


						iCtx.ZoomIn(100);
						iCtx.Translate(50,50);
						{
							iCtx.TextAlign    = "center";
							iCtx.TextBaseline = "middle";
							iCtx.FontSize     = "5%";

							var _PitchStep  = 3;

							var _ScaleWidth = 30;
							var _LabelOffs  = _ScaleWidth + 10;

							//~~ center 'bird';
							iCtx.BeginPath();
							{
								iCtx.MoveTo(-6,  0);
								iCtx.LineTo(-3,  0);
								iCtx.LineTo( 0, +3);
								iCtx.LineTo(+3,  0);
								iCtx.LineTo(+6,  0);

								iCtx.LineWidth = 1;
								iCtx.Stroke();
							}
							
							iCtx.Save();
							iCtx.Rotate(-_Data.Bank * DTR);
							iCtx.Translate(0, (_Data.Pitch / 90) * (_PitchStep * 90));
							{
								//~~ zenith & nadir;
								iCtx.BeginPath();
								{
									iCtx.Save();
									{
										iCtx.Translate(0,-90 * _PitchStep);
										iCtx.MoveTo(-2,  0); iCtx.LineTo(+2,  0);
										iCtx.MoveTo( 0, -2); iCtx.LineTo( 0, +2);

										iCtx.Translate(0, +180 * _PitchStep);
										iCtx.MoveTo(-2,  0); iCtx.LineTo(+2,  0);
										iCtx.MoveTo( 0, -2); iCtx.LineTo( 0, +2);
									}
									iCtx.Restore();

									iCtx.LineWidth = 1;
									iCtx.Stroke();
								}

								//~~ horizon line;
								iCtx.BeginPath();
								{
									iCtx.MoveTo(-7,0); iCtx.LineTo(-50,0);
									iCtx.MoveTo(+7,0); iCtx.LineTo(+50,0);

									iCtx.LineWidth = 1;
									iCtx.Stroke();
								}
								
								//~~ pitch grid;

								if(iObj.Data.RAlt > 100)
								{
									iCtx.BeginPath();
									{
										for(var cA = +80; cA >= -80; cA -= 10)
										{
											var cY = -cA * _PitchStep;

											if(cA < 0)
											{
												iCtx.MoveTo(-7, cY + 1); for(var cX = -10; cX >= -_ScaleWidth; cX -= 6) iCtx.LineTo(cX, cY - 1), iCtx.LineTo(cX - 3, cY + 1);
												iCtx.MoveTo(+7, cY + 1); for(var cX = +10; cX <= +_ScaleWidth; cX += 6) iCtx.LineTo(cX, cY - 1), iCtx.LineTo(cX + 3, cY + 1);
											}
											else 
											{
												iCtx.MoveTo(-7, cY); iCtx.LineTo(-_ScaleWidth, cY);
												iCtx.MoveTo(+7, cY); iCtx.LineTo(+_ScaleWidth, cY);
											}

											if(_IsPrimaryIndicator)
											{
												iCtx.Save();
													iCtx.Translate(-_LabelOffs,cY);
													iCtx.Rotate(+_Data.Bank * DTR);
													iCtx.FillText(cA, 0, 0);
												iCtx.Restore();
												iCtx.Save();
													iCtx.Translate(+_LabelOffs,cY);
													iCtx.Rotate(+_Data.Bank * DTR);
													iCtx.FillText(cA, 0, 0);
												iCtx.Restore();
											}
										}
										iCtx.LineWidth = 0.5;
										iCtx.Stroke();
									}
								}
								
								//~~ flight path vector;
								var _Vel = iObj.Velocity.Linear; if(_Vel.Length > 10)
								{
									var _HrzVel  = Sqrt((_Vel.X * _Vel.X) + (_Vel.Y * _Vel.Y));
									var _VrtVel  = _Vel.Z;

									var _HrzA = Angle((_Data.Heading - _Data.HdgFix) * DTR, Atan2(_Vel.X, _Vel.Y));
									var _VrtA  = Atan2(_VrtVel, _HrzVel);

									iCtx.Save();
									iCtx.Translate((_HrzA * RTD) * _PitchStep, -(_VrtA * RTD) * _PitchStep);
									iCtx.BeginPath();
									{
										iCtx.MoveTo( -5, +2);
										iCtx.LineTo( -2, +2);
										iCtx.LineTo(  0,  0);
										iCtx.LineTo(  0, -2);

										iCtx.MoveTo(  0,  0);
										iCtx.LineTo( +2, +2);
										iCtx.LineTo( +5, +2);
									}
									iCtx.LineWidth = 1;
									iCtx.Stroke();
									iCtx.Restore();
								}
							}
							iCtx.Restore();

							//~~ messages;
							var _Alt = iObj.Position.Z;
							{
								if((_Alt < 500 && _Vel.Z < -10) || (_Alt < 35 && _Vel.Z < -3))
								{
									iCtx.GlobalAlpha = Date.Now.Millisecond % 1000 > 500 ? 1 : 0.2;
									iCtx.TextAlign = "center";
									iCtx.FontSize = "10%";
									iCtx.FillText("FLARE", 0, 40);
								}
							}
						 }
						
						iCtx.ZoomOut();
					}
					
				 },
				//'Accelerometer  : Indicator' :
				 //{
					//Draw : function(iCtx, iObj)
					//{
						//var _Acc = iObj.Data.Accelerometer; if(isNaN(_Acc.Length))
						//{
							//Indicator.Drawing.DrawError(iCtx, true);
							//return;
						//}

						//iCtx.ZoomIn(100);
						//{
							//iCtx.TextBaseline = "middle";
							//iCtx.TextAlign    = "center";

							//iCtx.GlobalAlpha  = 0.2;
							//iCtx.Font         = "75% tahoma";
							//iCtx.FillText("G", 50, 50);

							//iCtx.GlobalAlpha  = 1.0;
							//iCtx.Font         = "20% tahoma";
							//iCtx.FillText(_Acc.Z.ToString2(2), 50, 50);
						//}
						//iCtx.ZoomOut();
					//}
					
				 //},
				'Surfaces  : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						var _SS = iObj.Surfaces; if(isNaN(_SS.Rudder))
						{
							Indicator.Drawing.DrawError(iCtx, true);
							return;
						}

						iCtx.ZoomIn(100);
						//iCtx.Save();
						//iCtx.Translate(50,50);
						{
							//iCtx.BeginPath();
							//{
								//iCtx.MoveTo(0,0);
								//iCtx.LineTo(0,-10);

								//iCtx.MoveTo(0,0); iCtx.LineTo(-10,+20);
								//iCtx.MoveTo(0,0); iCtx.LineTo(+10,+20);
							//}
							//iCtx.LineWidth = 3;
							//iCtx.Stroke();


							iCtx.TextBaseline = "middle";
							iCtx.TextAlign    = "left";
							iCtx.Font         = "13% quartz";
							//iCtx.Font         = "13% courier";

							iCtx.FillText("ELE "  + _SS.Elevator.ToString2(1), 20,10);
							iCtx.FillText("AIL "  + _SS.Aileron.ToString2(1),  20,25);
							iCtx.FillText("RUD "  + _SS.Rudder.ToString2(1),   20,40);
							iCtx.FillText(" BF "  + _SS.Actuators.BodyFlap.CurrValue.ToFixed(1),   20,55);
							iCtx.FillText(" SB "  + _SS.Actuators.SpdBrake.CurrValue.ToFixed(1),   20,70);

							if(iObj.Control.Inputs.Balance < 1)
							{
								iCtx.FillText("ENG " + iObj.Engine.Factor.ToFixed(2), 20,85);
							}
						}
						//iCtx.Restore();
						iCtx.ZoomOut();
					}
					
				 },
				'Speeds         : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						var _IAS  = iObj.Data.IAS;
						var _MSpd = iObj.Data.MSpd;
						//var _MSpd = iObj.Velocity.Linear.Length  / 340;//.Data.MSpd;iObj.Velocity..Data.MSpd;
						{
							if(isNaN(_IAS))// || _IAS > 1000)
							{
								Indicator.Drawing.DrawError(iCtx);
								return;
							}
						}
						
						
						iCtx.ZoomIn(100);
						{
							Clock : 
							{
								if(_IAS < 250) break Clock;
								
								iCtx.Save();
								iCtx.Translate(50,50);
								iCtx.Rotate(-D090);
								{
									Zones:
									{
										var _Radius = 40, _FlashState = Date.Now.Millisecond > 500;//, _FrAng = -D090, _ToAng, 
										iCtx.LineWidth = 10; iCtx.GlobalAlpha = 0.5; iCtx.BeginPath();
										
										if(iObj.Data.BAlt > 500)
										{
											if(_FlashState == true || (_IAS >= 400 && _IAS <= 550))
											{
												iCtx.AddArc(0,0, _Radius, -50 * DTR, +30 * DTR);
											}
										}
										else
										{
											if(_FlashState == true || (_IAS >= 250 &&  _IAS <= 360))
											{
												iCtx.AddArc(0,0, _Radius, -120 * DTR, -70 * DTR);
											}
										}
										iCtx.Stroke();
									}
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
									Pointer : 
									{
										var _InR = 40, _OuR = 45;
										var _ArrAng = Scale(_IAS,400,600);
										
										iCtx.BeginPath(); 
										{
											iCtx.MoveTo(Cos(_ArrAng) * _InR, Sin(_ArrAng) * _InR);
											iCtx.LineTo(Cos(_ArrAng) * _OuR, Sin(_ArrAng) * _OuR);
										}
										iCtx.LineWidth = 10; 
										iCtx.GlobalAlpha = 1;
										iCtx.Stroke();
									}
								}
								iCtx.Restore();
							}
							Text : 
							{
								//iCtx.Font         = "20% lucida sans";
								iCtx.Font         = "20% quartz";

								iCtx.TextBaseline = "middle";
								iCtx.TextAlign    = "center";
								
								
								if(_IAS < 1000)
								{
									//iCtx.GlobalAlpha = 0.2;
									//iCtx.FontSize = "20%";
									//iCtx.FillText("IAS", 50, 75);
									
									iCtx.GlobalAlpha = 1;
									iCtx.FontSize = "25%";
									iCtx.FillText(Round(_IAS), 50, 45);
								}
								if(_MSpd >= 0.3)
								{
									//iCtx.Save();
									//iCtx.Translate(50,75);
									//iCtx.Scale(1,0.7);

									iCtx.GlobalAlpha = 1;
									iCtx.FontSize = "12%";
									iCtx.FillText(_MSpd.ToString2(3, false), 50, 65);

									//iCtx.Restore();
								}
							}
						}
						iCtx.ZoomOut();
					}
				 },
				'Altimeter      : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						var _Alt    = iObj.Data.BAlt;
						var _VSpd   = iObj.Data.VSpd;

						
						
						if(isNaN(_Alt) ||  _Alt < -1 || _Alt > 1e5)
						{
							Indicator.Drawing.DrawError(iCtx);
							return;
						}

						iCtx.ZoomIn(100);
						{
							Clock :
							{
								if(_Alt < 1000) break Clock;

								var _ArrAng = _Alt * (Math.PI * 2) / 100;

								iCtx.Save();
								iCtx.Translate(iCtx.W / 2, iCtx.H / 2);
								iCtx.BeginPath();
								{
									var _InR = 45, _OuR = 49;

									iCtx.MoveTo(Math.Sin(_ArrAng) * _InR, Math.Cos(_ArrAng + Math.PI) * _InR);
									iCtx.LineTo(Math.Sin(_ArrAng) * _OuR, Math.Cos(_ArrAng + Math.PI) * _OuR);

									iCtx.MoveTo(Math.Sin(_ArrAng) * _InR, Math.Cos(_ArrAng + Math.PI) * _InR);
									iCtx.LineTo(Math.Sin(_ArrAng) * _OuR, Math.Cos(_ArrAng + Math.PI) * _OuR);

									iCtx.LineWidth = 10;
									iCtx.Stroke();
								}
								iCtx.Restore();
							}
							Text :
							{
								//iCtx.Font = "20% lucida sans";
								iCtx.Font = "20% quartz";
								iCtx.TextBaseline = "middle";

								if(_Alt > 0)
								{
									if(_Alt >= 1000 && _Alt < 100000)
									{
										var _KMeters = Math.Floor(_Alt / 1000);
										var _Meters  = Math.Floor(_Alt - (_KMeters * 1000));
										{
											if(_Meters < 100) _Meters = "0" + _Meters;
											if(_Meters < 10)  _Meters = "0" + _Meters;
										}

										iCtx.TextAlign = "right";

										iCtx.FontSize = "30%";
										iCtx.FillText(_KMeters, 50, 50);

										iCtx.FontSize = "20%";
										iCtx.FillText(_Meters, 90, 50);
									}
									else if(_Alt < 1000)
									{
										iCtx.TextAlign    = "left";
										iCtx.FillText("R", 10, 50);

										iCtx.TextAlign    = "right";
										iCtx.FillText(_Alt.ToString2(3,false), 90, 50);
									}
									else
									{
										//~~ ;
									}



									if(Abs(_VSpd) > 0.1)
									{
										iCtx.TextAlign = "center";
										iCtx.FontSize = "14%";
										iCtx.FillText(_VSpd.ToString2(), 50, 75);
									}
								}
								else
								{
									
									iCtx.TextAlign = "center";
									iCtx.FillText("GND", 50, 50);
								}
							}
						}
						iCtx.ZoomOut();
					}
				 },
				'Situation      : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						if(isNaN(iObj.Position.X))
						{
							Indicator.Drawing.DrawError(iCtx);
							return;
						}
						
						var _VehAtt    = iObj.Data.Attitude;
						var _VehPos    = iObj.Position.Set(null,null,0);

						var _AipDist   = _VehPos.Length;
						var _AipDir    = (Atan2(-_VehPos.X, _VehPos.Y) * RTD) - _VehAtt.HdgFix;

						var _ToAipTrk  = _AipDir + _VehAtt.Heading;
						var _RnwTrkA   = (_VehAtt.Heading - _VehAtt.HdgFix) * DTR;
						
						iCtx.ZoomIn(100);
						iCtx.Translate(50,50);
						{
							Vehicle:
							{
								var _RwPos = Clamp01(Scale01(_AipDist, 0, 3000));
								//if(_AipDist < 1000) break Direction;

								iCtx.Save();
								iCtx.Translate(-Sin(_ToAipTrk * DTR) * _RwPos * 43, -Cos(_ToAipTrk * DTR) * _RwPos * 43);
								{
									iCtx.BeginPath();
									
									iCtx.MoveTo(0,-7);
									iCtx.LineTo(7,7);
									iCtx.LineTo(-7,7);
									//iCtx.LineTo(0,-10);
									iCtx.ClosePath();

									//iCtx.LineWidth = 2;
									//iCtx.Stroke();
									iCtx.Fill();
								}
								iCtx.Restore();
							}
							Runway :
							{
								if(_AipDist > 100000) break Runway;
								{
									iCtx.BeginPath();
									
									var _PerspF = 0.5, cA,cD, cxA,cyA,  cX,cY;
									{
										cA = _RnwTrkA;
										cD = (Cos(cA) / 2 + 0.5) * _PerspF;

										cxA = cA      - 0.01 - cD; iCtx.MoveTo(+Sin(cxA) * 40, +Cos(cxA) * 40);
										cyA = cA      + 0.01 + cD; iCtx.LineTo(+Sin(cyA) * 40, +Cos(cyA) * 40);


										cA = _RnwTrkA + PI;
										cD = (Cos(cA) / 2 + 0.5) * _PerspF;

										cxA = cA - 0.01 - cD; iCtx.LineTo(+Sin(cxA) * 40, +Cos(cxA) * 40);
										cyA = cA + 0.01 + cD; iCtx.LineTo(+Sin(cyA) * 40, +Cos(cyA) * 40);
									}
									
									iCtx.ClosePath();

									//iCtx.MoveTo(Sin(_RnwTrkA) * _InR, Cos(_RnwTrkA) * _InR);
									//iCtx.LineTo(Sin(_RnwTrkA) * _OuR, Cos(_RnwTrkA) * _OuR);

									iCtx.LineWidth = 10;
									iCtx.GlobalAlpha = 0.5;

									//iCtx.Stroke();
									iCtx.Fill();
								}
							}
							Localizer:
							{
								if(_AipDist < 1000 || _AipDist > 50000) break Localizer;
								
								//var _LatErr = Clamp(Scale(_VehPos.X * Sign(_VehPos.Y), 3000));
								var _LatErr = Magic(Clamp(Scale(_VehPos.X / _VehPos.Y, 0.20)), 1.4);

								

								iCtx.BeginPath();
								
								iCtx.MoveTo(_LatErr * 43,-20); iCtx.LineTo(_LatErr * 43,-40);
								iCtx.MoveTo(_LatErr * 43,+20); iCtx.LineTo(_LatErr * 43,+40);

								iCtx.LineWidth = Abs(_LatErr) >= 1 && Date.Now.Millisecond > 500 ? 4 : 2;
								iCtx.GlobalAlpha = 1;
								//iCtx.
								//iCtx.S
								iCtx.Stroke();
							}
							Glideslope:
							{
								//if(_AipDist < 3000 || _AipDist > 30000) break Glideslope;
								if(_AipDist < 3000) break Glideslope;
								
								var _VrtErr = Clamp(Scale((iObj.Data.BAlt / Tan(20 * DTR)) / (_AipDist - 3200), 1) - 1);

								iCtx.BeginPath();

								iCtx.MoveTo(-21, _VrtErr * 43); iCtx.LineTo(-40, _VrtErr * 43);
								iCtx.MoveTo(+21, _VrtErr * 43); iCtx.LineTo(+40, _VrtErr * 43);

								iCtx.LineWidth = Abs(_VrtErr) >= 1 && Date.Now.Millisecond > 500 ? 4 : 2;
								iCtx.GlobalAlpha = 1;

								iCtx.Stroke();
							}
							
							Text :
							{
								if(_AipDist < 3000) break Text;

								//iCtx.Font = "20% lucida sans";
								iCtx.Font = "20% quartz";
								iCtx.TextAlign = "center";
								iCtx.TextBaseline = "middle";
								
								if(_AipDist < 100000)
								{
									iCtx.FillText((_AipDist / 1000).ToString2(1,false), 0, 0);
								}
								else
								{
									iCtx.FillText(Math.Round(_AipDist / 1000), 0, 0);
								}
							}
						}
						iCtx.ZoomOut();

						//iCtx.Translate(iCtx.W / 2, iCtx.H / 2);
						//{
							
						//}
						//iCtx.ZoomOut();
						//iCtx.Restore();
						
						
						
					}
				 },
				'Misc1          : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						var _Att = iObj.Data.Attitude; if(isNaN(_Att.Pitch * _Att.Bank * _Att.Heading))
						{
							Indicator.Drawing.DrawError(iCtx, true);
							return;
						}

						iCtx.ZoomIn(100);
						{
							//iCtx.TextBaseline = "middle";
							//iCtx.TextAlign    = "left";
							//iCtx.Font         = "15% courier";
							iCtx.Font         = "15% quartz";

							iCtx.FillText("G   " + iObj.Data.Accelerometer.Z.ToString2(2), 10, 20);
							iCtx.FillText("AoA " + (iObj.Data.IAS > 10 ? iObj.Data.AoA.ToString2(2) : "--"), 10, 35);
							
							//iCtx.TextBaseline = "top";
							//iCtx.TextAlign    = "left";
							iCtx.Font         = "10% courier";

							iCtx.FillText("Pit = " + _Att.Pitch   .ToString2(), 13, 60);
							iCtx.FillText("Bnk = " + _Att.Bank    .ToString2(), 13, 70);
							iCtx.FillText("Hdg = " + _Att.Heading .ToString2(), 13, 80);
						}
						iCtx.ZoomOut();
					}
					
				 },
				'Inputs          : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						var _CPit = iObj.Cockpit;
						var _AupF = iObj.Control.Inputs.Balance;

						iCtx.ZoomIn(100);
						{
							//iCtx.TextBaseline = "middle";
							//iCtx.TextAlign    = "left";
							iCtx.Font         = "12% courier";

							iCtx.FillText(_AupF == 0 ? "MANUAL" : _AupF == 1 ? "A/P" : "MAN-AP " + _AupF.ToFixed(2), 10, 20);

							
							//iCtx.FillText("AoA    " + (iObj.Data.IAS > 10 ? iObj.Data.AoA.ToString2(2) : "--"), 10, 25);
							
							//iCtx.TextBaseline = "top";
							//iCtx.TextAlign    = "left";

							if(_AupF != 1)
							{
								//iCtx.Font         = "12% courier";
								iCtx.Font         = "12% quartz";
								//iCtx.FillText("AttRates: ", 13, 45);

								iCtx.Font         = "10% courier";
								iCtx.FillText("X = " + _CPit.AttRates.X.ToFixed(2), 13, 60);
								iCtx.FillText("Y = " + _CPit.AttRates.Y.ToFixed(2), 13, 70);
								iCtx.FillText("Z = " + _CPit.AttRates.Z.ToFixed(2), 13, 80);
							}
						}
						iCtx.ZoomOut();
					}
					
				 },
				
				'Autopilot      : Indicator' :
				 {
					Draw : function(iCtx, iObj)
					{
						//this.overriden.Draw(arguments);

						iCtx.ZoomIn(0,0.01);
						{
							iCtx.Font         = "15% courier";
							iCtx.TextAlign    = "left";
							iCtx.TextBaseline = "top";

							iCtx.Save();
							{
								iCtx.Translate(10,0);
							}
							iCtx.Restore();
						}
						iCtx.ZoomOut();
					}
				 },
			 }
		 }
	},
});