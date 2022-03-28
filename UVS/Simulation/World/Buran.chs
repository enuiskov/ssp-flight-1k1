"use strict";

stuff
({
	uses :
	[
		'Math',
		'Math.Geometry',
		'UVS.Simulation',
	],

	'UVS.Simulation.Vehicles' : 
	 {
		'Buran : Vehicle' : 
		 {
			Data       : obj('Buran.Data'),

			Guidance   : obj('Buran.GuidanceSystem'),
			Autopilot  : obj('Buran.AutopilotSystem'),
			Cockpit    : obj('Buran.Cockpit'),
			Control    : obj('Buran.FlightControlSystem'),
			Surfaces   : obj('Buran.AerodynamicControlSystem'),
			Thrusters  : obj('Buran.ReactionControlSystem'),
			
			constructor      : function custom()
			 {
				//debugger;
				//this.overriden({Mass : new Mass(83000, new Vector3(10,30,10), new Vector3(0,0,0))});
				this.overriden({Mass : new Mass(83000, new Vector3(1,3,1).MultiplyScalar(10), new Vector3(0,0,0))});
				//Y =
				//6 12 25
				this.Reset();
				
				//25


				///
				//this.Body      = new Vehicles.Aircraft.AirResistantance({ID : "Eng1"});
				this.CenterWing = new Vehicles.Aircraft.Airfoil      ({ID : "CenterWing", Factor : 1, Lift :  70000,  Drag : 50000, Camber : 0.00, Position : new Vector3( 0.0,  +2.0,  0.0), Rotation : Quaternion.Rotated(0,0,0)});
				//this.WingInL    = new Vehicles.Aircraft.Airfoil      ({ID : "~WingInL",   Factor : 0, Lift :      0,  Drag : undefined,  Position : new Vector3(-4.0,  +2.0, -1.2), Rotation : Quaternion.Rotated(0,+0.1,+0.0, "YZX")});
				//this.WingInR    = new Vehicles.Aircraft.Airfoil      ({ID : "~WingInR",   Factor : 0, Lift :      0,  Drag : undefined,  Position : new Vector3(+4.0,  +2.0, -1.2), Rotation : Quaternion.Rotated(0,-0.1,-0.0, "YZX")});
				//this.WingOuL    = new Vehicles.Aircraft.Airfoil      ({ID : "~WingOuL",   Factor : 0, Lift :      0,  Drag : undefined,  Position : new Vector3(-8.0,  -4.3, -1.0), Rotation : Quaternion.Rotated(0,+0.1,+0.46, "YZX")});
				//this.WingOuR    = new Vehicles.Aircraft.Airfoil      ({ID : "~WingOuR",   Factor : 0, Lift :      0,  Drag : undefined,  Position : new Vector3(+8.0,  -4.3, -1.0), Rotation : Quaternion.Rotated(0,-0.1,-0.46, "YZX")});
				this.Tail       = new Vehicles.Aircraft.Airfoil      ({ID : "~Tail",      Factor : 1, Lift :  30000,  Drag : undefined,  Position : new Vector3( 0.0,   -11, +8.0), Rotation : Quaternion.Rotated(0, D090, 0.7, "YZX")});

				this.RudderL    = new Vehicles.Aircraft.Airfoil      ({ID : "~RudderL",   Factor : 1, Lift :  4000,   Drag : undefined,       Position : new Vector3(-0.05, -13.1, +8.3)});
				this.RudderR    = new Vehicles.Aircraft.Airfoil      ({ID : "~RudderR",   Factor : 1, Lift :  4000,   Drag : undefined,       Position : new Vector3(+0.05, -13.1, +8.3)});
				//this.ElevonL    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevonL",   Factor : 1, Lift :  20000,  Drag : undefined,  Position : new Vector3(-7.2,  -7.2, -1.2)});
				//this.ElevonR    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevonR",   Factor : 1, Lift :  20000,  Drag : undefined,  Position : new Vector3(+7.2,  -7.2, -1.2)});

				this.ElevInL    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevInL",   Factor : 1, Lift :  7000,  Drag : undefined,  Position : new Vector3(-5,    -7.14, -1.54)});
				this.ElevOuL    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevOuL",   Factor : 1, Lift :  7000,  Drag : undefined,  Position : new Vector3(-9.55, -7.05, -1.35)});
				this.ElevInR    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevInR",   Factor : 1, Lift :  7000,  Drag : undefined,  Position : new Vector3(+5,    -7.14, -1.54)});
				this.ElevOuR    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevOuR",   Factor : 1, Lift :  7000,  Drag : undefined,  Position : new Vector3(+9.55, -7.05, -1.35)});

				//~~this.ElevInL    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevInL",   Factor : 1, Lift :  10000,  Drag : undefined,  Position : new Vector3(-5,    -7.1, -1.3)});
				//this.ElevOuL    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevOuL",   Factor : 1, Lift :  10000,  Drag : undefined,  Position : new Vector3(-9.55, -7.0, -1.11)});
				//this.ElevInR    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevInR",   Factor : 1, Lift :  10000,  Drag : undefined,  Position : new Vector3(+5,    -7.1, -1.3)});
				//this.ElevOuR    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevOuR",   Factor : 1, Lift :  10000,  Drag : undefined,  Position : new Vector3(+9.55, -7.0, -1.11)});

				//this.ElevonL    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevonL",   Factor : 1, Lift :  15000,  Drag : undefined,  Position : new Vector3(-7.2,  -7.2, -1.2)});
				//this.ElevonR    = new Vehicles.Aircraft.Airfoil      ({ID : "~ElevonR",   Factor : 1, Lift :  15000,  Drag : undefined,  Position : new Vector3(+7.2,  -7.2, -1.2)});
				this.BodyFlap   = new Vehicles.Aircraft.Airfoil      ({ID : "~BodyFlap",  Factor : 1, Lift :  5000,   Drag : 0,  Position : new Vector3(   0, -10.6, -1.15)});
				
				this.CenterGear = new Vehicles.Aircraft.LandingGear  ({ID : "~CenterGear",             Position : this.Mass.Center});

				this.NoseGear   = new Vehicles.Aircraft.LandingGear  ({ID : "~NoseGear",               Position : new Vector3(   0, +11.2, -3.8)});
				this.MainGearL  = new Vehicles.Aircraft.LandingGear  ({ID : "~MainGearL",              Position : new Vector3(-3.5,  -1.7, -4.6)});
				this.MainGearR  = new Vehicles.Aircraft.LandingGear  ({ID : "~MainGearR",              Position : new Vector3(+3.5,  -1.7, -4.6)});

				this.Engine     = new Vehicles.Aircraft.RocketEngine ({ID : "Eng1", Factor : 0, Power : 83000 * 9.8 * 1.0,  Position : new Vector3(0,0,0), Rotation : Quaternion.Rotated(0,0,0)});

				this.LocTorqX   = new Forces.LocalTorque             ({ID : "LocTorqX", Factor : 0,    Rotation : Quaternion.Rotated(0,+D090,0)});
				this.LocTorqY   = new Forces.LocalTorque             ({ID : "LocTorqY", Factor : 0,    Rotation : Quaternion.Rotated(-D090,0,0)});
				this.LocTorqZ   = new Forces.LocalTorque             ({ID : "LocTorqZ", Factor : 0,    Rotation : Quaternion.Rotated(0,0,0)});

				//this.GloTorqX   = new Forces.GlobalTorque            ({ID : "GloTorqX", Factor : 0, Axis : new Vector3(1,0,0)});
				//this.GloTorqY   = new Forces.GlobalTorque            ({ID : "GloTorqY", Factor : 0, Axis : new Vector3(0,1,0)});
				//this.GloTorqZ   = new Forces.GlobalTorque            ({ID : "GloTorqZ", Factor : 0, Axis : new Vector3(0,0,1)});

				this.Forces.Add(this.Engine);
				
				
				
				if(1)
				{
					this.Forces.Add(new Forces.Gravity({ID : "~Gravity"}));

					//this.Forces.Add(this.CenterGear);
					this.Forces.Add(this.NoseGear);
					this.Forces.Add(this.MainGearL);
					this.Forces.Add(this.MainGearR);

					//this.Forces.Add(this.WingInL);
					//this.Forces.Add(this.WingInR);
					//this.Forces.Add(this.WingOuL);
					//this.Forces.Add(this.WingOuR);

					this.Forces.Add(this.CenterWing);
					this.Forces.Add(this.Tail);
					//this.Forces.Add(this.ElevonL);
					//this.Forces.Add(this.ElevonR);

					this.Forces.Add(this.ElevInL);
					this.Forces.Add(this.ElevOuL);
					this.Forces.Add(this.ElevInR);
					this.Forces.Add(this.ElevOuR);

					this.Forces.Add(this.RudderL);
					this.Forces.Add(this.RudderR);
					this.Forces.Add(this.BodyFlap);
				}
				if(1)
				{
					this.Forces.Add(this.LocTorqX);
					this.Forces.Add(this.LocTorqY);
					this.Forces.Add(this.LocTorqZ);

					//this.Forces.Add(this.GloTorqX);
					//this.Forces.Add(this.GloTorqY);
					//this.Forces.Add(this.GloTorqZ);
				}
			 },
			
			Reset : function()
			 {
				///debugger;
				this.Position  = new Vector3;
				this.Rotation  = new Quaternion;
				this.Velocity  = new Velocity;

				this.Data      = new Buran.Data                     ({Source : this, HdgFix : 66});	
				this.Guidance  = new Buran.GuidanceSystem           ({Vehicle : this});								this.Guidance  .Reset();
				this.Autopilot = new Buran.AutopilotSystem          ({Vehicle : this});								this.Autopilot .Reset();
				this.Cockpit   = new Buran.Cockpit                  ({Vehicle : this});								this.Cockpit   .Reset();
				this.Control   = new Buran.FlightControlSystem      ({Vehicle : this});								this.Control   .Reset();
				this.Surfaces  = new Buran.AerodynamicControlSystem ({Vehicle : this});								this.Surfaces  .Reset();
				this.Thrusters = new Buran.ReactionControlSystem    ({Vehicle : this});								this.Thrusters .Reset();

				//this.Data.
				//this.
			 },

			OnBeforeUpdate   : function(iDeltaT)
			 {
				gSysCns .Clear();
				gAlgoCns.Clear();
				//debugger;

				this.Guidance .Update(iDeltaT);
				this.Autopilot.Update(iDeltaT);
				this.Cockpit  .Update(iDeltaT);
				this.Control  .Update(iDeltaT);
				this.Surfaces .Update(iDeltaT);
				this.Thrusters.Update(iDeltaT);

				this.SyncThrusters    ();
				this.SyncSurfaces     ();
				this.SyncLandingGears ();
			 },
			SyncThrusters    : function(iData)
			 {
				
			 },
			SyncSurfaces     : function(iData)
			 {
				var _AA = this.Surfaces.Actuators;
				
				this.ElevonL, this.ElevonR;
				{
					this.ElevInL.Rotation = Quaternion.Rotated(_AA.ElevInL.CurrValue * DTR, +0.04, -0.01, "YZX");
					this.ElevOuL.Rotation = Quaternion.Rotated(_AA.ElevOuL.CurrValue * DTR, +0.04, -0.01, "YZX");

					this.ElevInR.Rotation = Quaternion.Rotated(_AA.ElevInR.CurrValue * DTR, -0.04, +0.01, "YZX");
					this.ElevOuR.Rotation = Quaternion.Rotated(_AA.ElevOuR.CurrValue * DTR, -0.04, +0.01, "YZX");
				}
				this.RudderL, this.RudderR;
				{
					var _RudV = _AA.Rudder  .CurrValue;
					var _BrkV = _AA.SpdBrake.CurrValue / 2;

					var _PnlL = -Clamp(-_RudV + _BrkV, -23.0, +43.5);
					var _PnlR = -Clamp(-_RudV - _BrkV, -43.5, +23.0);

					this.RudderL.Rotation = Quaternion.Rotated((_PnlL * DTR) + 0.03, -D090 + 0.010, -0.63, "YZX");
					this.RudderR.Rotation = Quaternion.Rotated((_PnlR * DTR) - 0.03, -D090 - 0.010, -0.63, "YZX");

					//this.RudderL.Rotation = Quaternion.Rotated((_PnlL * DTR) + 0.06, -D090 + 0.010, -0.63, "YZX");
					//this.RudderR.Rotation = Quaternion.Rotated((_PnlR * DTR) - 0.06, -D090 - 0.010, -0.63, "YZX");
				}
				this.BodyFlap.Rotation = Quaternion.Rotated((_AA.BodyFlap.CurrValue * DTR) - 0.13,0,0);
			 },
			SyncLandingGears : function(iData)
			 {
				this.NoseGear.Rotation = Quaternion.Rotated(0, 0, -this.Surfaces.Actuators.Rudder.CurrValue / 23 * 2 * DTR);
			 },
			//UpdateActuators : function()
			 //{
				////var _LElevD = 0;
				////var _RElevD = 0;
				
				////this.Actuators.ElevonL = Clamp(this.Actuators.ElevonL + _LElevD, ;
			 //},
			
			static : 
			 {
				'Data                     : Aircraft.Data'    : 
				 {
				 },
				
				'Component'                             : 
				 {
					Vehicle : obj('Vehicle'),

					Reset  : function()       {},
					Update : function(iDeltaT){},
				 },
				'GuidanceSystem           : Buran.Component'  : 
				 {
					Phase : str,

					
					GetGuidancePrograms : function(iPhase, oPP)
					 {
						//console.info("GetGuidancePrograms: " + iPhaseId);
						var _PhIdPP = iPhase.ID.split(":"), _MajPhN = _PhIdPP[0], _MinPhN = _PhIdPP[1];

						var _MajPhO = Buran.GuidanceSystem.Programs.Phase[_MajPhN]; if(!_MajPhO) throw "WTF";
						var _MinPhO = _MajPhO[_MinPhN];                             if(!_MinPhO) throw "WTF";
						
						oPP = {};
						{
							for(var cCmdN in _MinPhO)
							{
								if(!_MinPhO.hasOwnProperty(cCmdN)) continue;

								
								var cProgF = _MinPhO[cCmdN], cProgN = "???";
								{
									if(typeof(cProgF) == "string")
									{
										cProgN = cProgF;
										cProgF = Buran.GuidanceSystem.Programs.Generic[cCmdN][cProgF];
										
										if(!cProgF) throw "Generic program not found: '" + cCmdN + "/" + cProgN + "'";
									}

									
								}
								oPP[cCmdN] = new Buran.AutopilotSystem.Program
								({
									Name      : cProgF.name || cProgN,
									Command   : cCmdN,
									Function  : cProgF,
								});
							}
						}
						return oPP;
					 },
					
					Reset               : function(){this.Phase = {ID : "MANUAL:MANUAL"}},
					Update              : function(iDeltaT)
					 {
						var _NewPhase = this.GetGuidancePhase();//, _TgtPhaseId = _TgtPhase[0], _TgtTransP = _TgtPhase[1];
						
						if(_NewPhase.ID != this.Phase.ID)
						{
							this.Phase = _NewPhase;

							var _NewPP = this.GetGuidancePrograms(this.Phase);
							this.Vehicle.Autopilot.SupplyPrograms(_NewPP, _NewPhase.TransRate);
						}

						gSysCns.WriteHeader("GUIDANCE");
						gSysCns.WriteLine(["Phase",    this.Phase.ID]);
						gSysCns.WriteLine();

						gSysCns.WriteLine(["Heading",  this.Vehicle.Data.Attitude.Heading]);
						gSysCns.WriteLine(["Distance", this.Vehicle.Position.Set(null,null,0).Length]);
						//gSysCns.WriteLine(["Distance", this.Vehicle.V.Set(null,null,0);
						gSysCns.WriteLine(["Machs",    this.Vehicle.Data.MSpd]);
						
						gSysCns.WriteLine(["Altitude", this.Vehicle.Data.BAlt]);
						gSysCns.WriteLine(["VSpeed",   this.Vehicle.Data.VSpd]);

					 },
				 },
				'AutopilotSystem          : Buran.Component'  : 
				 {
					Programs       : arr,
					//TransRate      : num(+1),
					//Weight         : num(0),

					Reset           : function(){this.Weight = 0; this.Programs.Clear();},
					Connect         : function(iProg, iTransR)
					 {
						iProg.TransRate = +Abs(iTransR);

						this.Programs.Add(iProg);
					 },
					
					//Toggle          : function(iDoEnable)
					 //{
						//if(iDoEnable == undefined) iDoEnable = this.TransRate < 0;

						//this.TransRate = Abs(this.TransRate) * (iDoEnable ? +1 : -1);

						////this.IsEnabled = iDoEnable;
					 //},
					SupplyPrograms  : function(iPP$obj, iTransR)
					 {
						//if(!this.IsEnabled) return;

						for(var cP,Pi = 0; cP = this.Programs[Pi]; Pi++)
						{
							cP.TransRate      = -iTransR;
							//cP.TransDirection = -1;
						}

						for(var cCmdN in iPP)
						{
							if(!iPP.hasOwnProperty(cCmdN)) continue;
						
							var cDoConn = true; for(var cP,Pi = 0; cP = this.Programs[Pi]; Pi++)
							{
								if(cP.Command == cCmdN)
								{
									cP.TransRate = iTransR;

									if(cP.Name == iPP[cCmdN].Name)
									{
										cP.TransRate = +Abs(cP.TransRate);
										cDoConn = false;
									}
									else cP.TransRate = -Abs(cP.TransRate);
								}
							}

							if(cDoConn) this.Connect(iPP[cCmdN], iTransR);
						}
					 },

					Update          : function(iDeltaT)
					 {
						gSysCns.WriteLine();
						gSysCns.WriteHeader("AUTOPILOT");
						//gSysCns.WriteLine(["Weight", {Type : "ProgressBar", CurrValue : this.Weight, Text : this.CurrValue, CommValue : this.TransRate >= 0 ? +1 : 0, Min : 0}]);
						//gSysCns.WriteLine(["Programs", this.Programs.Length.ToString()]);
						gSysCns.WriteLine(["Programs", this.Programs.Length.ToString()]);
						gSysCns.WriteLine("{");
						{
							var _Veh  = this.Vehicle;
							var _VehC = this.Vehicle.Control;
							
							//this.Weight = Clamp(this.Weight + (this.TransRate * iDeltaT), 0,1);

							for(var cP,Pi = 0, cDoSkipR = false; cP = this.Programs[Pi]; Pi++)
							{
								//gSysCns.WriteLine(["+ " + cP.Command, {Type : "ProgressBar", Text : cP.Name, CurrValue : cP.Weight, CommValue : cP.TransRate >= 0 ? +1 : 0, Min : 0}]);
								gSysCns.WriteLine(["+ " + cP.Command, {Type : "Bar01", Text : cP.Name, Values : [cP.Weight, cP.TransRate >= 0 ? 1 : 0]}]);

								Transition: 
								{
									cP.Weight += (cP.TransRate * iDeltaT);

									if(cP.Weight >= 1)
									{
										cP.Weight = 1;
										//cP.TransDirection = 0;
									}
									if(cP.Weight <= 0)
									{
										if(1 || !cDoSkipR)
										{
											this.Programs.RemoveAt(Pi);
											cDoSkipR = true;
										}
										continue;
									}
								}

								//gSysCns.WriteLine([cP.Command, cP.Weight.ToString2(2) + " - " + cP.Name]);
								
							}
							for(var Si = 0; Si < 12 - this.Programs.Length; Si++) gSysCns.WriteLine("  -");
						}
						gSysCns.WriteLine("}");

						var _SensedD =
						{
							NorAcc : this.Vehicle.Data.Accelerometer.Z,
							RolAng : this.Vehicle.Data.Attitude.Bank,
							BodFla : this.Vehicle.Surfaces.Actuators.BodyFlap.CurrValue,
							SpdBra : this.Vehicle.Surfaces.Actuators.SpdBrake.CurrValue,

							AoA    : this.Vehicle.Data.AoA,

							PitRate :  this.Vehicle.Data.Velocity.Angular.Y,
							YawRate : -this.Vehicle.Data.Velocity.Angular.Z,
						};
						//debugger;
						var _AngRR = new Vector3, _BoF = _SensedD.BodFla, _SpB = 0;
						var _WhBN = 1, _WhBL = 1, _WhBR = 1, _FiEng = 0;
						{
							for(var cProg,Pi = 0; cProg = this.Programs[Pi]; Pi++)
							{
								var cW = cProg.Weight;// * this.Weight;

								var cCmdD;
								{
									gAlgoCns.WriteLine("> " + cProg.Command + ":" + cProg.Name);

									var cValue = cProg.Execute(this.Vehicle); switch(cProg.Command)
									{
										case "NZCM"    : _AngRR.X += (Clamp(cValue, -1, +3) - _SensedD.NorAcc)   * cW *  10; break;
										case "ALPHACM" : _AngRR.X += (cValue                - _SensedD.AoA)      * cW *  1; break;
										case "QC"      : _AngRR.X += (cValue                - _SensedD.PitRate)  * cW *  1; break;

										case "PHICM"   : _AngRR.Y += (cValue - _SensedD.RolAng)                  * cW *  2; break;
										case "YALCM"   : _AngRR.Z -= (cValue - _SensedD.YawRate)                 * cW *  5; break;

										case "DSBCM"   : _SpB     += cValue                                      * cW *  1; break;
										case "DELBFRC" : _BoF     += cValue                                      * cW *  1; break;

										case "WHBN"    : _WhBN    -= cValue                                      * cW *  1; break;
										case "WHBL"    : _WhBL    -= cValue                                      * cW *  1; break;
										case "WHBR"    : _WhBR    -= cValue                                      * cW *  1; break;

										case "THRCM"   : _FiEng   += cValue                                      * cW *  1; break;
									}
								}
							}
						}
						
						this.Vehicle.Control.Inputs.Autopilot = new Buran.FlightControlSystem.CommandPacket
						({
							AngRates    : _AngRR,
							MaxRates    : new Vector3(5,10,5),

							SpdBrake    : _SpB,
							BodyFlap    : _BoF,

							Throttle	   : _FiEng,
							WheelBrakes : {Nose : _WhBN, MainL : _WhBL, MainR : _WhBR},
						});
				
					 },
					
					static :
					{
						'Program' :
						 {
							Name           : str,
							Command        : str,
							Weight         : num( 0),
							TransRate      : num(+1),
							Function       : fnc,

							Execute : function(iVeh, oRes$any){return this.Function.call(iVeh)}
						 },
					}
				 },
				'Cockpit                  : Buran.Component'  : 
				 {
					Joystick    : obj('Vector3'),
					AttRates    : obj('Vector3', 10,20,10),

					SpdBrake    : num,
					BodyFlap    : num,

					LandingGear : boo,
					WheelBrakes : obj,

					Throttle    : num,

					Update : function(iDeltaT)
					 {
						this.SpdBrake = Clamp(this.SpdBrake,   0, 87);
						this.BodyFlap = Clamp(this.BodyFlap,   0, 30);

						var _CmdPacket = new Buran.FlightControlSystem.CommandPacket();
						{
							_CmdPacket.AngRates    = this.Joystick.Multiply(this.AttRates);
							_CmdPacket.MaxRates    = this.AttRates;
							_CmdPacket.SpdBrake    = this.SpdBrake;
							_CmdPacket.BodyFlap    = this.BodyFlap;
							_CmdPacket.LandingGear = this.LandingGear;

							_CmdPacket.WheelBrakes = {Nose : 0, MainL : 0, MainR : 0};

							_CmdPacket.Throttle    = this.Throttle;
						}
						this.Vehicle.Control.Inputs.Manual = _CmdPacket;
					 },
				 },
				
				'FlightControlSystem      : Buran.Component'  : 
				 {
					Inputs      : obj({Autopilot : null, Manual : null, Balance : 0.5, BalRate : +0.5}),
					
					AngRates    : obj('Vector3'),
					SpdBrake    : num(null),
					BodyFlap    : num(null),
					LandingGear : boo(null),
					WheelBrakes : obj({Nose : 0, MainL : 0, MainR : 0}),
					Throttle    : num(null),



					//Autopilot : obj,
					//Manual    : obj,
					//Balance   : num,

					//XXX       : obj('Buran.FlightControlSystem.CommandPacket'),

					


					//Output : obj('Buran.FlightControlSystem.CommandPacket'),
				

					
					Reset    : function()
					 {
						//this.AngRates = new Vector3;
						//this.MaxRate
						//this.
					 },

					MixInputs : function()
					 {
						var _APiI = this.Inputs.Autopilot, _ManI = this.Inputs.Manual;
						var _APiW = this.Inputs.Balance;

						this.AngRates    = Vector3.Mix(_ManI.AngRates, _APiI.AngRates, _APiW);
						this.MaxRates    = Vector3.Mix(_ManI.MaxRates, _APiI.MaxRates, _APiW);
						this.SpdBrake    =    Math.Mix(_ManI.SpdBrake, _APiI.SpdBrake, _APiW);
						this.BodyFlap    =    Math.Mix(_ManI.BodyFlap, _APiI.BodyFlap, _APiW);
						this.Throttle    =    Math.Mix(_ManI.Throttle, _APiI.Throttle, _APiW);
						this.WheelBrakes =
						{
							Nose  : Mix(_ManI.WheelBrakes.Nose,  _APiI.WheelBrakes.Nose,  _APiW),
							MainL : Mix(_ManI.WheelBrakes.MainL, _APiI.WheelBrakes.MainL, _APiW),
							MainR : Mix(_ManI.WheelBrakes.MainR, _APiI.WheelBrakes.MainR, _APiW)
						}
						
						


						//if(isNaN(this.Throttle)) debugger;
					 },
					Limit : function()
					 {
						//this.Inputs.AngRates

						this.AngRates = Vector3.Clamp(this.AngRates, this.MaxRates);

						//this.Elevator = Clamp(this.Elevator);
						//this.Ailerons = Clamp(this.Ailerons);
						//this.Rudder   = Clamp(this.Rudder);

						this.SpdBrake = Clamp(this.SpdBrake,  0, 87);
						this.BodyFlap = Clamp(this.BodyFlap,  0, 30);
					 },
					Stabilize : function(iDeltaT)
					 {
						//debugger;
						var _Data  = this.Vehicle.Data;
						var _AngV  = _Data.Velocity.Angular;
						var _AngA  = _Data.Velocity.Acceleration.Angular;

						var _AngRR = this.AngRates;
						var _MaxRR = this.MaxRates;

						var _CmdRR =  Vector3.Clamp(_AngRR, _MaxRR);
						var _AngEE = _AngV.Subtract(_CmdRR);// .Subtract(_AngRR, _MaxRR));//.Subtract(Vector3.Clamp(_MaxRR, ));
						
						gSysCns.WriteLine(["_AngV",  _AngV]);
						gSysCns.WriteLine(["_CmdRR", _CmdRR]);
						gSysCns.WriteLine(["_AngEE", _AngEE]);

						

						if(1)
						{
							var _AirSpdF = Clamp(Scale01(this.Vehicle.Data.IAS, 500, 200), 0.1, 0.5);

							//if(isNaN(_AirSpdF)) debugger;
							this.AngRates = Vector3.Add
							(
								_AngEE.MultiplyScalar(-_AirSpdF),
								//Vector3.Multiply(_AngEE,Vector3.Magnitude(_AngEE)).MultiplyScalar(-0.05),

								//Vector3.Multiply(_AngA,Vector3.Magnitude(_AngA)).MultiplyScalar(-0.01)
								_AngA .MultiplyScalar(-_AirSpdF)
							);

							//this.AngRates = Vector3.Add
							//(
								//_AngEE.MultiplyScalar(-0.1 * _AirSpdF),
								////Vector3.Multiply(_AngEE,Vector3.Magnitude(_AngEE)).MultiplyScalar(-0.05),

								////Vector3.Multiply(_AngA,Vector3.Magnitude(_AngA)).MultiplyScalar(-0.01)
								//_AngA .MultiplyScalar(-0.1 * _AirSpdF)
							//);
						}
					 },
					Update   : function(iDeltaT)
					 {
						//debugger;
						gSysCns.WriteLine();
						gSysCns.WriteHeader("CONTROL");

						var _BalV = this.Inputs.Balance;
						var _BalR = this.Inputs.BalRate;
						{
							_BalV += _BalR * iDeltaT;
							
							if(_BalV < 0 || _BalV > 1)
							{
								_BalV = Clamp01(_BalV);

								if(_BalR != 0) _BalR = 0;
							}
							
							this.Inputs.BalRate = _BalR;
							this.Inputs.Balance = _BalV;
						}
						

						//gSysCns.WriteLine(["Source", {Type : "ProgressBar", Text : _BalV == +1 ? "Autopilot" : _BalV == 0 ? "Manual" : "Auto+Manual", CurrValue : _BalV, CommValue : Clamp01(_BalR) || _BalV, Min : 0}]);
						gSysCns.WriteLine(["Source", {Type : "Bar01", Text : _BalV == +1 ? "Autopilot" : _BalV == 0 ? "Manual" : "Auto+Manual", Values : [_BalV, _BalR > 0 ? 1 : _BalR < 0 ? 0 : _BalV]}]);
						

						this.MixInputs();

						gSysCns.WriteLine(["AngRates", this.AngRates]);
						
						this.Limit();
						this.Stabilize(iDeltaT);
						this.Limit();
						
					
						var _SS = this.Vehicle.Surfaces;
						{
							//_SS.Elevator = Clamp(_SS.Elevator + this.AngRates.X);
							//_SS.Ailerons = Clamp(_SS.Ailerons + this.AngRates.Y);
							//_SS.Rudder   = Clamp(_SS.Rudder   + this.AngRates.Z) * 0.99;
							
							_SS.Elevator -= this.AngRates.X * iDeltaT * 10;
							_SS.Aileron  += this.AngRates.Y * iDeltaT * 10;
							_SS.Rudder   -= this.AngRates.Z * iDeltaT * 10; _SS.Rudder -= Sign(_SS.Rudder) * 10 * iDeltaT;

							_SS.SpdBrake = this.SpdBrake;
							_SS.BodyFlap = this.BodyFlap;
						}
						
						this.Vehicle.NoseGear .Brake = this.WheelBrakes.Nose;
						this.Vehicle.MainGearL.Brake = this.WheelBrakes.MainL;
						this.Vehicle.MainGearR.Brake = this.WheelBrakes.MainR;


						this.Vehicle.Engine.Factor = this.Throttle;
					 },
					
					static : 
					{
						'CommandPacket' : 
						 {
							AngRates    : obj('Vector3', null, null, null),
							MaxRates    : obj('Vector3', null, null, null),
							
							SpdBrake    : num(null),
							BodyFlap    : num(null),

							LandingGear : boo(null),
							WheelBrakes : obj({Nose : null, MainL : null, MainR : null}),

							Throttle    : num(null),
						 },
					}
				 },
				'AerodynamicControlSystem : Buran.Component'  : 
				 {
					Elevator   : num,
					Aileron    : num,
					Rudder     : num,
					SpdBrake   : num,
					BodyFlap   : num,

					Trims      : obj,
					Actuators  : obj,

					constructor : function annex(iAA)
					 {
						this.Actuators =
						{
							ElevInL  : new Buran.AerodynamicControlSystem.Actuator({MaxRate : 45,  CommRate : 45,  Range : {Min : -35, Max : +20}}),
							ElevOuL  : new Buran.AerodynamicControlSystem.Actuator({MaxRate : 45,  CommRate : 45,  Range : {Min : -35, Max : +20}}),
							ElevInR  : new Buran.AerodynamicControlSystem.Actuator({MaxRate : 45,  CommRate : 45,  Range : {Min : -35, Max : +20}}),
							ElevOuR  : new Buran.AerodynamicControlSystem.Actuator({MaxRate : 45,  CommRate : 45,  Range : {Min : -35, Max : +20}}),
							Rudder   : new Buran.AerodynamicControlSystem.Actuator({MaxRate : 90,  CommRate : 90,  Range : {Min : -23, Max : +23}}),

							SpdBrake : new Buran.AerodynamicControlSystem.Actuator({MaxRate : 20,  CommRate : 10,  Range : {Min :   0, Max :  87}}),
							BodyFlap : new Buran.AerodynamicControlSystem.Actuator({MaxRate : 10,  CommRate : 10,  Range : {Min :   0, Max :  30}}),
						};

						//this.Reset();
					 },
					Reset : function()
					 {
						this.Elevator = 0; //~~ -35..+20;
						this.Aileron  = 0; //~~ -10..+10;
						this.Rudder   = 0; //~~ -23..+23;
						this.SpdBrake = 0; //~~   0..+87;
						this.BodyFlap = 0; //~~   0..+30;

						//35 / 55 * 0.8
						var _ElevMeanV = 0;
					
						//this.Actuators.ElevonL .CurrValue = _ElevMeanV;
						//this.Actuators.ElevonR .CurrValue = 35 / 55 * 0.8;
						this.Actuators.ElevInL .CurrValue = _ElevMeanV;
						this.Actuators.ElevOuL .CurrValue = _ElevMeanV;

						this.Actuators.ElevInR .CurrValue = _ElevMeanV;
						this.Actuators.ElevOuR .CurrValue = _ElevMeanV;

						this.Actuators.Rudder  .CurrValue = 0;
						this.Actuators.BodyFlap.CurrValue = 0;
						this.Actuators.SpdBrake.CurrValue = 0;
					 },
					Update : function(iDeltaT)
					 {
						this.Elevator = Clamp(this.Elevator, -35,+20);
						this.Aileron  = Clamp(this.Aileron,  -10,+10);
						this.Rudder   = Clamp(this.Rudder,   -23,+23);
						this.SpdBrake = Clamp(this.SpdBrake,   0,+87);
						this.BodyFlap = Clamp(this.BodyFlap,   0,+30);
						
						var _AA = this.Actuators;
						{
							//debugger;
							var _ElevL = (this.Elevator + this.Aileron);
							var _ElevR = (this.Elevator - this.Aileron);
							
							
							var _ElBrAltF = Clamp01(Scale01(this.Vehicle.Data.RAlt, 10, 20));
							var _ElBrL = Min(this.Rudder / 23 + 0.5, 0) * _ElBrAltF * 30;
							var _ElBrR = Max(this.Rudder / 23 - 0.5, 0) * _ElBrAltF * 30;

							//var _ElBrL = Max(this.Rudder / 23 - 0.5, 0) * 30;
							//var _ElBrR = Min(this.Rudder / 23 + 0.5, 0) * 30;
							
							var _ElInL = Clamp(_ElevL + _ElBrL, -35,+20),  _ElOuL = Clamp(_ElevL - _ElBrL, -35,+20);
							var _ElInR = Clamp(_ElevR - _ElBrR, -35,+20),  _ElOuR = Clamp(_ElevR + _ElBrR, -35,+20);
							
							//var _ElevL = ((-this.Elevator * 0.8) + (+this.Ailerons * 0.2) + 1) / 2;
							//var _ElevR = ((-this.Elevator * 0.8) + (-this.Ailerons * 0.2) + 1) / 2;
							
							//var _ElBrL = Max(this.Rudder - 0.2, 0);
							//var _ElBrR = Min(this.Rudder + 0.2, 0);
							
							//var _ElInL = Clamp(_ElevL - (_ElBrL * 1.0), 0,1),  _ElOuL = Clamp(_ElevL + (_ElBrL * 0.4), 0,1);
							//var _ElInR = Clamp(_ElevR + (_ElBrR * 1.0), 0,1),  _ElOuR = Clamp(_ElevR - (_ElBrR * 0.4), 0,1);
							

							//if(Abs(this.Rudder) > 0.5)
							//{
								
							//}
							
							//_AA.ElevonL .CommValue = _ElevL;         _AA.ElevonL .Update(iDeltaT);
							
							_AA.ElevInL.CommValue = _ElInL;          _AA.ElevInL .Update(iDeltaT);
							_AA.ElevOuL.CommValue = _ElOuL;          _AA.ElevOuL .Update(iDeltaT);
							_AA.ElevInR.CommValue = _ElInR;          _AA.ElevInR .Update(iDeltaT);
							_AA.ElevOuR.CommValue = _ElOuR;          _AA.ElevOuR .Update(iDeltaT);

							_AA.Rudder  .CommValue = this.Rudder;    _AA.Rudder  .Update(iDeltaT);
							_AA.SpdBrake.CommValue = this.SpdBrake;  _AA.SpdBrake.Update(iDeltaT);
							_AA.BodyFlap.CommValue = this.BodyFlap;  _AA.BodyFlap.Update(iDeltaT);
							
							//var _ElevLDeg = _ElevL;
							//gSysCns.WriteLine(["Pitch", {Type : "ProgressBar", CurrValue : this.Vehicle.Surfaces.Actuators.SpdBrake.CurrValue, CommValue : this.SpdBrake,  W : 100, H : 11}]);
							gSysCns.WriteLine();
							gSysCns.WriteHeader("SURFACES");
							//gSysCns.WriteLine(["ElevonL",  {Type : "ProgressBar", Text : (_AA.ElevonL.CurrValue  * 55 - 35).ToString2(2), CurrValue : _AA.ElevonL .CurrValue,  CommValue : _AA.ElevonL .CommValue, Min : 0}]);
							//gSysCns.WriteLine(["ElevonR",  {Type : "ProgressBar", Text : (_AA.ElevonL.CurrValue  * 55 - 35).ToString2(2), CurrValue : _AA.ElevonR .CurrValue,  CommValue : _AA.ElevonR .CommValue, Min : 0}]);

							gSysCns.WriteLine(["ElevInL",  {Type : "ProgressBar", Text : _AA.ElevInL .CurrValue.ToString2(2), CurrValue : _AA.ElevInL .CurrValue,  CommValue : _AA.ElevInL .CommValue, Min : -35, Max : +20}]);
							gSysCns.WriteLine(["ElevOuL",  {Type : "ProgressBar", Text : _AA.ElevOuL .CurrValue.ToString2(2), CurrValue : _AA.ElevOuL .CurrValue,  CommValue : _AA.ElevOuL .CommValue, Min : -35, Max : +20}]);
							gSysCns.WriteLine(["ElevInR",  {Type : "ProgressBar", Text : _AA.ElevInR .CurrValue.ToString2(2), CurrValue : _AA.ElevInR .CurrValue,  CommValue : _AA.ElevInR .CommValue, Min : -35, Max : +20}]);
							gSysCns.WriteLine(["ElevOuR",  {Type : "ProgressBar", Text : _AA.ElevOuR .CurrValue.ToString2(2), CurrValue : _AA.ElevOuR .CurrValue,  CommValue : _AA.ElevOuR .CommValue, Min : -35, Max : +20}]);
							gSysCns.WriteLine(["Rudder",   {Type : "ProgressBar", Text : _AA.Rudder  .CurrValue.ToString2(2), CurrValue : _AA.Rudder  .CurrValue,  CommValue : _AA.Rudder  .CommValue, Min : -23, Max : +23}]);
							gSysCns.WriteLine(["BodyFlap", {Type : "ProgressBar", Text : _AA.BodyFlap.CurrValue.ToString2(2), CurrValue : _AA.BodyFlap.CurrValue,  CommValue : _AA.BodyFlap.CommValue, Min :   0, Max : +30}]);
							gSysCns.WriteLine(["SpdBrake", {Type : "ProgressBar", Text : _AA.SpdBrake.CurrValue.ToString2(2), CurrValue : _AA.SpdBrake.CurrValue,  CommValue : _AA.SpdBrake.CommValue, Min :   0, Max : +87}]);
						}
					 },
					static :
					 {
						'Actuator' : 
						 {
							Range     : obj ({Min : 0, Max : 10}),
							MaxRate   : num (10),
							DeadZone  : num (10),
							Inertia   : num (0.1),
							Rebound   : num (0.1),
							
							CurrValue : num (0),
							CurrRate  : num (0),

							CommValue : num (0),
							CommRate  : num (1),

							IsDebug   : boo (false),
						
							Update : function(iDeltaT)
							 {
								//debugger;

								var _MinV = this.Range.Min,  _MaxV = this.Range.Max;
								var _CurV = this.CurrValue,  _CmdV = Clamp(this.CommValue, _MinV, _MaxV);
								var _CurR = this.CurrRate,   _CmdR = Clamp(this.CommRate, this.MaxRate);
								{
									var _ValE = Clamp(Scale(_CurV - _CmdV, this.DeadZone));
									//var _RatE = _CurR - (-_ValE * _CmdR);
									//var _RatD = -_RatE;

									_CurR = Clamp(-_ValE * _CmdR, _CmdR);
									_CurV = Clamp(_CurV + (_CurR * iDeltaT), _MinV, _MaxV);

									//~~if((_CurR > 0 && _CurV >= _MaxV) || (_CurR < 0 && _CurV <= _MinV)) _CurR = -_CurR * this.Rebound;

									if((_CurV >= Min(_CmdV,_MaxV) && _CurR > 0) || (_CurV <= Max(_CmdV,_MinV) && _CurR < 0)) _CurR = 0;//-_CurR * this.Rebound;

									if(this.IsDebug)
									{
										gAlgoCns.WriteLine();
										gAlgoCns.WriteLine(["VV", {Type : "ProgressBar", CommValue : _CmdV,  CurrValue : _CurV,  Min : 0}]);
										
										gAlgoCns.WriteLine(["ValE", _ValE]);
										gAlgoCns.WriteLine(["RatE", _RatE]);
										gAlgoCns.WriteLine(["RatD", _RatD]);
										gAlgoCns.WriteLine(["CurR", _CurR]);
										gAlgoCns.WriteLine(["CurV", _CurV]);
										gAlgoCns.WriteLine(["CmdR", _CmdR]);
									}
								}
								this.CurrValue = _CurV;
								this.CurrRate  = _CurR;
							 },
							
							
							//Update : function(iDeltaT)
							//{
								//var _MinV = this.Range.Min,  _MaxV = this.Range.Max;
								//var _CurV = this.CurrValue,  _CmdV = Clamp(this.CommValue, _MinV, _MaxV);
								//var _CurR = this.CurrRate,   _CmdR = Clamp(this.CommRate, this.MaxRate);
								//{
									//var _ValE = Clamp(Scale(_CurV - _CmdV, this.DeadZone));
									//var _RatE = _CurR - (-_ValE * _CmdR);
									//var _RatD = -_RatE;

									//_CurR = Clamp(_CurR + (_RatD * iDeltaT / this.Inertia), _CmdR) * 0.9;
									//_CurV = Clamp(_CurV + (_CurR * iDeltaT), _MinV, _MaxV);

									//if((_CurR > 0 && _CurV >= _MaxV) || (_CurR < 0 && _CurV <= _MinV)) _CurR = -_CurR * this.Rebound;

									//if(this.IsDebug)
									//{
										//gAlgoCns.WriteLine();
										//gAlgoCns.WriteLine(["VV", {Type : "ProgressBar", CommValue : _CmdV,  CurrValue : _CurV,  Min : 0}]);
										
										//gAlgoCns.WriteLine(["ValE", _ValE]);
										//gAlgoCns.WriteLine(["RatE", _RatE]);
										//gAlgoCns.WriteLine(["RatD", _RatD]);
										//gAlgoCns.WriteLine(["CurR", _CurR]);
										//gAlgoCns.WriteLine(["CurV", _CurV]);
										//gAlgoCns.WriteLine(["CmdR", _CmdR]);
									//}
								//}
								//this.CurrValue = _CurV;
								//this.CurrRate  = _CurR;
							//},
							
						 },
					 }
				 },
				'ReactionControlSystem    : Buran.Component'  : 
				 {
					//~~ TODO;

					static : 
					{
						'Thruster' : 
						 {
							
						 }
					}
				 },
			 }
		 },
	}
});