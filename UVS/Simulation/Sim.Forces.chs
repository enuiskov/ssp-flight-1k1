"use strict";

stuff
({
	uses :
	[
		'Math',
		'Math.Geometry',
		'UVS.Simulation',
	],
	
	'UVS.Simulation.Forces' : 
	 {
		'Gravity : Force' :
		 {
			ProduceMomentum : function()
			{
				return new Momentum
				(
					new Vector3(0,0,-9.8 * this.Owner.Mass.Value),
					null,
					this.Owner.LocalToGlobal(this.Owner.Mass.Center),
					Quaternion.Identity
				);
			},
		 },
		'GlobalTorque : Force' :
		 {
			Axis : obj('Vector3', 0,0,1),

			ProduceMomentum : function()
			{
				return new Momentum(null, this.Axis.MultiplyScalar(this.Owner.Mass.Value * 1), null, Quaternion.Identity);
			},
		 },
		'LocalTorque : Force' :
		 {
			ProduceMomentum : function()
			{
				return new Momentum(null, new Vector3(0,0,1).MultiplyScalar(this.Owner.Mass.Value * 1));
			},
		 },
		
		'AirDrag : Force' :
		 {
			ProduceMomentum : function()
			{
				//var _Mul = this.Owner.Mass.Value * this.AirDensity * 0.01;

				//return new Momentum
				//(
					//this.Owner.Velocity.Linear .Inverse().MultiplyScalar(_Mul),
					//this.Owner.Velocity.Angular.Inverse().MultiplyScalar(_Mul),
					//null,
					//Quaternion.Identity
				//);
			},
			get AirDensity()
			{
				return World.Planets.Earth.Atmosphere.GetAirPressureFraction(this.Owner.Position.Z);
			}
		 },
		
		
		'Wind : Force' :
		 {
			ProduceMomentum : function()
			{
				return new Momentum(new Vector3(5,5,0), null, null, Quaternion.Identity);
			},
		 },
	 }
});