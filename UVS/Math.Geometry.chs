"use strict";

stuff
({
	uses :
	[
		'Math',
	],

	'Math.Geometry' : 
	 {
		'Vector2'     : 
		 {
			X : num(0),
			Y : num(0),
			
			constructor : function(iX,iY)
			 {
				this << iX || 0;
				this << iY || 0;
			 },
		 },
		'Vector3'     : 
		 {
			X : num(0),
			Y : num(0),
			Z : num(0),
			
			constructor : function Vector3(iX,iY,iZ)
			 {
				this << iX || 0;
				this << iY || 0;
				this << iZ || 0;
			 },
			
			Length          : {get : function()    {return Sqrt((this.X * this.X) + (this.Y * this.Y) + (this.Z * this.Z));}},
			
			Set             : function(iX,iY,iZ, oVec)
			 {
				oVec << this || this.Clone();
				{
					if(iX != undefined) oVec.X = iX;
					if(iY != undefined) oVec.Y = iY;
					if(iZ != undefined) oVec.Z = iZ;
				}
				return oVec;
			 },
			Normalize       : function(oVec)
			 {
				oVec << this || this.Clone();
				{
					var _Len = this.Length;
					this.MultiplyScalar(_Len == 0 ? 0 : 1 / _Len, oVec);
				}
				return oVec;
			 },
			
			Add             : function(iVec, oVec)
			 {
				oVec << this || new Vector3;
				{
					oVec.X = this.X + iVec.X;
					oVec.Y = this.Y + iVec.Y;
					oVec.Z = this.Z + iVec.Z;
				}
				return oVec;
			 },
			Subtract        : function(iVec, oVec)
			 {
				oVec << this || new Vector3;
				{
					oVec.X = this.X - iVec.X;
					oVec.Y = this.Y - iVec.Y;
					oVec.Z = this.Z - iVec.Z;
				}
				return oVec;
			 },
			Inverse         : function(oVec)
			 {
				return this.MultiplyScalar(-1, oVec);
			 },
			Multiply        : function(ibVec, oVec)
			 {
				return Vector3.Multiply(this, ibVec, oVec);
			 },
			MultiplyScalar  : function(iScalar$num, oVec)
			 {
				oVec << this || new Vector3;
				{
					oVec.X = this.X * iScalar;
					oVec.Y = this.Y * iScalar;
					oVec.Z = this.Z * iScalar;
				}
				return oVec;
			 },

			Cross           : function(ibVec, oVec)
			 {
				return Vector3.Cross(this, ibVec, oVec);
			 },
			Dot             : function(ibVec, oVec)
			 {
				return Vector3.Dot(this, ibVec, oVec);
			 },
			
			AngleTo         : function(iVec)
			 {
				var _Theta = this.Dot(iVec) / (this.Length * iVec.Length);
				return Acos(Clamp(_Theta));
			 },
			DistanceTo      : function(iVec)
			 {
				return this.Subtract(iVec).Length;
			 },
			
			Rotate          : function(iQua, oVec)
			 {
				oVec << this || this.Clone();
				return Vector3.ApplyQuaternion(this.X, this.Y, this.Z, iQua, oVec);
			 },
			LookAt          : function(iTgtV, iUpV, oQuat)
			 {
				throw "NI";

				oQuat << this || new Quaternion;
				{
					
				}
				return oQuat;
			 },

			Clone           : function(){return new Vector3(this.X,this.Y,this.Z)},
			ToString        : function(){return "(" + this.X.ToString2() + "," + this.Y.ToString2() + "," + this.Z.ToString2() + ")"},
			ToTHREE         : function(){return new THREE.Vector3(this.X,this.Y,this.Z)},

			static :
			 {
				Dot             : function(iaV, ibV, oDotP$num)
				 {
					return (iaV.X * ibV.X) + (iaV.Y * ibV.Y) + (iaV.Z * ibV.Z);
				 },
				Cross           : function(iaV, ibV, oVec)
				 {
					var _aX = iaV.X,  _bX = ibV.X,
						 _aY = iaV.Y,  _bY = ibV.Y,
						 _aZ = iaV.Z,  _bZ = ibV.Z;

					oVec << iaV || new Vector3;
					{
						oVec.X = (_aY * _bZ) - (_aZ * _bY);
						oVec.Y = (_aZ * _bX) - (_aX * _bZ);
						oVec.Z = (_aX * _bY) - (_aY * _bX);
					}
					return oVec;
				 },
				Add             : function(iaV, ibV, oVec)
				 {
					oVec << iaV || new Vector3;
					{
						oVec.X = iaV.X + ibV.X;
						oVec.Y = iaV.Y + ibV.Y;
						oVec.Z = iaV.Z + ibV.Z;
					}
					return oVec;
				 },
				Multiply        : function(iaV, ibV, oVec)
				 {
					oVec << iaV || new Vector3;
					{
						oVec.X = iaV.X * ibV.X;
						oVec.Y = iaV.Y * ibV.Y;
						oVec.Z = iaV.Z * ibV.Z;
					}
					return oVec;
				 },
				Mix             : function(iaV, ibV, iA$num, oVec)
				 {
					oVec << iaV || new Vector3;
					{
						oVec.X = (iaV.X * (1 - iA)) + (ibV.X * iA);
						oVec.Y = (iaV.Y * (1 - iA)) + (ibV.Y * iA);
						oVec.Z = (iaV.Z * (1 - iA)) + (ibV.Z * iA);
					}
					return oVec;
				 },

				ApplyQuaternion : function(iVecX, iVecY, iVecZ, iQua, oVec)
				 {
					var _InvX = +(iQua.W * iVecX) + (iQua.Y * iVecZ) - (iQua.Z * iVecY),
						 _InvY = +(iQua.W * iVecY) + (iQua.Z * iVecX) - (iQua.X * iVecZ),
						 _InvZ = +(iQua.W * iVecZ) + (iQua.X * iVecY) - (iQua.Y * iVecX),
						 _InvW = -(iQua.X * iVecX) - (iQua.Y * iVecY) - (iQua.Z * iVecZ);

					if(!oVec) oVec = new Vector3;
					{
						oVec.X = (_InvX * iQua.W) + (_InvW * -(iQua.X)) + (_InvY * -(iQua.Z)) - (_InvZ * -(iQua.Y));
						oVec.Y = (_InvY * iQua.W) + (_InvW * -(iQua.Y)) + (_InvZ * -(iQua.X)) - (_InvX * -(iQua.Z));
						oVec.Z = (_InvZ * iQua.W) + (_InvW * -(iQua.Z)) + (_InvX * -(iQua.Y)) - (_InvY * -(iQua.X));
					};
					return oVec;
				 },
				
				Clamp           : function(iVec, iLimV, oVec)
				 {
					if(!iLimV) iLimV = new Vector3(1,1,1);

					oVec << iVec || new Vector3;
					{
						oVec.X = Clamp(iVec.X, iLimV.X);
						oVec.Y = Clamp(iVec.Y, iLimV.Y);
						oVec.Z = Clamp(iVec.Z, iLimV.Z);
					}
					return oVec;
				 },
				
				Magnitude       : function(iVec, oVec)
				 {
					oVec << iVec || new Vector3;
					{
						oVec.X = Abs(iVec.X);
						oVec.Y = Abs(iVec.Y);
						oVec.Z = Abs(iVec.Z);
					}
					return oVec;
				 },
				ToTHREE         : function(iVec, oVec$ext){return new THREE.Vector3(iVec.X,iVec.Y,iVec.Z)},
				FromTHREE       : function(iVec$ext, oVec){return new Vector3(iVec.x,iVec.y,iVec.z)},

				FromString : function(iStr){var _StrM = iStr.match(/^\(([+-\d\.e]+),([+-\d\.e]+),([+-\d\.e]+)\)$/); return new Vector3(parseFloat(_StrM[1]),parseFloat(_StrM[2]),parseFloat(_StrM[3]))},
			 }
		 },
		'Quaternion'  : 
		 {
			X : num(0),
			Y : num(0),
			Z : num(0),
			W : num(1),

			Axis            : {get : function(oAxisV$Vector3){return new Vector3(this.X, this.Y, this.Z).Normalize(self);}},
			Angle           : {get : function(oAngle$num){return Acos(this.W) * 2}},
			
			constructor     : function Quaternion(iX,iY,iZ,iW)
			 {
				this << iX || 0;
				this << iY || 0;
				this << iZ || 0;
				this << iW || 1;
			 },
			
			Length          : {get : function(){return Sqrt((this.X * this.X) + (this.Y * this.Y) + (this.Z * this.Z) + (this.W * this.W))}},
			
			Inverse         : function (oQua)
			 {
				oQua << this || new Quaternion;
				{
					oQua.X = -this.X;
					oQua.Y = -this.Y;
					oQua.Z = -this.Z;
					oQua.W = +this.W;
				}
				return oQua;
			 },
			Normalize       : function (oQua)
			 {
				var _Len = this.Length, _InvL = 1 / this.Length; if(_Len == 0) throw "WTF: quaternion zero length";

				oQua << this || new Quaternion;
				{
					oQua.X = this.X * _InvL;
					oQua.Y = this.Y * _InvL;
					oQua.Z = this.Z * _InvL;
					oQua.W = this.W * _InvL;
				}
				return oQua;
			 },
			
			//Fraction        : function(iT, oQua)
			 //{
				//return Quaternion.Identity.Slerp(this, iT, oQua);
			 //},
			Slerp           : function(ibQua, iT, oQua)
			 {
				oQua << this || this.Clone();
				return Quaternion.Slerp(this, ibQua, iT, oQua);
			 },
			Add             : function(iRotV, oQua)
			 {
				oQua << this || this.Clone();
				return oQua.Multiply(Quaternion.FromRotationVector(iRotV), self);
			 },
			Multiply        : function(ibQua, oQua)
			 {
				var _aX = this.X,  _bX = ibQua.X,
					 _aY = this.Y,  _bY = ibQua.Y,
					 _aZ = this.Z,  _bZ = ibQua.Z,
					 _aW = this.W,  _bW = ibQua.W;

				//~~ ov = v1*w2 + v2*w1 + cross(v1,v2);
				//~~ ow = w1*w2 - dot(v1,v2);

				oQua << this || new Quaternion;
				{
					oQua.X = (_aX * _bW) + (_bX * _aW) + (_aY * _bZ) - (_aZ * _bY);
					oQua.Y = (_aY * _bW) + (_bY * _aW) + (_aZ * _bX) - (_aX * _bZ);
					oQua.Z = (_aZ * _bW) + (_bZ * _aW) + (_aX * _bY) - (_aY * _bX);
					oQua.W = (_aW * _bW) - (_aX * _bX) - (_aY * _bY) - (_aZ * _bZ);
				}
				return oQua;
			 },
			Rotate          : function(iEuX,iEuY,iEuZ,iOrder, oQua)
			 {
				var iQua = Quaternion.FromEuler(new EulerAngles(iEuX,iEuY,iEuZ,iOrder));
				return this.Multiply(iQua, oQua);
			 },
			Clone           : function(){return new Quaternion(this.X,this.Y,this.Z,this.W)},
			ToString        : function(){return "(" + this.X.ToString2() + "," + this.Y.ToString2() + "," + this.Z.ToString2() + "," + this.W.ToString2() + ")"},
			ToTHREE         : function(){return Quaternion.ToTHREE(this)},

			static :
			 {
				Identity            : {get : function(){return new Quaternion()}},
				Rotated             : function(iX,iY,iZ,iOrder){return new Quaternion().Rotate(iX,iY,iZ,iOrder)},
				Slerp               : function(iaQua, ibQua, iT, oQua)
				 {
					var _aX = iaQua.X, _bX = ibQua.X, _X,
						 _aY = iaQua.Y, _bY = ibQua.Y, _Y,
						 _aZ = iaQua.Z, _bZ = ibQua.Z, _Z,
						 _aW = iaQua.W, _bW = ibQua.W, _W;

					var _CosHalfT = (_aX * _bX) + (_aY * _bY) + (_aZ * _bZ) + (_aW * _bW);

					if(!oQua) oQua = new Quaternion;
					{
						if(Abs(_CosHalfT) >= 1)
						{
							oQua.X = _aX;
							oQua.Y = _aY;
							oQua.Z = _aZ;
							oQua.W = _aW;
						}
						else
						{
							if   (_CosHalfT < 0) {_X = -_bX; _Y = -_bY; _Z = -_bZ; _W = -_bW; _CosHalfT = -_CosHalfT;}
							else                 {_X = +_bX; _Y = +_bY; _Z = +_bZ; _W = +_bW;}
							
							var _HalfT    = Acos(_CosHalfT);
							var _SinHalfT = Sqrt(1 - (_CosHalfT * _CosHalfT));

							if(Abs(_SinHalfT) < 0.001)
							{
								oQua.X = (_aX + _bX) * 0.5;
								oQua.Y = (_aY + _bY) * 0.5;
								oQua.Z = (_aZ + _bZ) * 0.5;
								oQua.W = (_aW + _bW) * 0.5;
							}
							else
							{
								var _aR = Sin((1 - iT) * _HalfT) / _SinHalfT,
									 _bR = Sin(     iT  * _HalfT) / _SinHalfT;

								oQua.X = (_aX * _aR) + (_bX * _bR);
								oQua.Y = (_aY * _aR) + (_bY * _bR);
								oQua.Z = (_aZ * _aR) + (_bZ * _bR);
								oQua.W = (_aW * _aR) + (_bW * _bR);
							}
						}
					}
					return oQua;
				 },
				
				FromVectors         : function(iFrV, iToV, oQua)
				 {
					var _CroP = Vector3.Cross (iFrV, iToV);
					var _DotP = Vector3.Dot   (iFrV, iToV); 

					if(!oQua) oQua = new Quaternion;
					{
						oQua.X = _CroP.X;
						oQua.Y = _CroP.Y;
						oQua.Z = _CroP.Z;

						oQua.W = 1 + _DotP;
					}
					return oQua.Normalize(self);
				 },
				FromRotationVector  : function(iRotV, oQua)
				 {
					var _AxisV = iRotV.Normalize();
					var _Angle = iRotV.Length;
					
					return Quaternion.FromAxisAngle(_AxisV, _Angle, oQua);
				 },
				FromEuler           : function(iEuler, oQua)
				 {
					var _CX = Cos(iEuler.X / 2), _SX = Sin(iEuler.X / 2),
						 _CY = Cos(iEuler.Y / 2), _SY = Sin(iEuler.Y / 2),
						 _CZ = Cos(iEuler.Z / 2), _SZ = Sin(iEuler.Z / 2);

					var _SSS = _SX * _SY * _SZ,  _CCC = _CX * _CY * _CZ,
						 _CSS = _CX * _SY * _SZ,  _SCC = _SX * _CY * _CZ,
						 _SCS = _SX * _CY * _SZ,  _CSC = _CX * _SY * _CZ,
						 _SSC = _SX * _SY * _CZ,  _CCS = _CX * _CY * _SZ;

					if(!oQua) oQua = new Quaternion; switch(iEuler.Order)
					{
						case "XYZ" : oQua.X = _SCC + _CSS; oQua.Y = _CSC - _SCS; oQua.Z = _CCS + _SSC; oQua.W = _CCC - _SSS; break;
						case "YXZ" : oQua.X = _SCC + _CSS; oQua.Y = _CSC - _SCS; oQua.Z = _CCS - _SSC; oQua.W = _CCC + _SSS; break;
						case "ZXY" : oQua.X = _SCC - _CSS; oQua.Y = _CSC + _SCS; oQua.Z = _CCS + _SSC; oQua.W = _CCC - _SSS; break;
						case "ZYX" : oQua.X = _SCC - _CSS; oQua.Y = _CSC + _SCS; oQua.Z = _CCS - _SSC; oQua.W = _CCC + _SSS; break;
						case "YZX" : oQua.X = _SCC + _CSS; oQua.Y = _CSC + _SCS; oQua.Z = _CCS - _SSC; oQua.W = _CCC - _SSS; break;
						case "XZY" : oQua.X = _SCC - _CSS; oQua.Y = _CSC - _SCS; oQua.Z = _CCS + _SSC; oQua.W = _CCC + _SSS; break;

						default    : throw "Invalid euler angles order: '" + iEuler.Order + "'";
					}
					return oQua;
				 },
				FromAxisAngle       : function(iAxisV, iAngle, oQua)
				 {
					 var _SA = Sin(iAngle / 2), _CA = Cos(iAngle / 2);

					 return new Quaternion(iAxisV.X * _SA, iAxisV.Y * _SA, iAxisV.Z * _SA, _CA).Normalize(self);
				 },
				ToTHREE             : function(iQua, oQua$ext){return new THREE.Quaternion(iQua.X,iQua.Y,iQua.Z,iQua.W)},
				FromTHREE           : function(iQua$ext, oQua){return new Quaternion(iQua.x,iQua.y,iQua.z,iQua.w)},
				
				FromString : function(iStr){var _StrM = iStr.match(/^\(([+-\d\.e]+),([+-\d\.e]+),([+-\d\.e]+),([+-\d\.e]+)\)$/); return new Quaternion(parseFloat(_StrM[1]),parseFloat(_StrM[2]),parseFloat(_StrM[3]),parseFloat(_StrM[4]))},
			 }
		 },
		'EulerAngles' : 
		 {
			X     : num,
			Y     : num,
			Z     : num,
			Order : str,
			
			constructor : function EulerAngles(iX,iY,iZ,iOrder)
			 {
				this << iX     || 0;
				this << iY     || 0;
				this << iZ     || 0;
				this << iOrder || "XYZ";
			 },

			Clone   : function(){return new Euler(this.X,this.Y,this.Z,this.Order)},
			ToTHREE : function(){return new THREE.Euler(this.X,this.Y,this.Z,this.Order)},

			static :
			 {
				FromQuaternion : function (iQuat, iOrder, oEulerA)
				 {
					// iQuat is assumed to be normalized
					// http://www.mathworks.com/matlabcentral/fileexchange/20696-function-to-convert-between-dcm-euler-angles-iQuatuatuaternions-and-euler-vectors/content/SpinCalc.m

					var sqx = iQuat.X * iQuat.X;
					var sqy = iQuat.Y * iQuat.Y;
					var sqz = iQuat.Z * iQuat.Z;
					var sqw = iQuat.W * iQuat.W;

					if(oEulerA == undefined) oEulerA = new EulerAngles(); if(!iOrder) iOrder = oEulerA.Order;
					{
						switch(iOrder)
						{
							case "XYZ":

								oEulerA.X = Atan2(2 * (iQuat.X * iQuat.W - iQuat.Y * iQuat.Z), (sqw - sqx - sqy + sqz));
								oEulerA.Y = Asin(Clamp(2 * (iQuat.X * iQuat.Z + iQuat.Y * iQuat.W)));
								oEulerA.Z = Atan2(2 * (iQuat.Z * iQuat.W - iQuat.X * iQuat.Y), (sqw + sqx - sqy - sqz));
								break;

							case "YXZ":

								oEulerA.X = Asin(Clamp(2 * (iQuat.X * iQuat.W - iQuat.Y * iQuat.Z)));
								oEulerA.Y = Atan2(2 * (iQuat.X * iQuat.Z + iQuat.Y * iQuat.W), (sqw - sqx - sqy + sqz));
								oEulerA.Z = Atan2(2 * (iQuat.X * iQuat.Y + iQuat.Z * iQuat.W), (sqw - sqx + sqy - sqz));
								break;

							case "ZXY":

								oEulerA.X = Asin(Clamp(2 * (iQuat.X * iQuat.W + iQuat.Y * iQuat.Z)));
								oEulerA.Y = Atan2(2 * (iQuat.Y * iQuat.W - iQuat.Z * iQuat.X), (sqw - sqx - sqy + sqz));
								oEulerA.Z = Atan2(2 * (iQuat.Z * iQuat.W - iQuat.X * iQuat.Y), (sqw - sqx + sqy - sqz));
								break;

							case "ZYX":

								oEulerA.X = Atan2(2 * (iQuat.X * iQuat.W + iQuat.Z * iQuat.Y), (sqw - sqx - sqy + sqz));
								oEulerA.Y = Asin(Clamp(2 * (iQuat.Y * iQuat.W - iQuat.X * iQuat.Z)));
								oEulerA.Z = Atan2(2 * (iQuat.X * iQuat.Y + iQuat.Z * iQuat.W), (sqw + sqx - sqy - sqz));
								break;

							case "YZX":

								oEulerA.X = Atan2(2 * (iQuat.X * iQuat.W - iQuat.Z * iQuat.Y), (sqw - sqx + sqy - sqz));
								oEulerA.Y = Atan2(2 * (iQuat.Y * iQuat.W - iQuat.X * iQuat.Z), (sqw + sqx - sqy - sqz));
								oEulerA.Z = Asin(Clamp(2 * (iQuat.X * iQuat.Y + iQuat.Z * iQuat.W)));
								break;

							case "XZY":

								oEulerA.X = Atan2(2 * (iQuat.X * iQuat.W + iQuat.Y * iQuat.Z), (sqw - sqx + sqy - sqz));
								oEulerA.Y = Atan2(2 * (iQuat.X * iQuat.Z + iQuat.Y * iQuat.W), (sqw + sqx - sqy - sqz));
								oEulerA.Z = Asin(Clamp(2 * (iQuat.Z * iQuat.W - iQuat.X * iQuat.Y)));
								break;

							default : throw "Invalid order: '" + iOrder + "'"; 
						}
					}
					return oEulerA;
				 },
				FromTHREE      : function(iV){return new Euler(iV.x,iV.y,iV.z,iV.order)},
			 }
		 },
	 }
});