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
		'Aircraft : Vehicle'  :
		 {
			Data : obj('Aircraft.Data', {Source : self}),

			constructor : function(iAA)
			 {
				this.Data       = new Aircraft.Data({Source : this});

				this.Elevator   = new Aircraft.Airfoil      ({ID : "Elevator",  Factor : 1, Lift : 3000, Drag : 100,  Position : new Vector3(   0, -10.7, -1.2)});
				this.AileronL   = new Aircraft.Airfoil      ({ID : "AileronL",  Factor : 1, Lift : 3000, Drag : 100,  Position : new Vector3(-7.2,  -7.5, -1.2)});
				this.AileronR   = new Aircraft.Airfoil      ({ID : "AileronR",  Factor : 1, Lift : 3000, Drag : 100,  Position : new Vector3(+7.2,  -7.5, -1.2)});
				this.Rudder     = new Aircraft.Airfoil      ({ID : "Rudder",    Factor : 1, Lift : 3000, Drag : 500,  Position : new Vector3(-0.1, -13.0, +8.3)});

				this.MainGearL  = new Aircraft.LandingGear  ({ID : "MainGearL", Position : new Vector3(-1,  +1, -1)});
				this.MainGearR  = new Aircraft.LandingGear  ({ID : "MainGearR", Position : new Vector3(+1,  +1, -1)});
				this.TailGear   = new Aircraft.LandingGear  ({ID : "TailGear",  Position : new Vector3( 0,  -3, -0.5)});

				this.Engine     = new Aircraft.JetEngine    ({ID : "Eng1", Factor : 0,  Position : new Vector3(0,0,0), Rotation : Quaternion.Rotated(0,0,0)});

				if(1)
				{
					this.Forces.Add(new Forces.Gravity({ID : "Gravity"}));

					this.Forces.Add(this.NoseGear);
					this.Forces.Add(this.MainGearL);
					this.Forces.Add(this.MainGearR);

					this.Forces.Add(this.Elevator);
					this.Forces.Add(this.AileronL);
					this.Forces.Add(this.AileronR);
					this.Forces.Add(this.Rudder);

					this.Forces.Add(this.Engine);
				}
			 },

			static : 
			 {
				'Airfoil      : Force' : 
				 {
					Lift     : num, //~~;
					Drag     : num, //~~;
					Aspect   : num, //~~ Wing span/chord;
					Camber   : num, //~~;

					constructor : function(iAA)
					{
						this << iAA.Lift   || 1000;
						this << iAA.Drag   || this.Lift;
						this << iAA.Aspect || 5;
						this << iAA.Camber || 0;
					},

					ProduceMomentum : function()
					{
						//var _Lift = 
						//if(this.Drag == undefined) 
					//return;
						var _Alt     = this.Owner.Data.BAlt;
						var _WindV   = this.Owner.Data.Wind;

						//if(isNaN(_Alt)) debugger;
						//var _WindV   = new Vector3;//	(0,1,0).Rotate(Quaternion.Rotated(0, 0, -this.Owner.Data.Attitude.HdgFix + (36 * DTR))).MultiplyScalar(10);
						var _LinVelV = this.Owner.Velocity.Linear.Subtract(_WindV);
						//_LinVelV.Length
						//.MultiplyScalar(Planets.Earth.Atmosphere.GetIAS(this.Owner.Data.BAlt));
						
						

						//var _Sfc2AirV = this.Owner.Velocity.Linear.Rotate(this.Owner.Rotation.Inverse().Multiply(this.Rotation.Inverse()));
						var _Veh2AirV  = _LinVelV.Rotate(this.Owner.Rotation.Inverse());
						var _Sfc2AirV  = _Veh2AirV.Rotate(this.Rotation.Inverse());
						//var _Sfc2AirV = this.Owner.Velocity.Linear.Rotate(this.Rotation.Inverse().Multiply(this.Owner.Rotation.Inverse()));
						var _HrzA      = Atan2(_Sfc2AirV.X, _Sfc2AirV.Y);
						var _AoA       = Abs(Atan2(_Sfc2AirV.Z, Sqrt((_Sfc2AirV.X * _Sfc2AirV.X) + (_Sfc2AirV.Y * _Sfc2AirV.Y))));
						
						var _AoALiftF  = Sin(_AoA * 2);
						var _AoADragF  = Sin(_AoA);
						//var _CamberF   = ;
						var _SlideF    = (Abs(Cos(_HrzA)) * this.Aspect) + Abs(Sin(_HrzA)); //~~ Rectangular wing;
						
						var _SpeedF    = Pow(Planets.Earth.Atmosphere.GetIAS(_Sfc2AirV.Length, _Alt) * 0.008, 2);

						var _CamberF   = 0; //~~ AoA = -5...+10;
						var _AirflowF  = 0; //~~ AoA = 10..20;
						var _GndEffF   = 0; //~~ this.Chord, Alt, pitch moment;

						//var _AoAF      = 
						

						var _Lift      = this.Lift * (_AoALiftF + _AirflowF + _CamberF + _GndEffF) * _SpeedF * _SlideF * 1.0;
						var _Drag      = this.Drag *  _AoADragF                                    * _SpeedF * _SlideF * 0.5; //~~ slide?;
						
						var _LiftV;
						{
							var _AirPerpV = _Sfc2AirV.Cross(_Sfc2AirV.Set(null,null,0)).Inverse();

							_LiftV = _Sfc2AirV.Cross(_AirPerpV).Normalize().MultiplyScalar(_Lift);
						}
						var _DragV     = _Sfc2AirV.Inverse().Normalize().MultiplyScalar(_Drag);

						var _LinForceV = Vector3.Add(_LiftV, _DragV);
						var _AngForceV = new Vector3;
						
						
						gPhysCns.WriteLine();
						gPhysCns.WriteLine(["- LinV.Len ",  _LinVelV.Length]);
						gPhysCns.WriteLine(["- Sfc2AirV ",  _Sfc2AirV]);
						gPhysCns.WriteLine(["- SpeedF   ",  _SpeedF]);
						gPhysCns.WriteLine(["- SlideF   ",   _SlideF]);
						gPhysCns.WriteLine(["- AoA      ",  _AoA * RTD]);
						//gPhysCns.WriteLine(["- AoADragF ",  _AoADragF]);
						//gPhysCns.WriteLine(["- IsRev    ",   _IsReversed]);
						//gPhysCns.WriteLine(["- SlipA    ",   RadToDeg(_SlipA)]);
						gPhysCns.WriteLine(["- Lift     ",  _Lift]);
						gPhysCns.WriteLine(["- Drag     ",  _Drag]);
						gPhysCns.WriteLine(["- LiftV    ",  _LiftV]);
						gPhysCns.WriteLine(["- DragV    ",  _DragV]);
						gPhysCns.WriteLine(["--LinFrcV  ",  _LinForceV]);
						
						gPhysCns.WriteLine();

						//gSysData.WriteLine([_ForceV]);

						return new Momentum(_LinForceV, _AngForceV);//, null, null, Quaternion.Identity);
					},
				 },
				'RocketEngine : Force' :
				 {
					Power : num(1000),

					ProduceMomentum : function()
					{
						//var _Power = this.Power * Clamp(-Scale01((this.Owner.Data.IAS * 3.6) - 300, 0));
						var _Power = this.Power;
						return new Momentum(new Vector3(0, _Power, 0));
					}
				 },
				'LandingGear  : Force' : 
				 {
					Stiffness   : num(1),
					Damping     : num(1),
					Friction    : num(1),
					TurnMass    : num(1), //~~ TODO: vehicle pitch moment due to wheel spinup on touchdown;
					AngSpeed    : num(0),

					Brake       : num(0),
					
					Compression : {get : function(){return Clamp(0.3 - this.Owner.PredictTransform(0, this).Position.Z, 0, 1)}},
					Rpm         : {get : function(){throw "NI"}},

					ProduceMomentum : function(iDeltaT)
					{
						var _MassV      = this.Owner.Mass.Value;
						
						var _GloT1      = this.Owner.PredictTransform(0,       this);
						var _GloT2      = this.Owner.PredictTransform(iDeltaT, this);

						var _CompF      = this.Compression;

						var _VrtF;
						{
							var _Z1         = _GloT1.Position.Z;
							var _Z2         = _GloT2.Position.Z; if(_Z2 > 0) return;
							var _ZVel       = _Z2 - _Z1;
							var _Resistance = this.Stiffness * Max(0,-_Z1);// * iDeltaT;// * iDeltaT;//Magic(1 + Clamp(1 - _ToGndDist, 0, 1), 30) * iDeltaT;
							var _Damping    = this.Damping   * _ZVel;

							_VrtF           = new Vector3(0,0, (_Resistance - _Damping) * _MassV * 50 * iDeltaT);

							gPhysCns.WriteLine("----------------------------------");
							gPhysCns.WriteLine(["_Z1", _Z1]);
							gPhysCns.WriteLine(["_CompF", _CompF]);

						}
						var _HrzF;
						{
							var _LinVel   = _GloT2.Position.Subtract(_GloT1.Position);
							var _Whl2GndV = _LinVel.Rotate(_GloT1.Rotation.Inverse());
							//var _Whl2GndV = ;

							var _SideF  = new Vector3(-Clamp(_Whl2GndV.X * this.Friction * _CompF * 100), 0, 0).Rotate(_GloT1.Rotation).MultiplyScalar(_MassV);
							var _BrakeF = Vector3.Clamp(this.Owner.Velocity.Linear).MultiplyScalar(-_MassV * this.Brake);
							
							
							_HrzF = 0 ? new Vector3 : Vector3.Add(_SideF, _BrakeF).MultiplyScalar(iDeltaT, self);
						}
						return new Momentum(Vector3.Add(_VrtF, _HrzF), null, null, Quaternion.Identity);
					}
				 },
				

				'Data : Vehicle.Data'  : 
				 {
					//constructor : function custom(iObj)
					 //{
						//this.overriden(iObj);

						//this.Update();
					 //},
					//constructor : function()
					 //{
						//this.Update();
					 //},
					Update : function()
					 {
						this.overriden.Update();

						var _Veh  = this.Source;
						var _VehP = _Veh.Position;
						var _VehR = _Veh.Rotation;
						var _VehV = _Veh.Velocity.Linear;

						


						var _ActV = this;
						///var _HisV = 1 ? UVS.Data.GetNearestEntry(_VehP.Z).Value : this;
						var _HisV = 1 ? UVS.Data.GetNearestEntry(_VehP.Z > 5000 ? _VehP.Set(0,0,null) : _VehP.Set(0,null,0)).Value : this;
						

						//debugger;

						this.KinDynRatio = 0;/// (this.Source.Control ? this.Source.Control.Inputs.Balance : 0) * Clamp01(Scale01(_VehP.Z, 500, 1000));

						
						this.BAlt = _VehP.Z - 4.5; //~~Mix(_VehP.Z - 4.5, _HisV.Position.Z, this.KinDynRatio);
						
						this.RAlt = this.BAlt;
						this.VSpd = Mix(_VehV.Z, _HisV.VSpd, this.KinDynRatio);







						//this.Wind = new Vector3(0,1,0).Rotate(Quaternion.Rotated(0, 0, +this.Attitude.HdgFix)).MultiplyScalar(10 + (Scale01(this.BAlt, 0, 20000) *  20));
						//~~this.Wind = new Vector3(0,1,0).Rotate(Quaternion.Rotated(0, 0, this.Attitude.HdgFix - (36 * DTR))).MultiplyScalar();
						//this.Wind = new Vector3(0,1,0).Rotate(Quaternion.Rotated(0, 0, this.Attitude.HdgFix - (36 * DTR))).MultiplyScalar(-50);
						//this.Wind = new Vector3(0,1,0).Rotate(Quaternion.Rotated(0, 0, this.Attitude.HdgFix - (36 * DTR))).MultiplyScalar(10 + (Clamp(Scale01(this.BAlt, 16000, 14000), 0,1) * 40));
						//this.Wind = new Vector3(0,1,0).Rotate(Quaternion.Rotated(0, 0, this.Attitude.HdgFix - (36 * DTR))).MultiplyScalar(0 + (Clamp(Scale01(this.BAlt, 20000, 5000), 0,1) * 20));
						this.Wind;
						{
							var _WindDir =  new Vector3(0,1,0).Rotate(Quaternion.Rotated(0, 0, +36 * DTR, "ZXY"));
							//var _WindSpd = 5 + ((1 - Abs(Clamp(Scale(this.BAlt - 8000, 6000)))) * 40); //~~;
							//var _WindSpd = (10 * Scale01(this.BAlt, 20000, 0)) + ((1 - Abs(Clamp(Scale(this.BAlt - 10000, 6000)))) * 40); //~~;
							var _WindSpd = (10 * Scale01(this.BAlt, 20000, 0)) + ((1 - Abs(Clamp(Scale(this.BAlt - 8000, 8000)))) * 50); //~~;

							
							//~~this.Wind = _WindDir.MultiplyScalar(_WindSpd);
							this.Wind = new Vector3;


							if($.gWindV) this.Wind.Add($.gWindV, self);


							this.Wind.MultiplyScalar(Clamp01(Scale01(_Veh.Velocity.Linear.Length, 5, 50)), self);
							//this.Wind = new Vector3(Random() - 0.5, Random() - 0.5, Random() - 0.1).MultiplyScalar(10);//_WindDir.MultiplyScalar(_WindSpd);
						}
						
						//this.TAS  = _VehV.
						

						//var _TasV = ;
						var _InAirV = _VehV.Subtract(this.Wind);
						var _TAS    = _InAirV.Dot(new Vector3(0,1,0).Rotate(_VehR));
						//var _TAS    = _InAirV.Dot(new Vector3(0,1,0).Rotate(_VehR));



						this.IAS  = Mix(Planets.Earth.Atmosphere.GetIAS   (_TAS, this.BAlt) * 1.0, _HisV.IAS, this.KinDynRatio);
						this.MSpd = Mix(Planets.Earth.Atmosphere.GetMachs (_TAS, this.BAlt) * 1.0, _HisV.MSpd, this.KinDynRatio);
						//this.MSpd = Planets.Earth.Atmosphere.GetMachs (_VehV.Length, this.BAlt) * 1.0;
					

						//this.Vehicle..Planets.Earth.Atmosphere.GetIAS(this.Source.Velocity.Linear.Length, this.Source.Position.Z);

						//~~var _LinV = _VehV.Rotate(_VehR.Inverse());
						var _LinV = _InAirV.Rotate(_VehR.Inverse());
						this.AoA  = -Atan2(_LinV.Z,_LinV.Y) * RTD;


						//this.Heading = 0;
						//this.Bank    = 0;
						//this.Pitch   = 0;

						//this.Speeds.IAS     = 0;
						//this.Speeds.TAS     = 0;
						//this.Speeds.Machs   = 0;

						//this.Airspeed = 0;

						//this.Altitude = 0;
						//this.VSpeed   = 0;


						//this.Angles.Heading = 0;
						//this.Angles.Bank    = 0;
						//this.Angles.Pitch   = 0;

						//this.Speeds.IAS     = 0;
						//this.Speeds.TAS     = 0;
						//this.Speeds.Machs   = 0;

						////this.Airspeed = 0;

						//this.Altitude = 0;
						//this.VSpeed   = 0;

						if(isNaN(this.BAlt) || isNaN(this.MSpd) || isNaN(this.IAS)) debugger;
					 }
				 },
			 }
		 },
		'Aircrafts' : 
		 {
			'MG10 : Aircraft' : {},
			'MG11 : Aircraft' : {},
		 },
	 }
});