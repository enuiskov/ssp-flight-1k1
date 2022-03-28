"use strict";

stuff
({
	uses :
	[
		'Math',
		'Math.Geometry',
		//'UVS.Simulation',
	],
	
	'UVS.Simulation' : 
	 {
		'Planets' :
		 {
			'Earth' : 
			 {
				'Atmosphere' :
				 {
					PressureAtSeaLevel : 101325,
					DensityAtSeaLevel  : 1.225,

					GetAirPressure         : function(iAlt)
					 {
						return this.PressureAtSeaLevel * this.GetAirPressureFraction(iAlt);
					 },
					GetAirPressureFraction : function(iAlt)
					 {
						//~~return Pow(1 - Min(iAlt / 100000, 1), 12);
						return Pow(1 - Min(iAlt / 100000, 1), 12);
						
					 },
					
					GetAirDensity            : function(iAlt)
					 {
						return this.DensityAtSeaLevel * this.GetAirDensityFraction(iAlt);
					 },
					GetAirDensityFraction : function(iAlt)
					 {
						return Pow(1 - Min(iAlt / 100000, 1), 10.2);
						//return (Pow(iAlt / 1e5, 12), 1);
					 },
					
					
					GetIAS                 : function(iSpd, iAlt)
					 {
						var _KmHs = iSpd * (60 * 60 / 1000);
						//var _ShaCoef = Pow(2.3, iAlt / 1e4);
						var _ShaCoef = Pow(2.1, iAlt / 1e4);
						return _KmHs * this.GetAirPressureFraction(iAlt) * _ShaCoef;
					 },

					
					GetIASKnots            : function(iSpd, iAlt)
					 {
						var _Knots = iSpd * (60 * 60 / 1000 / 1.85);
						return this.GetIAS(_Knots, iAlt);
					 },
					GetMachs                 : function(iSpd, iAlt)
					 {
						//var _ShaCoef = Pow(2, iAlt / 1e4); //~~?;
						//var _Mach1 = 310 * (Scale01(iAlt / 20000, ));
						//var _Mach1 = 320 - (Min(iAlt / 10000, 1.1) * 40);

						//var _Mach1 = 343 - (Min(iAlt / 10000, 1.1) * 30);
						//var _Mach1 = 344 - (Min(iAlt / 10000, 1.1) * 30);
						//var _Mach1 = 340 - (Magic(iAlt, 20000, 0) * 40);
						var _Mach1 = 340 - (Pow(Max(iAlt,0) / 20000, 0.2) * 35);
						//Math. * 45
						//debugger;

						return iSpd / _Mach1;
					 },

				 }
			 }
		 },

		'Vehicle : DynamicObject' :
		 {
			Data : obj('Vehicle.Data', {Source : self}),

			/**
				iObj.Data.Accelerometer.NZ
			*/

			static : 
			{
				'Data'      : 
				 {
					Source        : obj('DynamicObject'),
					Velocity      : obj('Velocity'),
					Attitude      : obj,
					Accelerometer : obj,
					
					constructor   : function(iAA)
					 {
						this.Source   = iAA.Source;
						this.Velocity = new Velocity();
						this.Attitude = new function Attitude()
						{
							this.HdgFix  = iAA.HdgFix || 0;
							this.Heading = 0;
							this.Pitch   = 0;
							this.Bank    = 0;
						};
						this.Accelerometer = new Vector3();
						
						this.Update();
					 },
					Update        : function()
					 {
						var _InvR = this.Source.Rotation.Inverse();

						var _VehV = this.Velocity                   = this.Source.Velocity.Clone();
						var _VehA = this.Velocity.Acceleration      = this.Source.Velocity.Acceleration.Clone();
						var _VehJ = this.Velocity.Acceleration.Jerk = this.Source.Velocity.Acceleration.Jerk.Clone();
						{
							_VehV.Rotate(_InvR, self); _VehV.Angular.MultiplyScalar(RTD,self);
							_VehA.Rotate(_InvR, self); _VehA.Angular.MultiplyScalar(RTD,self);
							_VehJ.Rotate(_InvR, self); _VehJ.Angular.MultiplyScalar(RTD,self);
						}

						Attitude : 
						{
							var _EulerA = EulerAngles.FromQuaternion(this.Source.Rotation, "ZXY");
							//debugger;

							this.Attitude.Heading = ((360 + this.Attitude.HdgFix - (_EulerA.Z * RTD)) % 360);
							this.Attitude.Pitch   = _EulerA.X * RTD;
							this.Attitude.Bank    = _EulerA.Y * RTD;
							
						}
						Accelerometer :
						{
							var _ConG = 9.8, _CurG = _ConG;
							var _GraV = new Vector3(0,0,-_CurG).Rotate(this.Source.Rotation.Inverse());

							this.Accelerometer = this.Velocity.Acceleration.Linear.Subtract(_GraV).MultiplyScalar(1 / _CurG);
						}
					 }
				 },
				'System'                                   : 
				 {
					Vehicle   : obj('Vehicle'),
					Interface : obj('Vehicle.System.Interface'),

					Update    : function(iDeltaT){throw "NI"},
					
					static : 
					{
						'Interface' : 
						 {
							Input  : obj,
							Output : obj,
						 }
					}
				 },
			}
		 },
		//'Weapon : DynamicObject' : 
		 //{
		 
		 //},
		//'Bomb : Weapon' :
		 //{
		 
		 //},
		//'Shaitan : Missile' : 
		 //{
		 
		 //},
	 }
});