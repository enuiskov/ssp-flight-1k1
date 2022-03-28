"use strict";

stuff
({
	uses :
	[
		'Math',
	],
	
	'UVS.Imaging' : 
	 {
		'FogLayer' :
		 {
			Canvas  : obj,
			Context : obj,

			constructor : function(iAA)
			 {
				this.Canvas = document.createElement("canvas");
				{
					this.Canvas.id = "FOG";
					document.body.appendChild(this.Canvas);
				}
				this.Context = this.Canvas.getContext("2d");

				window.addEventListener("resize", this.UpdateSize.Bind(this));
				this.UpdateSize();
			 },
			UpdateSize : function()
			 {
				this.Canvas.width  = window.innerWidth;
				this.Canvas.height = window.innerHeight;

				this.Canvas.style.width  = this.Canvas.width  + "px";
				this.Canvas.style.height = this.Canvas.height + "px";
				
				this.Context.UpdateSize();
				

				//this.Render();
			 },

			Render     : function()
			 {
				var _Aspect = this.Context.W / this.Context.H;
				var _HdgA,_PitA,_BnkA, _EulerA = Geometry.EulerAngles.FromQuaternion(gSIM.Vehicle.Rotation, "ZXY");
				{
					_HdgA   = (D360 - _EulerA.Z) % D360;
					_PitA   = _EulerA.X;
					_BnkA   = _EulerA.Y;
				}
				

				var _Ctx = this.Context;
				{
					_Ctx.ResetTransform();
					_Ctx.Scale(this.Context.W, this.Context.W); //~~ 900x300 -> 900x900 -> 1x1;
					_Ctx.Translate(1 / 2, (1 / _Aspect) / 2);

					


					_Ctx.Rotate    (-_BnkA);
					//_Ctx.Translate (0, (_PitA / D090) / _Aspect);
					_Ctx.Translate (0, (_PitA / D090));
				}

				
				//_Ctx.ResetTransform();
				//_Ctx.ZoomIn();
					FogLayer.Drawing.DrawBackground(_Ctx);
				//_Ctx.ZoomOut();
				_Ctx.StrokeStyle = "#ff6600";
				_Ctx.LineWidth   = 0.005;
				_Ctx.GlobalAlpha = 1;
				//_Ctx.StrokeRect(-0.1,-0.1, 0.2, 0.2);
				
				if(0)
				{
					_Ctx.StrokeRect(-0.5,-0.5,   1,   1);
					_Ctx.BeginPath();
					{
						_Ctx.MoveTo(-0.5,-0.5);
						_Ctx.LineTo(+0.5,+0.5);

						_Ctx.MoveTo(-0.5,+0.5);
						_Ctx.LineTo(+0.5,-0.5);

						_Ctx.Stroke();
					}
				}
			 },

			static : 
			{
				Drawing : 
				{
					DrawBackground : function(iCtx)
					 {
						iCtx.FillStyle = "#ff0000";

						var _Gradient = iCtx.CreateLinearGradient(0, -0.5, 0, 0.5);
						{
							//_Gradient.AddColorStop(0, (iFrame.Parent && iFrame.Parent.BackColor.AsString) || "#ffffff");
							_Gradient.AddColorStop(0.0, "#00ccff");
							_Gradient.AddColorStop(0.4, "#00ccff");
							_Gradient.AddColorStop(0.5,  "#ffffff");
							_Gradient.AddColorStop(0.6, "#ffaa00");
							//_Gradient.AddColorStop(0.5, "#000000");
							//_Gradient.AddColorStop(1.0, "#66cc00");
							_Gradient.AddColorStop(1.0, "#ffaa00");
						}
						iCtx.FillStyle   = _Gradient;

						iCtx.FillRect(-1,-1,2,2);
					 }
				}
			}
		 },
	 }
});