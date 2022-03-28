"use strict";

stuff
({
	uses :
	[
		'Math',
		'Math.Geometry'
	],
		
	'UVS.Simulation' : 
	 {
		'Engine'                       : 
		 {
			Objects    : obj('Object.Collection', self),
			Time       : num(0),
			TimeScale  : num(1.0),
			LastUpdate : nil('Date'),
			LastDelta  : num(0),
			IsActive   : boo(true),

			//constructor : function(iAA)
			 //{
				//this.Objects    = new Object.Collection(this);
				//this.Time       = 0;
				//this.LastUpdate = undefined;
				//this.LastDelta  = 0;
				//this.IsActive   = true;
			 //},
			
			Update : function(iDeltaT)
			 {
				if(this.LastUpdate == undefined) this.LastUpdate = new Date().ValueOf() - 1;
				if(iDeltaT == undefined) iDeltaT = (Date.Now - this.LastUpdate) / 1000 * this.TimeScale;
				
				iDeltaT = Math.Min(iDeltaT, 0.1);

				this.Time       += iDeltaT;
				this.LastDelta   = iDeltaT;
				this.LastUpdate  = Date.Now;
				
				if(this.IsActive)
				{
					$.gPhysCns && gPhysCns.Clear();
					////$.gSysData && gAP.Clear();

					for(var _OO = this.Objects.Items, cO,Oi = 0; cO = _OO[Oi]; Oi++)
					{
						if(cO.Update)
						{
							cO.Update(iDeltaT);
						}
					}
				}
			 },
		 },
		'Object'                       : 
		 {
			ID        : str("--"),
			Parent    : nil('Object'),
			
			Position  : obj('Vector3'),
			Rotation  : obj('Quaternion'),
			Scale     : obj('Vector3',1,1,1),

			Children  : obj('Object.Collection', self),
			
			
			//constructor : function(iAA)
			 //{
				//this << iAA.ID        || "--";
				//this << iAA.Parent    || null;

				//this << iAA.Position  || new Vector3    (0,0,0);
				//this << iAA.Rotation  || new Quaternion (0,0,0,1);
				////this << iAA.Rotation  || new Rotation   (0,0,1,0);
				//this << iAA.Scale     || new Vector3    (1,1,1);


				//this.Children = new Object.Collection(this);
			 //},
			
			//this.Owner.Rotate(_Vec);
			LocalToGlobal : function(iVec)
			 {
				//return iVec.Rotate(this.Rotation);
				return iVec.Rotate(this.Rotation).Add(this.Position);
			 },
			GlobalToLocal : function(iVec)
			 {
				//return iVec.Rotate(this.Rotation.Inverse());
				return iVec.Add(this.Position.Inverse()).Rotate(this.Rotation.Inverse());
			 },

			static : 
			 {
				'Collection : PrivateCollection' : {},
			 }
		 },
		'DynamicObject : Object'       : 
		 {
			Mass      : obj('Mass'),
			Velocity  : obj('Velocity'),
			Forces    : obj('Force.Collection'),
			
			constructor      : function(iAA)
			 {
				this.Mass     = typeof(iAA.Mass) == "number" ? new Mass(iAA.Mass) : iAA.Mass || new Mass(1);
				this.Velocity = new Velocity();
				this.Forces   = new Force.Collection(this, iAA.Forces);
			 },

			OnBeforeUpdate   : undefined,
			OnAfterUpdate    : undefined,

			Update           : function(iDeltaT$num)
			 {
				gPhysCns.WriteLine(["Obj.Pos   ", this.Position]);
				gPhysCns.WriteLine(["Obj.Rot   ", this.Rotation]);
				gPhysCns.WriteLine();
				
				if(this.OnBeforeUpdate) this.OnBeforeUpdate(iDeltaT);
				{
					this.ApplyForces (iDeltaT);
					this.ApplyMotion (iDeltaT);
				}
				if(this.OnAfterUpdate) this.OnAfterUpdate(iDeltaT);

				gPhysCns.Enabled = true;
				if(this.Data) this.Data.Update();
			 },
			
			ApplyForces      : function(iDeltaT)
			 {
				var _Mass     =  this.Mass;
				var _InvMass  = _Mass.Inverted;
				var _InvInerV = _InvMass.Distribution.MultiplyScalar(_InvMass.Value);

				var _GloP     =  this.Position;
				var _GloR     =  this.Rotation;
				var _InvGloP  = _GloP.Inverse();
				var _InvGloR  = _GloR.Inverse();
				

				var _AccR, _TotMom = new Momentum;
				{
					if(iDeltaT) for(var _OwnFF = this.Forces.Items, cForce,Fi = 0; cForce = _OwnFF[Fi]; Fi++)
					{
						var cForceIsWeak  = Abs(cForce.Factor) < 1e-9; if(cForceIsWeak) continue;
						var cNeedsIntegra = cForce.ProduceMomentum.length == 0; //~~ Specified iDeltaT argument denotes 'custom (or no) integration' intension (e.g: rigid body impact);

						if(gPhysCns.Enabled = !/^\s*~/.test(cForce.ID))
						{
							gPhysCns.WriteLine("+ " + cForce.ID + " ----------------------");
						}

						var cMom = cForce.ProduceMomentum(iDeltaT); if(!cMom) continue;
						{
							var _MomLocP = (cMom.Position ? this.GlobalToLocal(cMom.Position) : cForce.Position).Subtract(_Mass.Center);
							var _MomLocR = (cMom.Rotation ? _InvGloR.Multiply(cMom.Rotation)  : cForce.Rotation);

							var _PriLinV = cMom.Linear, _PriLinL = _PriLinV.Length, _SecAngV = undefined, _SecAngL; if(_PriLinL != 0)
							{
								_PriLinV.Rotate(_MomLocR, self);

								if(_MomLocP.Length != 0)
								{
									_SecAngV = Vector3.Cross(_MomLocP, _PriLinV);
									_SecAngL = _SecAngV.Length;
								}
							}

							var _PriAngV = cMom.Angular, _PriAngL = _PriAngV.Length, _SecLinV = undefined, _SecLinL; if(_PriAngL != 0)
							{
								_PriAngV.Rotate(_MomLocR, self);
							}
							
							if(_SecLinV) _PriLinV.Add(_SecLinV, self);
							if(_SecAngV) _PriAngV.Add(_SecAngV, self);
							
							cMom.Linear  = _PriLinV.Rotate(_GloR);
							cMom.Angular = _PriAngV;

							if(cNeedsIntegra)      cMom.MultiplyScalar(iDeltaT, self);
							if(cForce.Factor != 1) cMom.MultiplyScalar(cForce.Factor, self);
						}

						if(isNaN(cMom.Linear.Length) || isNaN(cMom.Angular.Length)) debugger;
						_TotMom.Add(cMom);
					}
					_AccR = _TotMom.Accelerate(this);
				}

				if((iDeltaT || 0) == 0) iDeltaT = 1e-12;
				
				this.Velocity.Acceleration.Jerk .Set(_AccR.Subtract(this.Velocity.Acceleration.MultiplyScalar(iDeltaT)));
				this.Velocity.Acceleration      .Set(_AccR.MultiplyScalar(1 / iDeltaT));
				this.Velocity                   .Set(this.Velocity.Add(_AccR));
			 },
			ApplyMotion      : function(iDeltaT)
			 {
				var _Transform = this.PredictTransform(iDeltaT);

				this.Position = _Transform.Position;
				this.Rotation = _Transform.Rotation;
			 },

			PredictTransform : function(iDeltaT, iNestO$obj, oData$obj)
			 {
				var _OwnerP = this.Position.Add(this.Velocity.Linear.MultiplyScalar(iDeltaT));
				var _OwnerR = Quaternion.FromRotationVector(this.Velocity.Angular.MultiplyScalar(iDeltaT)).Multiply(this.Rotation);//, self);
				
				oData =
				(
					iNestO == undefined ? {Position : _OwnerP, Rotation : _OwnerR}
					:
					{
						Position : _OwnerP.Add      (iNestO.Position.Rotate(_OwnerR)),
						Rotation : _OwnerR.Multiply (iNestO.Rotation)
					}
				);
				return oData;
			 },
		 },
		
		'Mass'                         : 
		 {
			Value        : num(1),
			Center       : obj('Vector3',0,0,0),

			Distribution : obj('Vector3',1,1,1),
			Inverted     : obj('Mass.Inverted'),

			constructor  : function(iValue, iExtents, iCenter)
			 {
				this.Update(iValue, iExtents, iCenter);
			 },

			Update : function(iValue, iExtents, iCenter)
			 {
				this << iValue  || 1;
				this << iCenter || new Vector3;
				
				this.Distribution = Mass.GetMassDistribution(iExtents || new Vector3(1,1,1)).MultiplyScalar(this.Value);
				this.Inverted     = new Mass.Inverted(1 / this.Value,  new Vector3(1 / this.Distribution.X, 1 / this.Distribution.Y, 1 / this.Distribution.Z));
			 },

			 static : 
			 {
				'Inverted' : 
				 {
					Value        : num(1),
					Distribution : obj('Vector3'),

					constructor : function(iValue, iDistribution)
					{
						this << iValue        || 1;
						this << iDistribution || new Vector3;
					}
				 },
				GetMassDistribution : function(iExtents)
				 {
					//~~ I.x = m/12 * (y*y + z*z);

					return new Vector3
					(
						1 / 12 * ((iExtents.Y * iExtents.Y) + (iExtents.Z * iExtents.Z)),
						1 / 12 * ((iExtents.X * iExtents.X) + (iExtents.Z * iExtents.Z)),
						1 / 12 * ((iExtents.Y * iExtents.Y) + (iExtents.X * iExtents.X))
					);
				 }
			 }
		 },
		'Force'                        : 
		 {
			ID         : str("--"),
			Factor     : num(1),
			Position   : obj('Vector3'),
			Rotation   : obj('Quaternion'),
			Owner      : nil('DynamicObject'),

			LocalToOwner    : function(iVec)
			 {
				return this.Rotation ? iVec.Rotate(this.Rotation) : iVec.Clone();
			 },
			OwnerToLocal    : function(iVec)
			 {
				return this.Rotation ? iVec.Rotate(this.Rotation.Inverse()) : iVec.Clone();
			 },

			ProduceMomentum : function(iDeltaT, oMom)
			 {
				return undefined;
			 },

			static : 
			 {
				'Collection : PrivateCollection' : {},
			 }
		 },
		'Momentum'                     : 
		 {
			Position : obj('Vector3'),
			Rotation : obj('Quaternion'),
			Linear   : obj('Vector3'),
			Angular  : obj('Vector3'),

			constructor    : function(i1,i2,i3, i4,i5,i6, i7,i8,i9, i10,i11,i12,i13)
			 {
				var iLinV, iAngV, iPosV, iRotQ;
				{
					switch(arguments.length)
					{
						case 12 : iPosV = new Vector3(i7,i8,i9); iRotQ = new Quaternion(i10,i11,i12,i13);
						case  6 : iLinV = new Vector3(i1,i2,i3); iAngV = new Vector3(i4,i5,i6);
						          break;

						case  4 : iRotQ = i4;
						case  3 : iPosV = i3;
						case  2 : iAngV = i2;
						case  1 : iLinV = i1;

						case  0 : break;
						
						default : throw "Invalid argument count";
					}
				}

				this.Position = iPosV || null;
				this.Rotation = iRotQ || null;
				this.Linear   = iLinV ? iLinV.Clone() : new Vector3;
				this.Angular  = iAngV ? iAngV.Clone() : new Vector3;
			 },
			
			Add            : function(iMom)
			 {
				iMom.Linear  && this.Linear .Add(iMom.Linear,  self);
				iMom.Angular && this.Angular.Add(iMom.Angular, self);
			 },
			MultiplyScalar : function(iScalar)
			 {
				this.Linear  && this.Linear .MultiplyScalar(iScalar, self);
				this.Angular && this.Angular.MultiplyScalar(iScalar, self);

				return this;
			 },
			Accelerate     : function(iObj, oAcc)
			 {
				if(!oAcc) oAcc = new Acceleration;
				{
					oAcc.Linear  = this.Linear .MultiplyScalar(iObj.Mass.Inverted.Value);
					oAcc.Angular = this.Angular.Multiply      (iObj.Mass.Inverted.Distribution).Rotate(iObj.Rotation);
				}
				return oAcc;
			 },
		 },
		
		'RateOfChange'                 : 
		 {
			Linear  : obj('Vector3'),
			Angular : obj('Vector3'),

			Set            : function(i1$Vector3_RateOfChange, i2$Vector3)
			 {
				switch(arguments.length)
				{
					case 2  : this.Linear = i1;        this.Angular = i2;         break;
					case 1  : this.Linear = i1.Linear; this.Angular = i1.Angular; break;

					default : throw "WTF";
				}
			 },
			Clone          : function(oRate)
			 {
				oRate = new RateOfChange;
				{
					oRate.Linear  = this.Linear.Clone();
					oRate.Angular = this.Angular.Clone();
				}
				return oRate;
			 },

			Add            : function(iRate,   oRate)
			 {
				oRate << this || new RateOfChange;
				{
					oRate.Linear  = this.Linear .Add(iRate.Linear);
					oRate.Angular = this.Angular.Add(iRate.Angular);
				}
				return oRate;
			 },
			Subtract       : function(iRate,   oRate)
			 {
				oRate << this || new RateOfChange;
				{
					oRate.Linear  = this.Linear .Subtract(iRate.Linear);
					oRate.Angular = this.Angular.Subtract(iRate.Angular);
				}
				return oRate;
			 },
			MultiplyScalar : function(iScalar, oRate)
			 {
				oRate << this || new RateOfChange;
				{
					oRate.Linear  = this.Linear .MultiplyScalar(iScalar);
					oRate.Angular = this.Angular.MultiplyScalar(iScalar);
				}
				return oRate;
			 },
			Rotate         : function(iQuat,   oRate)
			 {
				oRate << this || new RateOfChange;
				{
					oRate.Linear  = this.Linear .Rotate(iQuat);
					oRate.Angular = this.Angular.Rotate(iQuat);
				}
				return oRate;
			 },
		 },
		'Velocity      : RateOfChange' : { Acceleration : obj('Acceleration') },
		'Acceleration  : RateOfChange' : { Jerk         : obj('Jerk')         },
		'Jerk          : RateOfChange' : {                                    },
	 }
});
