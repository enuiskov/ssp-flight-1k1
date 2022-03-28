"use strict";

stuff
 ({
	uses :
	[
		'Math',
		'Math.Geometry',
	],

	'UVS.Simulation.Vehicles.Buran.GuidanceSystem' :
	{
		GetGuidancePhase    : function(oPhaseI$obj)
		 {
			var _Veh  = this.Vehicle,
				 _Pos  = _Veh.Position,
				 _Alt  = _Veh.Data.BAlt,
				 _Dist = _Pos.Set(null,null,0).Length,
				 _Vel  = _Veh.Velocity.Linear;
			

			var _MajPh = "ERROR", _MinPh = "ERROR", _TransD = 5;
			{
				//if(_Alt >= 19900)
				if(_Alt >= 20000)
				{
					if(1)
					{
						_MajPh  = "TEST";
						_MinPh  = "T1";
						_TransD = 1;
					}
					else
					{
						_MajPh  = "ENTRY";
						_TransD = 0.1;


						_MinPh  = "ET5";
					}
					//if(_Dist < 200e3) _MinPh = "ET5";
				}
				else if(_Alt > 1000)
				{
					_MajPh  = "TEST";
					_MinPh  = "T1";
					_TransD = 1;
				}
				else if(_Alt >= 5100  && _Dist < 100000)
				{
					_MajPh  = "TAEM"; //~~ CAPTURE, HAC;
					

					if(_Veh.Data.MSpd > 0.9)
					{
						_MinPh = "CAPTURE";
						_TransD = 30;
					}
					else
					{
						_MinPh = "HAC";
						_TransD = 30;
						//_TransD = 90;
					}
				}
				else if(_Alt < 5100)
				{
					_MajPh = "A&L";

					//if(Abs(_Pos.Y) < 20000 && Abs(_Pos.X) < 3000)
					//{
						
					//}
					
					if(Abs(_Pos.X) < 2000)
					{
						if(Abs(_Pos.Y) > 14500)
						{
							_MinPh = "CAPTURE";
							_TransD = 1;
						}
						else
						{
							if     (_Alt > 500){_MinPh = "STEEP";}
							else if(_Alt >  30){_MinPh = "FLARE"; _TransD = 5;}
							else if(_Alt > 1.5){_MinPh = "FINALFLARE"; _TransD = 1;}
							else if(_Veh.MainGearL.Compression < 0.3 && _Veh.MainGearR.Compression < 0.3)
							{
								_MinPh  = "HOVER";
								_TransD = 0.1;
							}
							else
							{
								_MajPh = "GROUND";
								_TransD = 1;
								
								if(_Veh.NoseGear.Compression < 0.3) _MinPh  = "TOUCHDOWN";
								else
								{
									if(_Pos.Y * _Vel.Y < 0)
									{
										_MinPh = "LANDINGRUN";
									}
									else
									{
										if(_Vel.Length > 1) _MinPh = "STOP";
										else
										{
											//var _SS = _Veh.Surfaces;
											_MinPh  = _Veh.Surfaces.Elevator < +19 || Abs(_Veh.Surfaces.Aileron) > 1 || Abs(_Veh.Surfaces.Rudder) > 1 ? "SERVICE" : "SHUTDOWN";
										}
									}
								}
							}
						}
					}
					else
					{
						_MinPh = "ERROR";
					}
				}
				else
				{
					_MajPh  = "ENTRY";
					_MinPh  = "ET5";
					_TransD = 0.1;
				}
			}
			//if(_TransD == 0)
			return {ID : _MajPh + ":" + _MinPh, TransRate : 1 / _TransD};
		 },
		
		static : 
		{
				
			Routines : 
			 {
				//GetAngle          : function(iFrHdg, iToHdg){var _ClwsA = (iToHdg % D360) - (iFrHdg % D360), _AbsA = Abs(_ClwsA); return _AbsA > D180 ? (_AbsA - D360) * Sign(_ClwsA) : _ClwsA},
				GetSuitableHAC    : function(){return "NE"},
				GetHACInfo        : function(iCylId, iVeh, oInfo$obj)
				 {
					//debugger;
					//var _CylId     = iCylIdRoutines.GetSuitableHAC();
					var _IsN = iCylId == "NE" || iCylId == "NW", _IsS = !_IsN;
					var _IsE = iCylId == "NE" || iCylId == "SE", _IsW = !_IsE;
					var _IsTurnCW = (_IsN && _IsE) || (_IsS && _IsW);

					var _CenPos    = new Vector3(6000 * (_IsN ? -1 : +1), 15000 * (_IsE ? +1 : -1), 0);
					
					var _AltF      = 1; //~~ 'C' stands for Cylinder;
					var _CylRad    = 6000 * _AltF; 

					var _VehRelPos = iVeh.Position.Subtract(_CenPos).Set(null,null,0);//.Multiply(new Vector3(_IsN ? -1 : +1, _IsE ? +1 : -1, 0));
					var _DisToCen  = _VehRelPos.Length;
					var _DisToEdge = _DisToCen - _CylRad;
						
					var _IsInCyl  = _DisToCen < _CylRad;
					var _AngToTan = !_IsInCyl ? Asin(_CylRad / _DisToCen) : D090;
					//var _TrkToCen = Atan2(_VehPos.X - _CenPos.X, _VehPos.Y - _CenPos.Y) + PI;
					var _TrkToCen = Atan2(_VehRelPos.X, _VehRelPos.Y) + D180;
					var _TrkToTan = _TrkToCen + (_IsTurnCW ? -_AngToTan : +_AngToTan);
					//var _TrkToTan = _IsTurnCW ? _TrkToCen - _AngToTan : _TrkToCen + _AngToTan;

					//gAlgoCns.WriteLine(["_TrkToCen", _TrkToCen * RTD]);
					//~~var _AngToNEP = Atan2(-_VehRelPos.Y, _VehRelPos.X * (_IsTurnCW ? -1 : +1)) + D180;
					//var _AngToNEP = Atan2(-_VehRelPos.Y, -_VehRelPos.X) + (_IsTurnCW ? D180 : 0);

					var _AngToNEP = Atan2(_VehRelPos.Y * (_IsE ? -1 : +1), _VehRelPos.X * (_IsN ? -1 : +1)) + D180;// + D360) % D360;//(_IsTurnCW ? D180 : 0);
					//var _AngToNEP = D090 - Atan2(_VehRelPos.X, _VehRelPos.Y * (_IsTurnCW ? +1 : -1));
					{
						if(_AngToNEP > D180 && iVeh.Data.BAlt < 5000) _AngToNEP -= D360;
					}
					
					oInfo =
					{
						ID        : iCylId,
						CenPos    : _CenPos,
						IsCW      : _IsTurnCW,

						VehRelPos : _VehRelPos,
						

						
						DisToCen  : _DisToCen,
						DisToEdge : _DisToEdge,
						TrkToTan  : _TrkToTan,

						AngToNEP  : _AngToNEP,
						//TgtAlt    : _TgtAlt,
					};
					return oInfo;
				 },
				GetGlideslopeInfo : function(iOffsY, iIncA, iVeh, oInfo$obj)
				 {
					var iVehP     = iVeh.Position.Set(null,null,iVeh.Data.BAlt);//.Add(new Vector3(0,0,4.5));
					//var iVehP     = iVeh.Position;//.Add(new Vector3(0,0,4.5));
					var iVehV     = iVeh.Velocity.Linear;

					var _GlideT   = Tan(iIncA * DTR);

					var _TgtPosZ  = (Abs(iVehP.Y) - iOffsY) * _GlideT;
					var _AltErr   = iVehP.Z - _TgtPosZ;

					var _TgtVelZ  = -Abs(iVehV.Y) * _GlideT;
					var _VSpdErr  = iVehV.Z - _TgtVelZ;

					//gAlgoCns.WriteHeader("SLOPE" + iIncA);
					//gAlgoCns.WriteLine(["_TgtPosZ", _TgtPosZ]);
					//gAlgoCns.WriteLine(["_TgtVelZ", _TgtVelZ]);
					//gAlgoCns.WriteLine(["_AltErr",  _AltErr]);
					//gAlgoCns.WriteLine(["_VSpdErr", _VSpdErr]);

					return {AltErr : _AltErr, VSpdErr : _VSpdErr};
				 },
			 },

			Programs : jso
			 ({
				Generic : 
				{
					PHICM : 
					 {
						"HISTORICAL" : function HISTORICAL()
						 {
							var _E = UVS.Data.GetNearestEntry();
							//if(isNaN(_E.Value.Bank)) debugger;

							return _E ? _E.Value.Bank : 0;
						 },
						"HACTRACK"   : function           ()
						 {
							if(0 && this.Position.Z > 18000) return -Clamp(Scale(this.Position.Z, 20100, 19300), -14 / 50, 50 / 50) * 50;
							
							var _CylId   = Routines.GetSuitableHAC();
							var _CylInfo = Routines.GetHACInfo(_CylId, this);

							//var _LinVel    = this.Velocity.Linear;
							var _TrkAng  = Atan2(this.Velocity.Linear.X, this.Velocity.Linear.Y);
							//var _HdgError  = Routines.GetAngle(this.Data.Attitude.Heading, _CylInfo.TrkToTan);
							var _HdgErr  = Angle(_CylInfo.TrkToTan, _TrkAng) * RTD;
							var _MaxBnk  = 50;
							var _MaxErr  = 10;

							var _HdgF    = Scale(-_HdgErr, _MaxErr);
							//var _MaxErr  = 10;

							
							//gAlgoCns.WriteHeader("HACTRACK");
							gAlgoCns.WriteLine(["CylId",     _CylId]);
							gAlgoCns.WriteLine(["DisToEdge", _CylInfo.DisToEdge]);
							//gAlgoCns.WriteLine(["HdgErr",    _HdgErr]);

							gAlgoCns.WriteLine(["HdgErr", {Type : "Bar", Text : _HdgErr, Values : [0, _HdgF, null, true]}]);

							return Clamp(_HdgF) * _MaxBnk;
						 },
						"WINGLEV"    : function WINGLEV   (){return 0},
						"ELEVONLEV"  : function ELEVONLEV (){return -this.Surfaces.Aileron},
						"LOCALIZER"  : function LOCALIZER ()
						 {
							var _MaxLatPos  = 100;
							var _MaxLatVel  = 20;
							var _MaxBank    = 30;

							var _AppDir     = -Sign(this.Position.Y);
							var _LatPosErr  = _AppDir * this.Position.X;
							var _LatVelErr  = _AppDir * this.Velocity.Linear.X;

							var _LatPosF    = Scale(_LatPosErr, _MaxLatPos);
							var _LatVelF    = Scale(_LatVelErr, _MaxLatVel);
							 //+ Scale(-_LatVelErr, _MaxLatVel)) * _MaxBank
							//gAlgoCns.WriteLine(["LatPosErr", _LatPosErr]);
							//gAlgoCns.WriteLine(["LatVelErr", _LatVelErr]);
							
							gAlgoCns.WriteLine(["LatPosErr",  {Type : "Bar", Text : _LatPosErr, Values : [0, -_LatPosF, null, true]}]);
							gAlgoCns.WriteLine(["LatVelErr",  {Type : "Bar", Text : _LatVelErr, Values : [0, -_LatVelF, null, true]}]);
							//gAlgoCns.WriteLine(["Collective", {Type : "Bar",                    Values : [_LatVelF, _LatPosF, null, true]}]);

							//return Clamp(Clamp(Scale(-_LatPosErr, _MaxLatPos)) + Scale(-_LatVelErr, _MaxLatVel)) * _MaxBank;
							return -Clamp(Clamp(_LatPosF) + _LatVelF) * _MaxBank;
						 },
					 },
					YALCM : 
					 {
						"LOCALIZER"  : function LOCALIZER ()
						 {
							var _MaxLatPos  = 10;
							var _MaxLatVel  = 5;
							var _MaxLatAcc  = 3;
							var _MaxYawRate = 10;

							var _AppDir     = +Sign(this.Velocity.Linear.Y);
							var _LatPosErr  = _AppDir * this.Position.X;
							var _LatVelErr  = _AppDir * this.Velocity.Linear.X;
							var _LatAccErr  = this.Data.Accelerometer.X;

							

							var _LatPosF    = Scale(_LatPosErr, _MaxLatPos);
							var _LatVelF    = Scale(_LatVelErr, _MaxLatVel);
							var _LatAccF    = Scale(this.Data.Accelerometer.X, _MaxLatAcc);

							gAlgoCns.WriteLine(["LatPosErr",  {Type : "Bar", Text : _LatPosErr, Values : [0, -_LatPosF, null]}]);
							gAlgoCns.WriteLine(["LatVelErr",  {Type : "Bar", Text : _LatVelErr, Values : [0, -_LatVelF, null]}]);
							gAlgoCns.WriteLine(["LatAccErr",  {Type : "Bar", Text : _LatAccErr, Values : [0, -_LatAccF, null]}]);
							//gAlgoCns.WriteLine(["Collective", {Type : "Bar",                    Values : [_LatVelF, _LatPosF, null, true]}]);

							//gAlgoCns.WriteLine(["LatVelErr", {Type : "Bar01", Values : [_LatVelF, 0,  0.50, true]}]);

							//return -Clamp(Clamp(_LatPosF) + _LatVelF + _LatAccF) * _MaxYawRate;

							return -Clamp(Clamp(_LatPosF) + _LatVelF) * _MaxYawRate;
							//return -Clamp(Clamp(_LatPosF) + _LatVelErr + ) * _MaxYawRate;
						 },
					 },
					NZCM : 
					 {
						"HISTORICAL" : function HISTORICAL()
						 {
							var _E = UVS.Data.GetNearestEntry();

							var _CurVSpd = this.Velocity.Linear.Z;
							var _CmdVSpd = _E ? _E.Value.VSpd : _CurVSpd;
							
							var _VSpdErr = _CurVSpd - _CmdVSpd;
							var _VSpdF = Scale(_VSpdErr, 10);

							//if(isNaN(this.Data.VSpd) || isNaN(_E.Value.Position.Z)) debugger;

							gAlgoCns.WriteLine(["VSpdErr",  {Type : "Bar", Text : _VSpdErr, Values : [_VSpdF, 0, null]}]);
							//var _AltF = Clamp01(Scale01(this.Data.BAlt, 20000, 18000), 0.1, 0.1); //~~ high-alt transition fix;

							//return 1 + (Scale(-_VSpdErr, 10 * _AltF) + (0.8 * Abs(Sin(this.Data.Attitude.Bank))));
							//~~return 1 + (-_VSpdF + (1.0 * Abs(Sin(this.Data.Attitude.Bank))));
							return 1 - (_VSpdF * (1 + (Abs(Sin(this.Data.Attitude.Bank * DTR)) * 1.0)));
						 },
						//"VS_60"      : function VS_60     (){return 1 + Scale(-40 - this.Velocity.Linear.Z, 40)},
						"VS100"  : function VS100 ()
						 {
							var _CylId     = Routines.GetSuitableHAC();
							var _CylInfo   = Routines.GetHACInfo(_CylId, this);
							
							var _VSpdErr   = this.Velocity.Linear.Z + 100;
							var _VSpdErrF  = Scale(_VSpdErr, 10);
							
							gAlgoCns.WriteLine(["VSpdErr", {Type : "Bar", Text : _VSpdErr, Values : [_VSpdErrF,0]}]);
							
							return 1 - Clamp(_VSpdErrF);
						 },
						"HACENERGY"  : function HACENERGY ()
						 {
							var _CylId     = Routines.GetSuitableHAC();
							var _CylInfo   = Routines.GetHACInfo(_CylId, this);
							
							//var _AngToNEPF  = ;
							//var _DisToEdgeF = ;
							//~~var _TgtAlt     = Min(4500 + (_CylInfo.AngToNEP / D360 * 10500) + Max(_CylInfo.DisToEdge / 15, 0), 20000);
							//~~var _TgtAlt     = Min(4500 + (_CylInfo.AngToNEP / D360 * 11000) + Max(_CylInfo.DisToEdge / 100, 0), 20000);
							//var _TgtAlt     = Min(4500 + (Magic(_CylInfo.AngToNEP / D360, 1) * 11000) - Max(_CylInfo.DisToEdge / 100, 0), 20000);

							//var _TgtAlt     = Min((Magic(_CylInfo.AngToNEP / D360, 1) * 11000) + Magic((_CylInfo.DisToCen / 6000) * 4500, 0.5), 20000);
							//var _TgtAlt     = Min(4500 + (Magic(_CylInfo.AngToNEP / D360, 1) * 11000), 20000);
							var _TgtAlt     = Min(4800 + (Magic(_CylInfo.AngToNEP / D360, 1) * 20000), 20000);

							var _AltErr    = this.Data.BAlt - _TgtAlt;
							var _VSpdErr   = this.Velocity.Linear.Z + 50;// + 50;

							var _AltErrF   = Scale(_AltErr,  1000);
							var _VSpdErrF  = Scale(_VSpdErr, 40);//40);
							//var 

							//var _HDistErr = this.Velocity.Linear.Z + 50;
							
							//gAlgoCns.WriteHeader("HACENERGY");
							gAlgoCns.WriteLine(["AngToNEP", _CylInfo.AngToNEP * RTD]);
							//gAlgoCns.WriteLine(["_AngToAltF",  _AltErr]);
							gAlgoCns.WriteLine(["TgtAlt",  _TgtAlt]);

							gAlgoCns.WriteLine(["AltErr",  {Type : "Bar", Text : _AltErr,  Values : [_AltErrF, 0]}]);
							gAlgoCns.WriteLine(["VSpdErr", {Type : "Bar", Text : _VSpdErr, Values : [_VSpdErrF,0]}]);
							


							return 1 - ((Clamp(_AltErrF) + Clamp(_VSpdErrF, 2)) * 0.5);
						 },
						
					 },
					DSBCM : 
					 {
						"HISTORICAL" : function HISTORICAL()
						 {
							var _E = UVS.Data.GetNearestEntry();

							return _E ? _E.Value.SpdB : 0;
						 },

						"ZERO"       : function ZERO       (){return 0},
						"MAX"        : function MAX        (){return 87},
						"DEG65"      : function DEG65      (){return 65},
						"HYPERSONIC" : function HYPERSONIC ()
						 {
							return 65;
						 },
						"SUPERSONIC" : function SUPERSONIC ()
						 {
							return 75;
						 },
						"SUBSONIC"   : function SUBSONIC   ()
						 {
							var _IASErr = this.Data.IAS - 470;
							
							gAlgoCns.WriteLine(["IASErr",  _IASErr]);

							return Clamp(Scale01(_IASErr, 75), 0,1) * 87;
							
						 },
					 },
					DELBFRC : 
					 {
						"AUTO"      : function AUTO      (){return Clamp(this.Surfaces.Elevator)},
						"BFRETRACT" : function BFRETRACT (){return -10},
					 },
					QC : 
					 {
						"ELEVONDOWN" : function ELEVONDOWN   (){return -3},
					 },
					THRCM :
					 {
						"HISTORICAL" : function HISTORICAL()
						 {
							//debugger;
							//var _CmdSpd = UVS.Simulation.DataX.GetNearestEntry().Value.IAS;
							//var _CurSpd = this.Velocity.Linear.Length;
							var _Entry = UVS.Data.GetNearestEntry();

							//if(isNaN(_Entry.Value.MSpd) || isNaN(_Entry.Value.Position.Z)) debugger;
							if(_Entry.Value.Vel == undefined) debugger;


							//var _CurSpd = this.Data.IAS;
							var _CurSpd = this.Data.MSpd;
							//var _CmdSpd = _E ? _E.Value.IAS : _CurSpd;

							//var _CurSpd = this.Velocity.Linear.Length;
							//var _CmdSpd = _Entry ? _Entry.Value.Vel : _CurSpd;
							var _CmdSpd = _Entry ? _Entry.Value.MSpd : _CurSpd;
							
							var _SpdErr = _CurSpd - _CmdSpd;

							gAlgoCns.WriteLine(["_CmdSpd", _CmdSpd]);
							gAlgoCns.WriteLine(["_CurSpd", _CurSpd]);
							gAlgoCns.WriteLine(["_SpdErr", _SpdErr]);

							//return Scale(-_SpdErr, 0.05);
							//if(isNaN(_SpdErr)) debugger;
							return Clamp(Scale(-_SpdErr, 0.05));
							//return 1;//Scale(-_SpdErr, 0.05);
						 },
					 }
				 },
				Phase : 
				 {
					"MANUAL" : 
					 {
						"MANUAL"   : {},
					 },
					"TEST" : 
					 {
						"T1" : 
						 {
							PHICM   : "HISTORICAL",
							//PHICM : "HACTRACK",
							NZCM    : "HISTORICAL",
							DSBCM   : "HISTORICAL",
							THRCM   : "HISTORICAL",
							DELBFRC : "AUTO",
						 },
						"T2" : 
						 {
							PHICM : "WINGLEV",

							NZCM : function()
							{
								return 1 - Clamp(Scale(this.Data.BAlt - 10000, 500)) - Scale(this.Velocity.Linear.Z, 30);
							},
						 },
					 },
					//"ERROR" : 
					"ENTRY" : 
					 {
						"ERROR"   : {},
						"ET5" :
						 {
							//ALPHACM   : function ET5_ENERGY()
							//{
								//var _CurAlt = this.Position.Z;
								//var _TgtAlt = 20000 + (Clamp(Scale01(this.Position.Length, 36000, 1000e3), 0,1) * 50000);
								//var _AltErr = _CurAlt - _TgtAlt;

								//var _VSpdErr = Scale(this.Velocity.Linear.Z + 100, 100);

								////gAlgoCns.WriteLine(["AltErr",  _SlopeI.AltErr]);
								//gAlgoCns.WriteLine(["AltErr", _AltErr]);

								//return 1 - Clamp(Scale(_AltErr, 3000));// - Clamp(_VSpdErr);
							//},
							//ALPHACM   : function ET5_ENERGY()
							//{
								//var _AoACmd = 0 * DTR;
								//var _AoAErr = this.Data.AoA - _AoACmd;

								//gAlgoCns.WriteLine(["AoAErr",  _AoAErr * RTD]);
								
								//return _AoACmd;
							//},
							//PHICM  : function(){return 14 * DTR},
							NZCM   : function VS50()
							{
								var _VSpdCmd  = -60;
								var _VSpdErr  = this.Data.VSpd - _VSpdCmd;
								var _VSpdErrF = Scale(_VSpdErr, 10);
								
								gAlgoCns.WriteLine(["VSpdErr", {Type : "Bar", Text : _VSpdErr, Values : [_VSpdErrF,0]}]);

								return 1 - Clamp(_VSpdErrF);
							},
							//PHICM  : function R17(){return +17 * DTR},
							DSBCM   : "HYPERSONIC",
							DELBFRC : "AUTO",
						 },
						//"ET4" :
						 //{
							//NZCM   : function ET4_ENERGY()
							//{
								//var _CurAlt = this.Position.Z;
								//var _TgtAlt = 20000 + (Clamp(Scale01(this.Position.Length, 36000, 200000), 0,1) * 30000);
								//var _AltErr = _CurAlt - _TgtAlt;

								//var _VSpdErr = Scale(this.Velocity.Linear.Z + 100, 100);

								////gAlgoCns.WriteLine(["AltErr",  _SlopeI.AltErr]);
								//gAlgoCns.WriteLine(["AltErr", _AltErr]);

								//return 1 - Clamp(Scale(_AltErr, 3000));// - Clamp(_VSpdErr);
							//},
							////PHICM  : function(){return 0},
							//DSBCM  : "MAX",
						 //},
					 },
					"TAEM"  : 
					 {
						"ERROR"   :
						{
							DSBCM   : "SUBSONIC",
							PHICM   : "WINGLEV",
							NZCM    : "VS_60",
							DELBFRC : "AUTO",
						},
						
						//"S-TURN"  :
						 //{
							//NZCM    : "CAPTURE",
							//PHICM   : function(){return -1},
							//DSBCM   : "SUBSONIC",
							//DELBFRC : "AUTO",
						 //},
						"CAPTURE" :
						 {
							//NZCM   : "HISTORICAL",
							NZCM    : "VS100",
							PHICM   : "HACTRACK",
							DSBCM   : "SUPERSONIC",
							DELBFRC : "AUTO",
							//DSBCM  : "HISTORICAL",
							THRCM : "HISTORICAL",
						 },
						"HAC"     :
						 {
							//NZCM   : "HISTORICAL",
							NZCM    : "HACENERGY",
							PHICM   : "HACTRACK",
							DSBCM   : "SUBSONIC",
							//DSBCM  : "HISTORICAL",
							
							DELBFRC : "AUTO",
							THRCM : "HISTORICAL",
						 },
						"NEP"     : 
						 {
							DELBFRC : "AUTO",
						 },
					 },
					"A&L"   : 
					 {
						"ERROR"     : {},
						"CAPTURE"     :
						 {
							//NZCM  : function VSpd50(){return -(Clamp(this.Velocity.Linear.Z + 50, -10, +10) * 0.1) + 1},
							//NZCM  : function VSpd50(){return (iVehV + 50) * 0.05},
							NZCM    : "HACENERGY",
							PHICM   : "LOCALIZER",
							DSBCM   : "SUBSONIC",
							DELBFRC : "AUTO",
							//DSBCM  : "HISTORICAL",
							//THRCM  : "HISTORICAL",
						 },
						"STEEP"     :
						 {
							//NZCM  : function VSpd50(){return -(Clamp(this.Velocity.Linear.Z + 50, -10, +10) * 0.1) + 1},
							//NZCM  : function VSpd50(){return (iVehV + 50) * 0.05},
							NZCM   : function GS_STEEP()
							 {
								var _SlopeI = Routines.GetGlideslopeInfo(3400, 20, this); //~~ SSO-24;

								//return 1 + ((Scale(_SlopeI.AltErr, 100) * 0.1) + (Clamp(_SlopeI.VSpdErr,30) * 0.1));
								gAlgoCns.WriteLine(["AltErr",  _SlopeI.AltErr]);
								gAlgoCns.WriteLine(["VSpdErr", _SlopeI.VSpdErr]);

								//~~return 1 + Scale(_SlopeI.AltErr, -100) + Scale(_SlopeI.VSpdErr, -20);

								//return 1 - Scale(_SlopeI.AltErr, 100) - Scale(_SlopeI.VSpdErr, 20);
								return 1 - Scale(_SlopeI.AltErr, 100) - Scale(_SlopeI.VSpdErr, 20);
							 },
							PHICM  : "LOCALIZER",
							DSBCM  : "SUBSONIC",
							//DSBCM  : "HISTORICAL",
							//THRCM  : "HISTORICAL",
							DELBFRC : "AUTO",
						 },
						"FLARE"     :
						 {
							NZCM   : function GS_SHALLOW()
							 {
								var _SlopeI = Routines.GetGlideslopeInfo(1500, 2, this); //~~ SSO-3;

								gAlgoCns.WriteLine(["AltErr",  _SlopeI.AltErr]);
								gAlgoCns.WriteLine(["VSpdErr", _SlopeI.VSpdErr]);

								//return 1 + Scale(_SlopeI.AltErr, 50) + Scale(_SlopeI.VSpdErr, 10);
								//return 1 + Scale(_SlopeI.AltErr, -100) + Scale(_SlopeI.VSpdErr, -10);
								//~~return 1 - Scale(_SlopeI.AltErr, 100) - Scale(_SlopeI.VSpdErr, 10);
								return 1 - Scale(_SlopeI.AltErr, 50) - Scale(_SlopeI.VSpdErr, 10);

								//return 1 + Norm(_SlopeI.AltErr, -100) + Norm(_SlopeI.VSpdErr, -10);
							 },
							PHICM    : "LOCALIZER",
							DSBCM    : "SUBSONIC",
							DELBFRC  : "BFRETRACT",
							//DSBCM  : "HISTORICAL",
							//THRCM  : "HISTORICAL",
						},
						"FINALFLARE" : 
						 {
							NZCM    : function ALTEXP    ()
							 {
								//return 1 - Clamp(Scale(this.Velocity.Linear.Z + 3, 5), 0.2);
								var _RAlt  = this.Data.RAlt;
								var _CurVS = this.Velocity.Linear.Z;
								var _TgtVS = -(_RAlt / 10) - 0;// - 0.5;
								//var _TgtVS = -0.5;// - 0.5;
								var _ErrVS = _CurVS - _TgtVS;
								
								//var _AccZ  = -_ErrVS / 9.8;
								var _AccZ  = (-_ErrVS * 0.1) * Scale01(_RAlt, 30, 0);
								
								gAlgoCns.WriteLine(["RAlt",  _RAlt]);
								gAlgoCns.WriteLine(["CurVS", _CurVS]);
								gAlgoCns.WriteLine(["TgtVS", _TgtVS]);
								gAlgoCns.WriteLine(["ErrVS", _ErrVS]);
								gAlgoCns.WriteLine(["AccZ",  _AccZ]);


								//return 1 - Clamp(Scale((this.Velocity.Linear.Z + 1) / (this.Position.Z - 4.5), 1), 0.2);// - Clamp(this.Velocity.Acceleration.Linear.Z, 0.1);// - Scale(this.Velocity.Linear.Z, 3);// * Scale01(Clamp(this.Position.Z - 4, 0, 10), 10));// (1 - Clamp(Scale01(this.Position.Z - 4, 0, 10)));
								return 1 + Clamp(_AccZ * 1.0, -0.2, 2);// - Clamp(this.Velocity.Acceleration.Linear.Z, 0.1);// - Scale(this.Velocity.Linear.Z, 3);// * Scale01(Clamp(this.Position.Z - 4, 0, 10), 10));// (1 - Clamp(Scale01(this.Position.Z - 4, 0, 10)));
							 },
							//PHICM : function WingLev(){return 0},
							PHICM : "LOCALIZER",
							DSBCM : "DEG65",
							DELBFRC : "BFRETRACT",
						 },
						"HOVER" : 
						 {
							PHICM   : "WINGLEV",
							YALCM   : "LOCALIZER",

							DSBCM   : "DEG65",
							DELBFRC : "BFRETRACT",
						 },
					 },
					"GROUND" : 
					 {
						"TOUCHDOWN" : 
						 {
							DSBCM   : "ZERO",
							PHICM   : "WINGLEV",
							YALCM   : "LOCALIZER",
							DELBFRC : "BFRETRACT",

							QC      : function PITCHDOWN    (){return -1},

							WHBL    : function DIFFERENTIAL (){return 1 - Clamp01(-this.Surfaces.Rudder / 23)},
							WHBR    : function DIFFERENTIAL (){return 1 - Clamp01(+this.Surfaces.Rudder / 23)},
							WHBN    : function OFF          (){return 1},
						 },
						"LANDINGRUN" : 
						 {
							PHICM   : "ELEVONLEV",
							YALCM   : "LOCALIZER",
							DELBFRC : "BFRETRACT",

							WHBL    : function RELEASE      (){return 1},
							WHBR    : function RELEASE      (){return 1},
							WHBN    : function RELEASE      (){return 1},
						 },
						"STOP" : 
						 {
							PHICM   : "ELEVONLEV",
							YALCM   : "LOCALIZER",
							DELBFRC : "BFRETRACT",

							WHBL    : function BRAKE        (){return 0.5},
							WHBR    : function BRAKE        (){return 0.5},
							WHBN    : function BRAKE        (){return 0.5},
						 },
						"SERVICE" : 
						 {
							PHICM   : "ELEVONLEV",
							QC      : "ELEVONDOWN",
							DELBFRC : "BFRETRACT",

							WHBL    : function PARKING(){return 0},
							WHBR    : function PARKING(){return 0},
							WHBN    : function PARKING(){return 0},
						 },
						"SHUTDOWN" : 
						 {
							
						 },
					 }
				 }
			 }),
		}
	}
 });