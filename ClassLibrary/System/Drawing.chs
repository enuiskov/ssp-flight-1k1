"use strict";

stuff
 ({
	'System.Drawing' :
	 {
		'DockStyle' :
		 {
			Fill   : "Fill"   ,
			Top    : "Top"    ,
			Bottom : "Bottom" ,
			Left   : "Left"   ,
			Right  : "Right"  ,
			None   : "None"   ,
		 },
		
		'GraphicsLayer'      : 
		 {
			Canvas      : nil ('HTMLCanvasElement'),
			Context     : nil ('CanvasRenderingContext2D'),
			Bounds      : obj ('Rectangle', 0,0,1,1),
			Dock        : str ("Fill"),
			
			ForeColor   : obj('Color',0,0,0),
			BackColor   : obj('Color',255,255,255),

			IsVisible   : boo(true),
			Opacity     : num(1),
			ZIndex      : num(1),

			//IsForeValidated : boo,
			//IsBackValidated : boo,

			constructor : function annex(iAA)
			 {
				//this << iAA.Dock      || DockStyle.Fill;
				//this << iAA.Bounds    || new Rectangle(0,0,1,1);//new Rectangle(0.25,0.25,0.5,0.5);
				////this << iAA.Bounds    || error;
				//this << iAA.ForeColor || Colors.Black;
				//this << iAA.BackColor || Colors.White;
				//this << iAA.IsVisible || true;
				//this << iAA.Opacity   || 1;
				//this << iAA.ZIndex    || 1;
				
				
				//this(Dock, DockStyle.None);

				//this.Dock      = iAA.Dock      || DockStyle.None;
				//this.Bounds    = iAA.Bounds    || new Rectangle(0.25,0.25,0.5,0.5);
				//this.ForeColor = iAA.ForeColor || Colors.Black;
				//this.BackColor = iAA.BackColor || Colors.White;
				//this.ZIndex    = iAA.ZIndex    || 


				this.Canvas = document.createElement("canvas");
				{
					var _S = this.Canvas.style;
					{
						_S.position = "fixed";
						_S.opacity  = "0.5";//this.Opacity + "";
						_S.zIndex   = this.ZIndex;
					}
					//_S.visibility = "hidden";
					//_S.border     = "#ff0000 2px dashed";
					//this.Canvas.style.visibility = this.IsVisible ? "visible" : "hidden";
					this.ToggleVisibility(this.IsVisible);
					document.body.appendChild(this.Canvas);
				}
				this.Context         = this.Canvas.getContext("2d");
				this.IsForeValidated = false;
				this.IsBackValidated = false;

				

				window.addEventListener("resize", this.UpdateBounds.Bind(this));

				this.UpdateBounds();
				window.setInterval
				(
					function()
					{
						if(!this.IsVisible) return;
						
						//this.Opacity;

						if(this.IsForeValidated && this.IsBackValidated) return;

						this.Validate(!this.IsForeValidated, !this.IsBackValidated);
					}
					.Bind(this), 100
				);
			 },

			UpdateBounds     : function()
			 {
				var _WinW = window.innerWidth, _WinH = window.innerHeight;
				var _E = this.Canvas, _BB = this.Bounds, _S = _E.style;
				var _X,_Y,_W,_H;
				{
					if(Math.Max(Math.Abs(_BB.X),Math.Abs(_BB.Y),Math.Abs(_BB.W),Math.Abs(_BB.H)) > 1)
					{
						_BB = new Rectangle(_BB.X / _WinW, _BB.Y / _WinH, _BB.W / _WinW, _BB.H / _WinH);
					}
					switch(this.Dock)
					{
						case DockStyle.None   : _X = _BB.X;      _Y = _BB.Y;      _W = _BB.W;  _H = _BB.H;     break;
						case DockStyle.Fill   : _X = 0;          _Y = 0;          _W = 1;      _H = 1;         break;

						case DockStyle.Top    : _X = 0;          _Y = 0;          _W = 1;      _H = _BB.H;     break;
						case DockStyle.Bottom : _X = 0;          _Y = 1 - _BB.H;  _W = 1;      _H = _BB.H;     break;
						case DockStyle.Left   : _X = 0;          _Y = 0;          _W = _BB.W;  _H = 1;         break;
						case DockStyle.Right  : _X = 1 - _BB.W;  _Y = 0;          _W = _BB.W;  _H = 1;         break;

						default               : throw "WTF";
					}
					_X = Math.Round(_X * _WinW); _Y = Math.Round(_Y * _WinH);
					_W = Math.Round(_W * _WinW); _H = Math.Round(_H * _WinH);
				}

				_E.width  = _W;
				_E.height = _H;

				_S.left   = _X + "px";
				_S.top    = _Y + "px";
				_S.width  = _W + "px";
				_S.height = _H + "px";

				this.Context.UpdateSize();
				this.Invalidate(true, true);
			 },
			Invalidate       : function(iDoFore, iDoBack)
			 {
				if(iDoFore == undefined && iDoBack == undefined) iDoFore = true;
				if(iDoFore) this.IsForeValidated = false;
				if(iDoBack) this.IsBackValidated = false;
			 },
			Validate         : function(iDoFore, iDoBack)
			 {
				//if(!this.IsVisible || this.IsValidated) return;
				if(iDoBack && this.UpdateBackground != undefined)
				{
					this.Context.ResetTransform();
					this.Context.GlobalAlpha = 1;
					
					this.Context.Save();
					{
						this.Context.StrokeStyle = this.BackColor;
						this.Context.FillStyle   = this.BackColor;
						
						this.UpdateBackground();
						this.IsBackValidated = true;
					}
					this.Context.Restore();

					this.Canvas.style.background = " url('" + this.Canvas.toDataURL() + "')";

					this.Context.ClearRect(0,0,this.Context.W, this.Context.H);
				}
				if(iDoFore)
				{
					this.Context.ResetTransform();
					this.Context.GlobalAlpha = 1;
					
					this.Context.Save();
					{
						this.Context.StrokeStyle = this.ForeColor;
						this.Context.FillStyle   = this.ForeColor;
						
						this.UpdateForeground();
						this.IsForeValidated = true;
					}
					this.Context.Restore();
				}
			 },
			//UpdateBackground : function()
			//{
				//GraphicsLayer.Drawing.DrawBackground(this, this.Context);
			//},
			UpdateBackground : undefined,
			UpdateForeground : function()
			 {
				//var _Ctx = this.Context;

			 },
			ToggleVisibility : function(iMode$boo)
			 {
				if(iMode == undefined) iMode = !this.IsVisible;

				this.Canvas.style.opacity = iMode ? 1 : 0;
				this.IsVisible = iMode;
			 },
			
			
			static : 
			{
				Drawing : 
				{
					DrawBackground : function(iLayer, iCtx, iBackC, iForeC)
					{
						var iCtx = iLayer.Context;

						iCtx.FillStyle   = iBackC || iLayer.BackColor;
						iCtx.StrokeStyle = iForeC || iLayer.ForeColor;

						iCtx.BeginPath();
						 iCtx.AddRect(3, 3, iCtx.W - 6, iCtx.H - 6, 5);
						iCtx.Fill();
						 //iCtx.MoveTo(5,         5); iCtx.LineTo(iCtx.W - 5,iCtx.H - 5);
						 //iCtx.MoveTo(5,iCtx.H - 5); iCtx.LineTo(iCtx.W - 5,         5);
						iCtx.Stroke();
					},
				}
			}
		 },
		'LayerSet'           :
		 {
			Contexts    : arr('CanvasRenderingContext2D'),
			Bounds      : obj('Rectangle'),

			constructor : function(iGrxA)
			 {
				if(iGrxA != undefined && !(iGrxA instanceof Array)) throw "WTF";

				this.Bounds  = new Bounds(0,0,1,1);
				this.Contexts = [];

				if(iGrxA) this.Update(iGrxA);

				this.SetBounds();
			 },
			Update      : function(iGrxA)
			 {
				//this.Length = iGrxA.Length;
				this.Contexts = [];

				//for(var cE,Ei = 0; cE = arguments[Ei], Ei < arguments.length; Ei++)
				
				for(var cC,Ci = 0; cC = iGrxA[Ci], Ci < iGrxA.Length; Ci++)
				{
					if         (cC == undefined) continue;
					else if    (cC instanceof CanvasRenderingContext2D) this.Contexts[Ci] = cC;
					else if    (cC instanceof HTMLCanvasElement)        this.Contexts[Ci] = cC = cC.getContext("2d");
					else throw "Object type '" + cC.constructor.name + "' not supported";

					cC.Layer = Ci;
				}
				//for(let cC,Ci = 0; cC = iGrxA[Ci], Ci < iGrxA.Length; Ci++)
				//{
					//if         (cC == --) continue;
					//else if    (cC instanceof CanvasRenderingContext2D) own.Contexts[Ci] = cC;
					//else if    (cC instanceof HTMLCanvasElement)        own.Contexts[Ci] = cC = cC.getContext("2d");
					//else throw "Object type '" + cC.constructor.name + "' not supported";

					//cC.Layer = Ci;
				//}
			 },
			SetBounds   : function(iX,iY,iW,iH)
			 {
				var _BaseG = this.Contexts[0] || this.Contexts[1] || this.Contexts[2] || this.Contexts[3] || this.Contexts[4];

				if(arguments.length != 4 && _BaseG)
				{
					iX = _BaseG.canvas.clientLeft;
					iY = _BaseG.canvas.clientTop;
					iW = _BaseG.canvas.clientWidth;
					iH = _BaseG.canvas.clientHeight;
				}
				this.Bounds.SyncR2A(Bounds.FromAbsolute(iX,iY,iW,iH));
				
				for(var cG,Gi = 0; cG = this.Contexts[Gi], Gi < this.Contexts.Length; Gi++)
				{
					if(!cG) continue;
					if(cG.canvas.width == iW && cG.canvas.height == iH) continue;
					
					cG.canvas.width  = iW;
					cG.canvas.height = iH;

					cG.canvas.style.left   = iX + "px";
					cG.canvas.style.top    = iY + "px";
					
					cG.canvas.style.width  = iW + "px";
					cG.canvas.style.height = iH + "px";
				}
			 },
		 },


		'Colors'             :
		 {
			Random       : {get : function(){return new Color(Math.Random() * 255, Math.Random() * 255, Math.Random() * 255);}},
			Transparent  : ('Color',   0,   0,   0,   0),
			
			Black        : ('Color',   0,   0,   0),
			White        : ('Color', 255, 255, 255),
			Grey         : ('Color', 127, 127, 127),

			Red          : ('Color', 255,   0,   0),
			Green        : ('Color',   0, 200,   0),
			Blue         : ('Color',   0,   0, 255),

			Yellow       : ('Color', 255, 255,   0),

		 },
		'Color'              :
		 {
			R : num(0,0,255),
			G : num(0,0,255),
			B : num(0,0,255),
			A : num(0,0,1),

			AsString : str,
			
			constructor   : function(iR$num,iG$num,iB$num,iA$num)
			 {
				this << iR || 0;
				this << iG || 0;
				this << iB || 0;
				this << iA || 1;

				this.UpdateString();
			 },
			GetBrightness : function(oV$num)
			 {
				var _R = this.R / 255, _G = this.G / 255, _B = this.B / 255;
				return (Math.Min(_R,_G,_B) + Math.Max(_R,_G,_B)) / 2;
			 },
			SetValue      : function(iV$num,oC$Color)
			 {
				return new Color
				(
					Math.Floor(this.R * iV),
					Math.Floor(this.G * iV),
					Math.Floor(this.B * iV)
				);
			 },
			//SetBrightness : function(oV$num)
			//{
				//var _R = this.R / 255, _G = this.G / 255, _B = this.B / 255;
				//return (Math.Min(_R,_G,_B) + Math.Max(_R,_G,_B)) / 2;
			//},

			UpdateString  : function()          {this.AsString = "rgba(" + Math.Floor(this.R) + "," + Math.Floor(this.G) + "," + Math.Floor(this.B) + "," + this.A + ")"},
			Clone         : function(oC$Color)  {return new Color(this.R,this.G,this.B,this.A)},
			valueOf       : function(oV)        {return this.AsString},
			toString      : function(oS)        {return this.AsString},
			
			static :
			 {
				ModifyAlpha     : function(iC$Color,iNewA$num)
				 {
					return new Color(iC.R, iC.G, iC.B, iNewA);
				 },
				FromString      : function(iS$str, oC$Color)
				 {
					if     (iS.StartsWith("#"))    return Color.FromHexString  (iS);
					else if(iS.StartsWith("rgba")) return Color.FromRGBAString (iS);
					else if(iS.StartsWith("rgb"))  return Color.FromRGBString  (iS);

					else throw "Color format not supported";
				 },
				FromRGBString   : function(iS$str, oC$Color)
				 {
					iS = iS.Match(/rgba\((\d+),(\d+),(\d+)\)/);

					return new Color(parseInt(iS[1]), parseInt(iS[2]), parseInt(iS[3]));
				 },
				FromRGBAString  : function(iS$str, oC$Color)
				 {
					iS = iS.Match(/rgba\((\d+),(\d+),(\d+),(\d+)\)/);

					return new Color(parseInt(iS[1]), parseInt(iS[2]), parseInt(iS[3]), parseInt(iS[4]));
				 },
				FromHexString   : function(iS$str, oC$Color)
				 {
					return new Color
					(
						parseInt(iS.Substring(1,3),16),
						parseInt(iS.Substring(3,5),16),
						parseInt(iS.Substring(5,7),16)
					);
				 },
			 }
		 },
		//'HSLColor : Color'   : //~~meta; info="";
		 //{
			//H : num(0,1),
			//S : num(0,1),
			//L : num(0,1),

			//instance : 
			 //{
				//constructor : function(iC$Color)
				 //{
					//if(arguments.length == 1 && iC instanceof Color)
					//{
						//this.overriden(iC.R,iC.G,iC.B);
					//}
					//else this.overriden(arguments);

					//this.UpdateHSL();
				 //},
				//UpdateHSL : function()
				//{
					//var r = this.R, g = this.G, b = this.B;

					//r /= 255, g /= 255, b /= 255;
					//var max = Math.max(r, g, b), min = Math.min(r, g, b);
					//var h, s, l = (max + min) / 2;

					//if(max == min) h = s = 0; // achromatic
					//else
					//{
						//var d = max - min;
						//s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
						//switch(max){
							//case r: h = (g - b) / d + (g < b ? 6 : 0); break;
							//case g: h = (b - r) / d + 2; break;
							//case b: h = (r - g) / d + 4; break;
						//}
						//h /= 6;
					//}

					//this.H = h;
					//this.S = s;
					//this.L = l;
				//},

				//UpdateRGB : function()
				 //{
					//var h = this.H, s = this.S, l = this.L;
					//var r, g, b;

					//if(s == 0)
					//{
						//r = g = b = l; // achromatic
					//}
					//else
					//{
						//var hue2rgb = function(p, q, t)
						//{
							//if(t < 0) t += 1;
							//if(t > 1) t -= 1;
							//if(t < 1/6) return p + (q - p) * 6 * t;
							//if(t < 1/2) return q;
							//if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
							//return p;
						//}

						//var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
						//var p = 2 * l - q;

						//r = hue2rgb(p, q, h + 1/3);
						//g = hue2rgb(p, q, h);
						//b = hue2rgb(p, q, h - 1/3);
					//}

					//this.R = Math.Floor(r * 255);
					//this.G = Math.Floor(g * 255);
					//this.B = Math.Floor(b * 255);
				 //},
				//Clone        : function(oC$HSLColor)
				 //{
					//return new HSLColor(this.R,this.G,this.B,this.A);
				 //},
			 //},
			//static   :
			 //{
				//FromRGB : function (iC)
				 //{
					//var r = iC.R, g = iC.G, b = iC.B;

					 //r /= 255, g /= 255, b /= 255;
					 //var max = Math.max(r, g, b), min = Math.min(r, g, b);
					 //var h, s, l = (max + min) / 2;

					 //if(max == min){
						  //h = s = 0; // achromatic
					 //}else{
						  //var d = max - min;
						  //s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
						  //switch(max){
								//case r: h = (g - b) / d + (g < b ? 6 : 0); break;
								//case g: h = (b - r) / d + 2; break;
								//case b: h = (r - g) / d + 4; break;
						  //}
						  //h /= 6;
					 //}

					 //return new HSLColor(h, s, l);
				 //},
			 //}
		 //},
		'Point'              :
		 {
			X : num,
			Y : num,
			
			constructor : function Point(iX$num,iY$num)
			 {
				this << iX || 0;
				this << iY || 0;
			 },
			toString    : function()
			 {
				return this.X + " x " + this.Y;
			 },

			static:
			 {
				
			 }
		 },
		'Vector'             :
		 {
			X : num,
			Y : num,

			constructor : function(iX,iY)
			 {
				this << iX || 0;
				this << iY || 0;
			 },
		 },
		'Size'               :
		 {
			Width  : num,
			Height : num,

			constructor : function(iWidth$num,iHeight$num)
			 {
				this << iWidth  || 0;
				this << iHeight || 0;
			 },

			toString : function()
			 {
				return this.Width + "x" + this.Height;
			 }
		 },
		'Rectangle'          :
		 {
			X : num,
			Y : num,
			W : num,
			H : num,
	
			constructor : function(iX,iY,iW,iH)
			 {
				this << iX;
				this << iY;
				this << iW;
				this << iH;
			 },

			Project   : function(iObj)
			 {
				if(iObj instanceof Rectangle)
				{
					var oR = new Rectangle
					(
						this.X + (iObj.X * this.W),
						this.Y + (iObj.Y * this.H),

						iObj.W * this.W,
						iObj.H * this.H
					);
					return oR;
				}
				else throw "NI";
			 },
			UnProject : function(iObj$any, oObj$any)
			 {
				throw "NI";
			 },
		 },
		'Bounds'             :
		 {
			AX : num(NaN),
			AY : num(NaN),
			AW : num(NaN),
			AH : num(NaN),

			RX : num(NaN),
			RY : num(NaN),
			RW : num(NaN),
			RH : num(NaN),

			//constructor : function auto(iRX,iRY,iRW,iRH, iAX,iAY,iAW,iAH){auto},


			constructor : function(iRX,iRY,iRW,iRH, iAX,iAY,iAW,iAH)
			 {
				this << iRX || NaN;
				this << iRY || NaN;
				this << iRW || NaN;
				this << iRH || NaN;

				this << iAX || NaN;
				this << iAY || NaN;
				this << iAW || NaN;
				this << iAH || NaN;
			 },

			SyncR2A : function(iPareB)
			 {
				this.AX = iPareB.AX + (iPareB.AW * this.RX);
				this.AY = iPareB.AY + (iPareB.AH * this.RY);
				this.AW = iPareB.AW * this.RW;
				this.AH = iPareB.AH * this.RH;
			 },
			
			SyncA2R : function(iPareB)
			 {
				throw "NI";
			 },
			
			static :
			{
				FromAbsolute : function(iAX,iAY,iAW,iAH,oBB){return oBB = new Bounds(NaN,NaN,NaN,NaN,iAX,iAY,iAW,iAH);},
				FromRelative : function(iRX,iRY,iRW,iRH,oBB){return oBB = new Bounds(iRX,iRY,iRW,iRH,NaN,NaN,NaN,NaN);},
			}
		 },
		'CircleBounds'       :
		 {
			X        : num,
			Y        : num,
			Align    : str("CC", "(C|L|R)(C|T|B)"), //~~meta; info="Applies X and Y coordinates to specified bounds. 'C' is Center"
			Diameter : num(1),                      //~~meta; info="Diameter (maximum value of master property)"
			Aspect   : num(1),                      //~~meta; info="Aspect ratio for slave property (S/M)"
			Master   : str("W", "W|H"),             //~~meta; info="Specifies master property for the use as 'diameter'"

			AX       : num,
			AY       : num,
			AW       : num,
			AH       : num,

			//constructor : ctor('iX,iY,iAlign,iDiameter,iAspect,iMaster'),

			constructor : function(iX$num, iY$num, iAlign$str, iDiameter$num, iAspect$num, iMaster$str) //~~meta; info="???? Aspect ratio is signed (+V=Hs/Wm, -V=Ws/Hm)"
			{
				this << iX;
				this << iY;
				this << iAlign    || "CC";
				this << iDiameter || 1;
				this << iAspect   || 1;
				this << iMaster   || "W";

				

				this.AX = NaN;
				this.AY = NaN;
				this.AW = NaN;
				this.AH = NaN;
			},
			SyncR2A : function(iPareB$Bounds)
			 {
				Size:
				{
					var _WIsM = this.Master == "W", _HIsM = !_WIsM;

					var _MasV = this.Diameter * (_WIsM ? iPareB.AW : iPareB.AH);
					var _SlaV = _MasV * this.Aspect;

					this.AW = _WIsM ? _MasV : _SlaV;
					this.AH = _HIsM ? _MasV : _SlaV;
				}
				Position:
				{
					var _HrzB = this.Align[0];
					var _VrtB = this.Align[1];

					var _OffsX = 0, _OffsY = 0;
					var _W = this.AW, _H = this.AH;

					switch(_HrzB)
					{
						case "C" : _OffsX = -_W / 2; break;
						case "L" : _OffsX = 0;       break;
						case "R" : _OffsX = -_W;     break;

						default: "WTF";
					}
					switch(_VrtB)
					{
						case "C" : _OffsY = -_H / 2; break;
						case "T" : _OffsY = 0;       break;
						case "B" : _OffsY = -_H;     break;

						default: "WTF";
					}

					this.AX = iPareB.AX + (iPareB.AW * this.X) + _OffsX;
					this.AY = iPareB.AY + (iPareB.AH * this.Y) + _OffsY;
				}
				

				
				

				//this.AX = iPareB.AX + (iPareB.AW * this.X) - (this.AW / 2);
				//this.AY = iPareB.AY + (iPareB.AH * this.Y) - (this.AH / 2);


			 },
			
			static : 
			 {
				ToJson : function(iObj)
				{
					throw "ND";
					oObj = {};
					{
						for(var cMemN in CircleBounds.InstanceFields)
						{
							oObj[cMemN] = CircleBounds[cMemN].Type.ToJson(CircleBounds[cMemN]);
						}
					}
				},
				FromJson : function(iJsonO)
				{
					
				},
			 }
		 },
		'Matrix'             :
		 {
			M11 : num,
			M12 : num,
			M21 : num,
			M22 : num,
			DX  : num,
			DY  : num,

			constructor     : function Matrix(iM11,iM12,iM21,iM22,iDX,iDY)
			 {
				if(arguments.length == 0)
				{
					this.Reset();
				}
				else if(arguments.length == 6)
				{
					this << iM11;
					this << iM12;
					this << iM21;
					this << iM22;
					this << iDX;
					this << iDY;
				}
				else throw "Invalid argument count: " + arguments.length;
			 },
			
			Reset           : function(oM$this)
			 {
				this.M11 = 1;
				this.M12 = 0;
				this.M21 = 0;
				this.M22 = 1;
				this.DX  = 0;
				this.DY  = 0;

				return this;
			 },
			Multiply        : function(iM$Matrix,oM$this)
			 {
				var _M11 = (this.M11 * iM.M11) + (this.M21 * iM.M12);
				var _M12 = (this.M12 * iM.M11) + (this.M22 * iM.M12);
				var _M21 = (this.M11 * iM.M21) + (this.M21 * iM.M22);
				var _M22 = (this.M12 * iM.M21) + (this.M22 * iM.M22);
				
				var _DX  = (this.M11 * iM.DX)  + (this.M21 * iM.DY) + this.DX;
				var _DY  = (this.M12 * iM.DX)  + (this.M22 * iM.DY) + this.DY;
				
				this.M11 = _M11;
				this.M12 = _M12;
				this.M21 = _M21;
				this.M22 = _M22;
				this.DX  = _DX;
				this.DY  = _DY;
				
				return this;
			 },
			Invert          : function(oM$this)
			 {
				var _D = 1 / (this.M11 * this.M22 - this.M12 * this.M21);
				
				var _M11 = +this.M22 * _D;
				var _M12 = -this.M12 * _D;
				var _M21 = -this.M21 * _D;
				var _M22 = +this.M11 * _D;
				var _DX  = (this.M21 * this.DY - this.M22 * this.DX) * _D;
				var _DY  = (this.M12 * this.DX - this.M11 * this.DY) * _D;
				
				this.M11 = _M11;
				this.M12 = _M12;
				this.M21 = _M21;
				this.M22 = _M22;
				this.DX  = _DX;
				this.DY  = _DY;
				
				return this;
			 },
			Rotate          : function(iRad$num,oM$this)
			 {
				var _Cos = Math.Cos(iRad);
				var _Sin = Math.Sin(iRad);
				
				var _M11 = this.M11 *  _Cos + this.M21 * _Sin;
				var _M12 = this.M12 *  _Cos + this.M22 * _Sin;
				var _M21 = this.M11 * -_Sin + this.M21 * _Cos;
				var _M22 = this.M12 * -_Sin + this.M22 * _Cos;
				
				this.M11 = _M11;
				this.M12 = _M12;
				this.M21 = _M21;
				this.M22 = _M22;
				
				return this;
			 },
			Translate       : function(iX,iY, oM$this)
			 {
				this.DX += this.M11 * iX + this.M21 * iY;
				this.DY += this.M12 * iX + this.M22 * iY;
				
				return this;
			 },
			Scale           : function(iX,iY, oM$this)
			 {
				this.M11 *= iX;
				this.M12 *= iX;
				this.M21 *= iY;
				this.M22 *= iY;
				
				return this;
			 },
			Project         : function(iX,iY, oP$Point)
			 {
				return new Point
				(
					(iX * this.M11) + (iY * this.M21) + this.DX,
					(iX * this.M12) + (iY * this.M22) + this.DY
				)

				//var oX = iX, oY = iY;
				//{
					//oX = iX * this.M11 + iY * this.M21 + this.DX;
					//oY = iX * this.M12 + iY * this.M22 + this.DY;
				//}
				//return new Point(oX,oY);
			 },
			Unproject       : function(iX,iY, oP$Point)
			 {
				return this.Clone().Invert().Project(iX,iY);
			 },
			
			ProjectVector   : function(iX,iY, oV$Vector)
			 {
				return new Vector
				(
					(iX * this.M11) + (iY * this.M21),
					(iX * this.M12) + (iY * this.M22)
				)
				//var oX = iX, oY = iY;
				//{
					//oX = (iX * this.M11) + (iY * this.M21);
					//oY = (iX * this.M12) + (iY * this.M22);
				//}
				//return new Vector(oX, oY);
			 },
			UnprojectVector : function(iX,iY, oV$Vector){return this.Clone().Invert().ProjectVector(iX,iY);},
			//CurrentScale    : {get : function(oV$num){return Math.Sqrt(Math.Pow(this.M11,2) + Math.Pow(this.M12,2));}},
			CurrentScale    : {get : function(oV$num){return Math.Sqrt((this.M11 * this.M11) + (this.M12 * this.M12))}},
			Clone           : function(){return new Matrix(this.M11, this.M12, this.M21, this.M22, this.DX, this.MDY)},

			static :
			 {
				Identity : {get once(){return new Matrix()}},
			 }
		 },
	 }
 });
