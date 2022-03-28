"use strict";

stuff
({
	uses :
	[
		'Math',
		'System.Data',
		'System.Drawing',
	],
	
	'UVS.Imaging' : 
	 {
		'ApproachDiagram : GraphicsLayer' :
		 {
			VymData : obj('TimeSeries.Set'),
			SimData : obj('TimeSeries.Set'),
			//UpdateInt

			//SrcSeries : 
			//Series    : obj('TimeSeries.Set'),
			Cursor    : num(0),

			PrepareContext   : function()
			 {
				var oCtx = this.Context;
				{
					oCtx.W = 2125;
					oCtx.H = 1200;

					var _ScaleF = this.Canvas.width / oCtx.W;
					{
						oCtx.H = this.Canvas.height / _ScaleF;
						oCtx.SetTransform(_ScaleF, 0,0, _ScaleF, 0,0);
					}

					oCtx.LineWidth    = 2;
					oCtx.GlobalAlpha  = 1;
					oCtx.Font = "20px courier";

					oCtx.Clear();
				}
				return oCtx;
			 },
			UpdateBackground : function()
			 {
				var _Ctx = this.PrepareContext();
				
				ApproachDiagram.Drawing.Background(this.Context);


				_Ctx.FillStyle   = "#333333";
				_Ctx.StrokeStyle = "rgba(255,255,255,0.2)";

				_Ctx.LineWidth   = 1;

				//_Ctx.ClearRect(0,0,_Ctx.W,_Ctx.H);
				//_Ctx.FillRect(100,100,300,200);

				

				ApproachDiagram : 
				{
					_Ctx.Translate(25,25);

					_Ctx.StrokeStyle  = "#ffffff";
					_Ctx.FillStyle    = "#ffffff";

					_Ctx.LineWidth    = 2;
					_Ctx.GlobalAlpha  = 1;
					_Ctx.Font         = "20px courier"; 

					//ApproachDiagram.Drawing.ApproachDiagram.Border     (this.Context);
					ApproachDiagram.Drawing.Graph.Grid       (this.Context);
					ApproachDiagram.Drawing.Graph.Scales     (this.Context);
					
					//_Ctx.LineWidth    = 1;
					_Ctx.GlobalAlpha  = 0.7;
					ApproachDiagram.Drawing.Graph.Batch      (this.Context, this.VymData, this.Cursor, 1);
				}

				
			 },
			UpdateForeground : function()
			 {
				if(gMouse.B3) this.Cursor = Clamp(this.Cursor + Floor((gMouse.DX / window.innerWidth) * this.SimData.Entries.Length), 0, this.SimData.Entries.Length);

				//this.Cursor = Floor((gMouse.X / window.innerWidth) * this.Series.Entries.Length);
				//var _Entry = this.Series.Entries[this.Cursor];//10];
			
				var _Ctx = this.PrepareContext();
	
				ApproachDiagram : 
				{
					_Ctx.Translate(25,25);

					//_Ctx.StrokeStyle  = "#0000a0";
					//_Ctx.FillStyle    = "#0000a0";

					_Ctx.StrokeStyle  = "#ffffff";
					//_Ctx.FillStyle    = "#ffffff";

					
					//_Ctx.Font         = "20px courier"; 
					_Ctx.GlobalAlpha = 1;
					_Ctx.LineWidth   = 2;

					ApproachDiagram.Drawing.Graph.Batch      (this.Context, this.SimData, this.Cursor);
				}

				if(this.SimData.Entries.Length > 0)
				{
					PrimaryInstruments : 
					{
						//break PrimaryInstruments;
						//if(this.Series.Entries.Length == 0)

						var _Value = this.SimData.Entries[this.Cursor].Value;//10];

						_Ctx.Translate(1550,50);
						_Ctx.StrokeStyle = "#ffaaaa";
						_Ctx.GlobalAlpha = 1;
						_Ctx.LineWidth   = 1;

						_Ctx.BeginPath();
						_Ctx.AddRect(0,0,500,400, 10);
						_Ctx.Stroke();

						_Ctx.StrokeStyle = "#ffffff";
						_Ctx.FillStyle   = "#ffffff";
						
						ApproachDiagram.Drawing.Indicators.TSData    (_Ctx, _Value,  10, -25);
						ApproachDiagram.Drawing.Indicators.Attitude  (_Ctx, _Value, 250, 150);
						ApproachDiagram.Drawing.Indicators.Speeds    (_Ctx, _Value,   0,  50);
						ApproachDiagram.Drawing.Indicators.Verticals (_Ctx, _Value, 375,  50);
						ApproachDiagram.Drawing.Indicators.Position  (_Ctx, _Value,  10,  275);
						
					}
					SecondaryInstruments : 
					{
						_Ctx.Translate(0,450);
						_Ctx.StrokeStyle = "#ffaaaa";
						_Ctx.GlobalAlpha = 1;
						_Ctx.LineWidth   = 1;

						_Ctx.StrokeRect(0,0,500,550);

						//ApproachDiagram.Drawing.ApproachDiagram.Grid(this.Context);
					}
				}
			 },


			static : 
			{
				Drawing : 
				{
					Background   : function(iCtx)
					 {
						//return;
						//var _

						//iCtx.FillStyle   = "#fffffa";
						//iCtx.StrokeStyle = "#aa3300";

						//iCtx.ClearRect(0, 0, iCtx.W, iCtx.H);

						iCtx.Clear();
						iCtx.FillStyle = "rgba(0,0,0,1)";
						iCtx.FillRect(0,0,iCtx.W,iCtx.H);
						iCtx.StrokeStyle = "rgba(50,50,50,1)";
						iCtx.LineWidth = 3;
						//iCtx.FillStyle = "#333333";
						//iCtx.FillRect(0, 0, iCtx.W, iCtx.H);
						

						//iCtx.GlobalAlpha = 0.5;
						//return;

						Grid1 :
						{
							break Grid1;

							iCtx.BeginPath();
							{
								for(var cX = 0;  cX <  iCtx.W;    cX += 5){iCtx.MoveTo(cX,0); iCtx.LineTo(cX,iCtx.H - 0);}
								for(var cY = 0; cY <= iCtx.H - 0; cY += 5){iCtx.MoveTo(0,cY); iCtx.LineTo(iCtx.W,cY);}
							}
							//iCtx.LineWidth   = 0.1;
							iCtx.Stroke();
						}
						Grid2 :
						{
							//break Grid2;

							iCtx.BeginPath();
							{
								for(var cX = 0; cX < iCtx.W; cX += 25){iCtx.MoveTo(cX,0); iCtx.LineTo(cX,iCtx.H);}
								for(var cY = 0; cY < iCtx.H; cY += 25){iCtx.MoveTo(0,cY); iCtx.LineTo(iCtx.W,cY);}
							}
							iCtx.LineWidth   = 1;
							iCtx.Stroke();
						}
						Grid3 :
						{
							break Grid3;

							iCtx.BeginPath();
							{
								for(var cX = -25; cX < iCtx.W; cX += 50){iCtx.MoveTo(cX,0); iCtx.LineTo(cX,iCtx.H);}
								for(var cY = -25; cY < iCtx.H; cY += 50){iCtx.MoveTo(0,cY); iCtx.LineTo(iCtx.W,cY);}
							}
							iCtx.LineWidth   = 2;
							iCtx.Stroke();
						}
						Grid4 :
						{
							break Grid4;

							iCtx.BeginPath();
							{
								for(var cX = +25; cX < iCtx.W; cX += 100){iCtx.MoveTo(cX,0); iCtx.LineTo(cX,iCtx.H);}
								for(var cY = -25; cY < iCtx.H; cY += 100){iCtx.MoveTo(0,cY); iCtx.LineTo(iCtx.W,cY);}
							}
							iCtx.LineWidth   = 3;
							iCtx.Stroke();
						}
						
						//iCtx.FillStyle = "#ff0000";

						//var _Gradient = iCtx.CreateLinearGradient(0, -0.5, 0, 0.5);
						//{
							////_Gradient.AddColorStop(0, (iFrame.Parent && iFrame.Parent.BackColor.AsString) || "#ffffff");
							//_Gradient.AddColorStop(0.0, "#00ccff");
							//_Gradient.AddColorStop(0.5,  "#ffffff");
							////_Gradient.AddColorStop(0.5, "#000000");
							//_Gradient.AddColorStop(1.0, "#66cc00");
						//}
						//iCtx.FillStyle   = _Gradient;

						//iCtx.FillRect(-1,-1,2,2);
					 },
					
					Graph : 
					{
						Border       : function(iCtx)
						 {
							iCtx.BeginPath();
							iCtx.AddRect(0,0,1550,1150,10);
							iCtx.Stroke();
						 },
						//Title        : function(iCtx)
						 //{
							
						 //},
						Grid         : function(iCtx)
						 {
							iCtx.Save();
							//iCtx.Translate(180,30);
							iCtx.Translate(300,50);

							iCtx.TextAlign = "left";
							iCtx.FillText("Z", -25, -25);
							iCtx.FillText("X", 1100, 1050);

							iCtx.BeginPath();
							{
								this.Marks.TriangleT(iCtx, -50, -25);
								iCtx.Stroke();
							}
							
							
							
						
							iCtx.BeginPath();
							{
								iCtx.AddRect(0,0,1100,1000);
								iCtx.AddRect(0,0,1100,1000);

								iCtx.TextAlign = "left"; for(var cX,Xi = 0; cX = Xi * 100, Xi <= 11; Xi++)
								{
									iCtx.MoveTo(cX,  0); iCtx.LineTo(cX, 1000 + 10);
									iCtx.FillText(-(Xi - 5) * 4000, cX + 3, 1020);
								}
								iCtx.TextAlign = "right"; for(var cY,Yi = 0; cY = Yi * 100, Yi <= 10; Yi++)
								{
									iCtx.MoveTo(-5, cY); iCtx.LineTo(1100, cY);
									Yi <= 7 && iCtx.FillText(-(Yi - 5) * 4000, -5, cY);
								}
								//for(var cX = 0;  cX <= 660; cX += 60){iCtx.MoveTo(cX,   0);     iCtx.LineTo(cX, 600 + 5);}
								//for(var cY = 0;  cY <= 600; cY += 60){iCtx.MoveTo(- 5, cY);     iCtx.LineTo(660, cY);}
								
								//for(var cX = 30; cX <= 620; cX += 60){iCtx.MoveTo(cX,  600);    iCtx.LineTo(cX, 600 + 5);}
								//for(var cY = 30; cY <= 570; cY += 60){iCtx.MoveTo(-5, cY);      iCtx.LineTo(0,  cY);}
							}
							iCtx.GlobalAlpha = 0.2;
							iCtx.Stroke();

							iCtx.BeginPath();
							{
								iCtx.AddRect  (440,497,120,6); //~~ Landing strip;
								//iCtx.Stroke();
								//iCtx.MoveTo();

								//~~ HACs;
								iCtx.AddCircle(125,350,150);
								iCtx.AddCircle(125,650,150);
								iCtx.AddCircle(875,350,150);
								iCtx.AddCircle(875,650,150);

								//iCtx.AddCircle(-125,500,625);
								//iCtx.Clip(0,0,300,300);
								//iCtx.MoveTo(500,500); iCtx.AddArc(-125,500,625, 0,      -1, true);
								//iCtx.MoveTo(500,500); iCtx.AddArc(-125,500,625, 0,      +1, false);
								//iCtx.MoveTo(500,500); iCtx.AddArc(1125,500,625, PI, PI + 1, false);
								//iCtx.MoveTo(500,500); iCtx.AddArc(1125,500,625, PI, PI - 1, true);

								iCtx.MoveTo(275,25);  iCtx.LineTo(375,125);
								iCtx.MoveTo(275,975); iCtx.LineTo(375,875);

								iCtx.MoveTo(725,25);  iCtx.LineTo(625,125);
								iCtx.MoveTo(725,975); iCtx.LineTo(625,875);
								//iCtx.AddArc(-125,500,625,0,+0.8);

								
								

								//iCtx.AddCircle(1125,500,625);
								

								//iCtx.AddCircle(1125,500,625);
								//iCtx.AddCircle(-125,500,625);

								
								iCtx.StrokeStyle = "#666666";
								iCtx.GlobalAlpha = 1;
								iCtx.Stroke();

								iCtx.FontSize = "50px";
								iCtx.TextAlign = "center";
								iCtx.TextBaseline = "middle";
								iCtx.GlobalAlpha = 0.2;
								

								iCtx.FillText("NW", 125, 350);
								iCtx.FillText("SW", 125, 650);
								iCtx.FillText("NE", 875, 350);
								iCtx.FillText("SE", 875, 650);
							}

							iCtx.GlobalAlpha = 1;
							iCtx.Restore();
						 },
						Scales       : function(iCtx)
						 {
							iCtx.FillText("B U R A N  ORBITER DESCENT AND LANDING DIAGRAM  15.11.88  .", 400, 25);
							//iCtx.FillText("ТРАЕКТОРИЯ СПУСКА И ПОСАДКИ ОРБИТАЛЬНОГО КОРАБЛЯ  Б У Р А Н  15.11.88  .", 400, 25);

							HM : 
							 {
								iCtx.BeginPath();
								{
									//X : iCtx.TextAlign = "left";  iCtx.FillText("X", 840,660); for(var cX = -5; cX <= 6; cX++) iCtx.FillText(-cX * 4000, 180 + ((cX + 5) * 60), 643);
									//Z : iCtx.TextAlign = "right"; iCtx.FillText("Z", 83, ); for(var cZ = -2; cZ <= 5; cZ++) iCtx.FillText(+cZ * 4000, 175, 150 + ((-cZ + 3) * 60));
									H :
									{
										iCtx.Save();
										iCtx.Translate(100,50);
										{
											iCtx.TextAlign = "right";
											iCtx.FillText("H", -10, -25);
							
											iCtx.BeginPath();
											{
												this.Marks.PlusSign(iCtx, -50, -25);

												iCtx.MoveTo(0, 0);
												iCtx.LineTo(0, 1000);
												
												for(var cY,Yi = 0; cY = 1000 - (Yi * 100), Yi <= 10; Yi++)
												{
													iCtx.MoveTo(-4, cY); iCtx.LineTo(0, cY);
													iCtx.FillText((Yi * 2000) + ".0", -6, cY);
												}
											}
											iCtx.Stroke();
										}
										iCtx.Restore();
									}
									M : 
									{
										iCtx.Save();
										iCtx.Translate(300, 850);
										{
											iCtx.BeginPath();
											this.Marks.DotSign(iCtx, -50, -25);
											iCtx.Stroke();
											iCtx.TextAlign = "right";
											iCtx.FillText("M",   -10, -25);
											iCtx.FillText("0.8", -7,    0);
											iCtx.FillText("0.4", -7,  100);
											iCtx.FillText("0.0", -7,  200);
										}
										iCtx.Restore();
									}
									//for(var cY =  30; cY <= 630; cY += 60){iCtx.MoveTo(180, cY); iCtx.LineTo(840, cY);}
								}
								iCtx.Stroke();
							 }
							AoA  :
							{
								//iCtx.Save();
								//iCtx.Translate(200, 50);
								//{
									//iCtx.TextAlign = "right";
									////iCtx.FillText("AoA", -10, 50);
									//iCtx.FillText("AoA", 0, -25);
									
									//iCtx.BeginPath();
									//{
										//this.Marks.Cross(iCtx, -50, -25);

										//iCtx.MoveTo(0, 0);
										//iCtx.LineTo(0, 200);

										//iCtx.MoveTo(0,   0); iCtx.LineTo(-5,   0); iCtx.FillText("10.0", -8,  0);
										//iCtx.MoveTo(0,  50); iCtx.LineTo(-5,  50);
										//iCtx.MoveTo(0, 100); iCtx.LineTo(-5, 100); iCtx.FillText("5.0", -8,  100);
										//iCtx.MoveTo(0, 150); iCtx.LineTo(-5, 150);
										//iCtx.MoveTo(0, 200); iCtx.LineTo(-5, 200); iCtx.FillText("0.0",  -8,  200);
										////iCtx.MoveTo(0, 250); iCtx.LineTo(-5, 250); iCtx.FillText("  0.0", -8,  250);
									//}
									//iCtx.Stroke();
								//}
								//iCtx.Restore();
							}
							Slip  :
							{
								//iCtx.Save();
								//iCtx.Translate(200, 350);
								//{
									//iCtx.TextAlign = "right";
									//iCtx.FillText("Slip", 0,-25);
									
									//iCtx.BeginPath();
									//{
										//this.Marks.Cross(iCtx, -65, -25);

										//iCtx.MoveTo(0, 0);
										//iCtx.LineTo(0, 200);

										//iCtx.MoveTo(0,   0); iCtx.LineTo(-5,   0); iCtx.FillText("+10", -8,  0);
										//iCtx.MoveTo(0,  50); iCtx.LineTo(-5,  50);
										//iCtx.MoveTo(0, 100); iCtx.LineTo(-5, 100); iCtx.FillText("0", -8,  100);
										//iCtx.MoveTo(0, 150); iCtx.LineTo(-5, 150);
										//iCtx.MoveTo(0, 200); iCtx.LineTo(-5, 200); iCtx.FillText("-10", -8,  200);
										////iCtx.MoveTo(0, 250); iCtx.LineTo(-5, 250); iCtx.FillText("  0.0", -8,  250);
									//}
									//iCtx.Stroke();
								//}
								//iCtx.Restore();
							}
							IAS  : 
							 {
								iCtx.Save();
								iCtx.Translate(200, 800);
								{
									iCtx.TextAlign = "right";
									iCtx.FillText("IAS", 0,-25);
									
									iCtx.BeginPath();
									{
										this.Marks.Cross(iCtx, -50, -25);

										iCtx.MoveTo(0, 0);
										iCtx.LineTo(0, 250);

										iCtx.MoveTo(0,   0); iCtx.LineTo(-5,   0);
										iCtx.MoveTo(0,  50); iCtx.LineTo(-5,  50); iCtx.FillText("400.0", -8,  50);
										iCtx.MoveTo(0, 100); iCtx.LineTo(-5, 100);
										iCtx.MoveTo(0, 150); iCtx.LineTo(-5, 150); iCtx.FillText("200.0", -8,  150);
										iCtx.MoveTo(0, 200); iCtx.LineTo(-5, 200);
										iCtx.MoveTo(0, 250); iCtx.LineTo(-5, 250); iCtx.FillText("  0.0", -8,  250);
									}
									iCtx.Stroke();
								}
								iCtx.Restore();
							 }
							VS :
							 {
								iCtx.Save();
								iCtx.Translate(1500, 50);
								{
									iCtx.TextAlign = "right";

									iCtx.FillText("VS", 0,-25);
									

									
									

									iCtx.BeginPath();
									{
										this.Marks.Cross(iCtx, -50, -25);

										iCtx.MoveTo(0,0);  iCtx.LineTo(0,200);

										iCtx.MoveTo(0,0);   iCtx.LineTo(-5,0);   iCtx.FillText(" 0.0", -8,0);
										iCtx.MoveTo(0,100); iCtx.LineTo(-5,100); iCtx.FillText("-50", -8,100);
										iCtx.MoveTo(0,200); iCtx.LineTo(-5,200); iCtx.FillText("-100", -8,200);
									}
									iCtx.Stroke();
								}
								iCtx.Restore();
							 }
							
							Bank : 
							 {
								iCtx.Save();
								iCtx.Translate(1500, 350);
								{
									iCtx.TextAlign = "right";

									iCtx.FillText("Bank", 0,-25);

									iCtx.FillText("+40", -8,0);
									iCtx.FillText("  0", -8,100);
									iCtx.FillText("-40", -8,200);

									iCtx.BeginPath();
									{
										this.Marks.TriangleB(iCtx, -65, -25);
										iCtx.MoveTo(0,  0); iCtx.LineTo( 0,200);

										iCtx.MoveTo(0,  0); iCtx.LineTo(-5,  0);
										iCtx.MoveTo(0, 50); iCtx.LineTo(-5, 50);
										iCtx.MoveTo(0,100); iCtx.LineTo(-5,100);
										iCtx.MoveTo(0,150); iCtx.LineTo(-5,150);
										iCtx.MoveTo(0,200); iCtx.LineTo(-5,200);
									}
									iCtx.Stroke();
								}
								iCtx.Restore();
							 }
							SpdB : 
							 {
								iCtx.Save();
								iCtx.Translate(1500, 850);
								{
									iCtx.TextAlign = "right";

									iCtx.FillText("SpdB", 0,-25);

									iCtx.FillText("80", -8, 0);
									iCtx.FillText("40", -8, 100);
									iCtx.FillText(" 0", -8, 200);

									iCtx.BeginPath();
									{
										this.Marks.TriangleR(iCtx, -65, -25);

										iCtx.MoveTo(0,  0); iCtx.LineTo( 0,200);

										iCtx.MoveTo(0,  0); iCtx.LineTo(-5,  0);
										iCtx.MoveTo(0, 50); iCtx.LineTo(-5, 50);
										iCtx.MoveTo(0,100); iCtx.LineTo(-5,100);
										iCtx.MoveTo(0,150); iCtx.LineTo(-5,150);
										iCtx.MoveTo(0,200); iCtx.LineTo(-5,200);
									}
									iCtx.Stroke();
								}
								iCtx.Restore();
							 }
						 },

						//ScaleXZ : function(iCtx)
						 //{
							
						 //},
						Marks        : 
						 {
							TriangleT : function(iCtx, iX, iY)
							 {
								iCtx.MoveTo(iX,     iY - 3);

								iCtx.LineTo(iX + 3, iY + 3);
								iCtx.LineTo(iX - 3, iY + 3);
								iCtx.LineTo(iX,     iY - 3);
							 },
							TriangleB : function(iCtx, iX, iY)
							 {
								iCtx.MoveTo(iX,     iY + 3);

								iCtx.LineTo(iX - 3, iY - 3);
								iCtx.LineTo(iX + 3, iY - 3);
								iCtx.LineTo(iX,     iY + 3);
							 },
							TriangleL : function(iCtx, iX, iY)
							 {
								iCtx.MoveTo(iX - 3, iY);

								iCtx.LineTo(iX + 3, iY - 3);
								iCtx.LineTo(iX + 3, iY + 3);
								iCtx.LineTo(iX - 3, iY);
							 },
							TriangleR : function(iCtx, iX, iY)
							 {
								iCtx.MoveTo(iX + 3, iY);

								iCtx.LineTo(iX - 3, iY - 3);
								iCtx.LineTo(iX - 3, iY + 3);
								iCtx.LineTo(iX + 3, iY);
							 },
							PlusSign  : function(iCtx, iX, iY)
							 {
								iCtx.MoveTo(iX,     iY - 6);
								iCtx.LineTo(iX,     iY + 6);

								iCtx.MoveTo(iX - 6,     iY);
								iCtx.LineTo(iX + 6,     iY);
								//iCtx.MoveTo(
							 },
							
							Cross     : function(iCtx, iX, iY)
							 {
								iCtx.MoveTo(iX - 6, iY - 6);
								iCtx.LineTo(iX + 6, iY + 6);

								iCtx.MoveTo(iX - 6, iY + 6);
								iCtx.LineTo(iX + 6, iY - 6);
							 },
							BigCross     : function(iCtx, iX, iY)
							 {
								iCtx.MoveTo(iX - 10, iY - 10);
								iCtx.LineTo(iX + 10, iY + 10);

								iCtx.MoveTo(iX - 10, iY + 10);
								iCtx.LineTo(iX + 10, iY - 10);
							 },
							DotSign   : function(iCtx, iX, iY)
							 {
								//~~ Dot;
								iCtx.AddRect(iX - 2, iY - 2, 4, 4);
							 },
						 },

						Batch        : function(iCtx, iSeries, iCursorI, iDetL)
						 {
							if(iDetL == undefined) iDetL = 1;

							var fDrawGraph = function(iField, iColor, iStyle, iOffs, iMult)
							{
								var _IsPosV = iField == "X" || iField == "Z";//.StartsWith("Position");
								
								iCtx.BeginPath();
								{
									//for(var cV,Vi = 0; cV = iVV[Vi], Vi < iVV.Length; Vi++)
									var _LastMarkX = 0, _LastMarkY = 0;

									for(var _EE = iSeries.Entries, cE,Ei = 0; cE = _EE[Ei], Ei < _EE.Length; Ei += 1 / iDetL)
									{
										var cV = cE.Value;

										var cX = cV.Position.Y / 40;
										var cY = iOffs + ((_IsPosV ? cV.Position[iField] : cV[iField]) * iMult);

										if(cY == undefined) continue;
										
										iCtx.LineTo(cX,cY);

										if(Abs(cX - _LastMarkX) > 100 || Abs(cY - _LastMarkY) > 100)
										{
											ApproachDiagram.Drawing.Graph.Marks[iStyle](iCtx, cX, cY);
											_LastMarkX = cX, _LastMarkY = cY;
										}

										if(Ei == iCursorI)
										{
											ApproachDiagram.Drawing.Graph.Marks["BigCross"](iCtx, cX, cY);
											iCtx.MoveTo(cX,cY);
											//_LastMarkX = cX, _LastMarkY = cY;
										}
										
									}
									
								}
								iCtx.StrokeStyle = iColor;
								iCtx.Stroke();
							}

							iCtx.Save();
							iCtx.Translate(800, 550);
							{
								fDrawGraph("X",     "#00ff00", "TriangleT",    0,  +0.025);
								fDrawGraph("Z",     "#00ccff", "TriangleT", +500,  -0.050);
								
								fDrawGraph("MSpd",  "#ff6666", "TriangleT", +500,    -250);
								fDrawGraph("IAS",   "#ffff00", "TriangleT", +500,    -0.5);

								fDrawGraph("Vel",   "#ffffff", "TriangleT", +500,    -1.0);
								
								fDrawGraph("VSpd",  "#ff6666", "TriangleT", -500,    -2.0);
								fDrawGraph("VSpd2", "#ffff00", "TriangleT", -500,    -2.0);
								

								fDrawGraph("Bank",  "#ffaaff", "TriangleT", -100,    -2.5);
								fDrawGraph("SpdB",  "#ffaaff", "TriangleT", +500,    -2.5);

								//_DrawGraph("FiEng",      "#aaaaaa", "TriangleT",    0,    -100);
							}
							iCtx.Restore();
						 }
					},
					
					Indicators : 
					{
						Attitude  : function(iCtx, iValue, iX, iY)
						 {
							iCtx.Save();
							iCtx.Translate(iX,iY);
							iCtx.StrokeRect(-100, -100, 200, 200);
							iCtx.StrokeRect(-1, -1, 2, 2);

							iCtx.BeginPath();
							iCtx.AddArc(0,0,110, D180 + (D090 / 2), -D090 / 2);
							iCtx.LineWidth = 10;
							//iCtx.StrokeStyle = "#ffffff";
							iCtx.Stroke();

							

							iCtx.BeginPath();
							{
								iCtx.MoveTo(0,-100);
								iCtx.LineTo(0,   0);
								
								iCtx.LineWidth = 1;
								iCtx.Stroke();
							}

							//iCtx.BeginPath();
							//{
								//iCtx.MoveTo(-100,-100);
								//iCtx.LineTo(+100,-100);

								//iCtx.MoveTo(- 100,-100); iCtx.LineTo(-100,-80);

								//iCtx.MoveTo(-83.9,-100); iCtx.LineTo(-83.9,-80);
								//iCtx.MoveTo(-57.7,-100); iCtx.LineTo(-57.7,-80);
								//iCtx.MoveTo(-36.4,-100); iCtx.LineTo(-36.4,-80);
								//iCtx.MoveTo(-17.5,-100); iCtx.LineTo(-17.5,-80);
								//iCtx.MoveTo(    0,-100); iCtx.LineTo(    0,-80);

								//iCtx.MoveTo(+ 100,-100); iCtx.LineTo(+100,-80);

								////10 = 17.63
								////20 = 36.39
								////30 = 57.73
								////40 = 83.91
								


								//iCtx.StrokeStyle = "#ffffff";
								//iCtx.Stroke();
							//}
							
							
							//iCtx.Translate(0,0);
							iCtx.Rotate(iValue.Bank / 180 * PI);

							


							//iCtx.Rotate(PI/2);
							iCtx.BeginPath();
							iCtx.AddCircle(0,-110, 10);
							iCtx.Fill();

							iCtx.BeginPath();
							iCtx.AddArc(0,0,95, D180 - (D090 / 2), +D090 / 2, true);
							iCtx.LineWidth = 10;
							//iCtx.StrokeStyle = "#ffffff";
							iCtx.Stroke();


							//iCtx.StrokeStyle = iColor;
							//iCtx.FillStyle   = iColor;
							iCtx.LineWidth   = 1;
							
							iCtx.BeginPath();
							{
								//var _PP = 
								//[
									//+2,   -95,
									//+3,   -30,

									//+10,  -29,
									//+20,  -25,
									//+27,  -15,
									//+27,  +18,
									//+100, +20,
									//+100, +24,

									//+20, +27,
									//-20, +27,

									//-100, +24,
									//-100, +20,
									//-27, +18,
									//-27, -15,
									//-20, -25,
									//-10, -29,
									//-3, -30,
									//-2, -95
								//];

								//for(var Pi = 0; Pi < _PP.Length; Pi += 2) iCtx.LineTo(  +3, -30);

								//[].ForEach();
								iCtx.MoveTo(  +2, -95);
								iCtx.LineTo(  +3, -30);

								iCtx.LineTo( +10, -29);
								iCtx.LineTo( +20, -25);
								iCtx.LineTo( +27, -15);
								iCtx.LineTo( +27, +18);
								iCtx.LineTo(+100, +20);
								iCtx.LineTo(+100, +24);

								iCtx.LineTo( +20, +27);
								iCtx.LineTo( -20, +27);

								iCtx.LineTo(-100, +24);
								iCtx.LineTo(-100, +20);
								iCtx.LineTo( -27, +18);
								iCtx.LineTo( -27, -15);
								iCtx.LineTo( -20, -25);
								iCtx.LineTo( -10, -29);
								iCtx.LineTo(  -3, -30);
								iCtx.LineTo(  -2, -95);

								iCtx.ClosePath();

								
								iCtx.FillStyle = "#aaaaaa";
								iCtx.Fill();
								iCtx.Stroke();
							}
							

							//iCtx.FillRect(-100,-10,200,20);
							iCtx.Restore();
						 },
						Speeds    : function(iCtx, iValue, iX, iY)
						 {
							iCtx.Save();
							iCtx.Translate(iX,iY);
							
							iCtx.StrokeRect(0,0,125,200);
							//iCtx.FillStyle = "#ffffff";


							//iCtx.TextAlign = "left";
							//iCtx.FillText("IAS",  25,  25);
							//iCtx.FillText("MaS",  25,  50);
							//iCtx.FillText("GrS",  25,  75);

							//iCtx.FillText("AoA",  25,  125);

							//iCtx.TextAlign = "right";
							//iCtx.FillText(iValue.IAS, 125, 25);
							//iCtx.FillText(iValue.M, 125, 50);
							//iCtx.FillText(iValue.AoA, 125, 75);
							

							iCtx.TextAlign = "left";

							iCtx.FillText("IAS",  80,  25);
							iCtx.FillText("TAS",  80,  50);
							iCtx.FillText("MaS",  80,  75);
							iCtx.FillText("GrS",  80,  100);
							//iCtx.FillText("Acc",  80,  125);

							iCtx.FillText("AoA",  80,  150);

							iCtx.TextAlign = "right";

							iCtx.FillText(iValue.IAS.ToFixed(0), 70,  25);
							//iCtx.FillText(iValue.TAS.ToFixed(0), 70,  50);
							iCtx.FillText(iValue.MSpd.ToFixed(2), 70,  75);
							//iCtx.FillText(iValue.GrS.ToFixed(0), 70, 100);
							//iCtx.FillText(iValue.AoA.ToFixed(1), 70, 150);
							

							iCtx.Restore();
						 },
						Verticals : function(iCtx, iValue, iX, iY)
						 {
							iCtx.Save();
							iCtx.Translate(iX,iY);
							
							iCtx.StrokeRect(0,0,125,200);


							//iCtx.TextAlign = "left";
							//iCtx.FillText("IAS",  25,  25);
							//iCtx.FillText("MaS",  25,  50);
							//iCtx.FillText("GrS",  25,  75);

							//iCtx.FillText("AoA",  25,  125);

							//iCtx.TextAlign = "right";
							//iCtx.FillText(iValue.IAS, 125, 25);
							//iCtx.FillText(iValue.M, 125, 50);
							//iCtx.FillText(iValue.AoA, 125, 75);
							

							iCtx.TextAlign = "left";

							iCtx.FillText("VAlt",  80,  25);
							//iCtx.FillText("BAlt",  80,  50);
							//iCtx.FillText("RAlt",  80,  75);

							iCtx.FillText("VSpd",  80,  100);
							//iCtx.FillText("AoA",   80,  150);

							iCtx.TextAlign = "right";

							iCtx.FillText(iValue.Position.Z.ToString2(3), 70,  25);
							//iCtx.FillText(iValue.VAlt.ToFixed(0), 70,  25);
							//iCtx.FillText(iValue.BAlt.ToFixed(0), 70,  50);
							//iCtx.FillText(iValue.RAlt.ToFixed(2), 70,  75);
							iCtx.FillText(iValue.VSpd.ToFixed(0), 70, 100);
							//iCtx.FillText(iValue.AoA.ToFixed(1), 70, 150);
							

							iCtx.Restore();
						 },
						TSData    : function(iCtx, iValue, iX, iY)
						 {
							var _OffsT = 0;//33521;

							iCtx.Save();
							iCtx.Translate(iX,iY);
							{
								iCtx.FillText("SimT: " + iValue.Time.ToString2(3, false), 0, 0);
								//iCtx.FillText("CurT: " + (_OffsT + iValue.Time).ToString2(3, false) + " = " + new Date(1988,10,15,0,0, _OffsT + iValue.Time).toString(), 0, 20);
								//iCtx.FillText("FrnT: " + , 0, 40);
							}
							iCtx.Restore();
						 },
						Position  : function(iCtx, iValue, iX, iY)
						 {
							iCtx.Save();
							iCtx.Translate(iX,iY);
							{
								iCtx.FillText("X: " + iValue.Position.X.ToString2(3), 0, 0);
								iCtx.FillText("Y: " + iValue.Position.Y.ToString2(3), 0, 20);
								iCtx.FillText("Z: " + iValue.Position.Z.ToString2(3), 0, 40);
								//iCtx.FillText("CurT: " + (_OffsT + iValue.Time).ToString2(3, false) + " = " + new Date(1988,10,15,0,0, _OffsT + iValue.Time).toTimeString(), 0, 20);
								//iCtx.FillText("FrnT: " + , 0, 40);
							}
							iCtx.Restore();
						 },
					}
				}
			},
		 },
	 }
});