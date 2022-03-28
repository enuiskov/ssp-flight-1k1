"use strict";

stuff
({
	uses :
	[
		'System.Drawing',
		'Math',
	],
	//'UVS.Equipment' : {},
	'UVS.Equipment.HUD' :
	 {
		'Screen : GraphicsLayer' : 
		 {
			Type        : str("Unknown"),
			Color       : obj('Color'),
			//Canvas      : obj,
			//Context     : obj,
			Layout      : obj,
			DataSource  : obj,
			//Validated   : boo,
			
			constructor : function annex(iAA)
			 {
				//debugger;
				//this.Indicators = HUDScreen.CreateLayout(this, this.Type);
				//this.Layout     = new Layout([Indicators.Create("Generic/Watch", {Bounds : new CircleBounds(0.5, 0.5,  "CC", 0.25, 1, "H")})]);
				this.Layout     = Layouts.Create("Vehicles/Aircraft");//.([Indicators.Create("Generic/Watch", {Bounds : new CircleBounds(0.5, 0.5,  "CC", 0.25, 1, "H")})]);
				this.DataSource = iAA.DataSource || null;

				this.Validated     = false;
				
				//~~this.UpdateSize();
				this.Layout.UpdateSize(this);

				//~~window.addEventListener("resize", this.UpdateSize.Bind(this));
			 },
			//constructor : function(iAA)
			 //{
				//this.Type  = iAA.Type || "Unknown";
				//this.Color = iAA.Color;
				

				//this.Canvas  = document.createElement("canvas");
				//this.Context = this.Canvas.getContext("2d");
				//{
					//this.Canvas.id = "HUD";
					////this.Canvas.
					//document.body.appendChild(this.Canvas);
				//}
				////this.Indicators = HUDScreen.CreateLayout(this, this.Type);
				////this.Layout     = new Layout([Indicators.Create("Generic/Watch", {Bounds : new CircleBounds(0.5, 0.5,  "CC", 0.25, 1, "H")})]);
				//this.Layout     = Layouts.Create("Vehicles/Aircraft");//.([Indicators.Create("Generic/Watch", {Bounds : new CircleBounds(0.5, 0.5,  "CC", 0.25, 1, "H")})]);
				//this.DataSource = iAA.DataSource || null;

				//this.Validated     = false;
				
				//this.UpdateSize();

				//window.addEventListener("resize", this.UpdateSize.Bind(this));
				////window.setInterval(this.Validate.Bind(this), 30);
			 //},
			
			UpdateBounds : function()
			 {
				this.overriden.UpdateBounds();

				
				if(0)
				{
					this.Context.Scale     (1,-1);
					this.Context.Translate (0, -this.Context.H);
				}
				
				if(this.Layout) this.Layout.UpdateSize(this);
				////this.LastSizeChange = new Date();
				//this.Invalidate();
			 },
			UpdateBackground   : function()
			 {
				var _Ctx = this.Context;
				{
					_Ctx.ClearRect(0,0,_Ctx.W,_Ctx.H);

					//_Ctx.FillStyle = "rgba(0,0,0,0.2)";
					_Ctx.FillStyle = "rgba(0,0,0,0.5)";
					
					_Ctx.FillRect(0,0,_Ctx.W,_Ctx.H);
					
					//_Ctx.BeginPath();
					//_Ctx.ClearRect();
					//_Ctx.FillRect();
				}

				if(0) for(var _II = this.Layout.Indicators, cI,Ii = 0; cI = _II[Ii]; Ii++)
				{
					_Ctx.Save();
					{
						_Ctx.Translate(cI.Bounds.AX, cI.Bounds.AY);

						_Ctx.W = cI.Bounds.AW;
						_Ctx.H = cI.Bounds.AH;

						_Ctx.BeginPath();
						{
							_Ctx.AddRect(0,0,_Ctx.W,_Ctx.H);
							_Ctx.FillStyle = cI.Color;
							_Ctx.Stroke();
						}
					}
					_Ctx.Restore();
				}
			 },
			UpdateForeground   : function()
			 {
				
				for(var _Ctx = this.Context, _II = this.Layout.Indicators, cI,Ii = 0; cI = _II[Ii]; Ii++)
				{
					_Ctx.Save();
					{
						_Ctx.Translate(cI.Bounds.AX, cI.Bounds.AY);

						_Ctx.W = cI.Bounds.AW;
						_Ctx.H = cI.Bounds.AH;

						//_Ctx.scale(1,_Ctx.W / _Ctx.H);

						

						_Ctx.FillStyle   = cI.Color;
						_Ctx.StrokeStyle = cI.Color;
						
						_Ctx.BeginPath();
						{
							_Ctx.ClearRect(0,0,_Ctx.W,_Ctx.H);


							//_Ctx.AddRect  (0,0,_Ctx.W,_Ctx.H);
							//_Ctx.Clip();
							_Ctx.BeginPath();
						}
						//~~_Ctx.BeginPath();
						cI.Draw(this.Context, this.DataSource);
					}
					_Ctx.Restore();
				}
			 },
			SetLayout  : function(iLout)
			 {
				this.Layout = iLout;
				this.Layout.UpdateSize();
				this.Invalidate();
			 },
		 },
		'Layout' : 
		 {
			ID         : str,
			Indicators : arr('Indicator'),

			constructor : function(iIndiA, iLoutID)
			{
				this.ID         = iLoutID || this.constructor.name;
				this.Indicators = iIndiA  || [];
				
				//HUDLayout.Register(this);
			},

			UpdateSize : function(iHudS)
			{
				
				var _H = iHudS.Canvas.height;
				var _W = _H;
				//~~var _W = _H * 2.55;
				//var _W = iHudS.Canvas.width;
				
				var _X = (iHudS.Canvas.width / 2) - (_W / 2);  //~~ ??;
				var _Y = 0;


				//iHudS.Canvas.height * 2.5;
				for(var cI,Ii = 0; cI = this.Indicators[Ii]; Ii++)
				{
					//cI.Bounds.SyncR2A(Bounds.FromAbsolute(_X,_Y,_W,_H));
					cI.Bounds.SyncR2A(Bounds.FromAbsolute(_X,_Y,_W,_H));
				}
			},

			//var _LoutJson = HUDLayout.ToJson(_Lout);


			static : 
			 {
				ToJson   : function(iLayout,  oJsonO){throw "NI"},
				FromJson : function(iJsonO$obj, oLout)
				{
					/**
						{
							ID    : "MyLayout",
							Color : "#ff0000",

							Indicators :
							[
								{Type : "Aircraft.Altimeter", Color : "#ff0000", Bounds : [0.5, 0.5, "CC", 0.25, 1, "H"]},
								{Type : "Aircraft.Airspeed",  Color : "#ff0000", Bounds : [0.5, 0.5, "CC", 0.25, 1, "H"]},
								{Type : "Aircraft.Heading",   Color : "#ff0000", Bounds : [0.5, 0.5, "CC", 0.25, 1, "H"]},
							]
						}
					*/
					oLout = new Layout();
					{
						//oLout.ID = iJsonO.ID;

						for(var cI,Ii = 0; cI = iJsonO.Indicators[Ii], Ii < iJsonO.Indicators.Length; Ii++)
						{
							//console.info([cI]);
							//;
							//var cBounds = new CircleBounds
							oLout.Indicators.Push(Indicators.Create(cI.ID, {Bounds : Object.Construct(Bounds, cI.Bounds)}));
						}
					}
					return oLout;
					
					//for(var cIO Object.getPropertiesiJson;
				},
				//initializer : function()
				 //{
					////new HUDLayout([], "Empty");
					////new HUDLayout([], "Default");

					//for(var _NN = Object.getOwnPropertyNames(this), cN,Ni = 0; cN = _NN[Ni], Ni < _NN.Length; Ni++)
					//{
						//console.info(cN);
					//}
				 //},
				Register : function(iLayout)
				 {
					if(this[iLayout.ID]) throw "HUD Layout '" + iLayout.ID + "' already exists";
					this[iLayout.ID] = iLayout;
				 },
			 }
		 },

		 //gfGetByPath : function()
		 //{
		 
		 //},
		
		'Indicator' : 
		 {
			//Owner  : obj('HUDScreen'),
			Color  : obj('Color', 255,255,0),
			Bounds : obj('Bounds', 0.5,0.5,0.25,0.25),

			//Draw : function(iCtx)
			 //{
				//return;
				////iCtx.ClearRect(0,0,iCtx.W,iCtx.H);

				////iCtx.StrokeStyle = this.Color;
				////iCtx.FillStyle   = Color.ModifyAlpha(this.Color, 0.5);

				//iCtx.BeginPath();
				//{
					////iCtx.GlobalAlpha = 0.1;
					//iCtx.AddRect(1,1, Max(iCtx.W - 2,1), Max(iCtx.H - 2,1), 10);

					//iCtx.FillStyle = "#000000";//"rgba(255,255,255,1)";
					//iCtx.GlobalAlpha = 0.15;
					//iCtx.Fill();

					//iCtx.FillStyle = this.Color;

					//iCtx.GlobalAlpha = 0.3;
					////iCtx.GlobalAlpha = 1;
					
					////iCtx.MoveTo(0,0);
					////iCtx.LineTo(iCtx.W,iCtx.H);
					////iCtx.MoveTo(0,iCtx.H);
					////iCtx.LineTo(iCtx.W,0);
					//iCtx.Stroke();
					//iCtx.GlobalAlpha = 1;
				//}
				
			 //},
			static :
			 {
				Drawing : 
				{
					DrawError : function(iCtx)
					 {
						if(iCtx.UnzoomData) iCtx.ZoomOut();

						iCtx.ZoomIn(100);
						//iCtx.BeginPath(); var iW = iCtx.W, iH = iCtx.H;
						//{
							//iCtx.MoveTo(     10,      10);
							//iCtx.LineTo(     30,      30);
							//iCtx.MoveTo(iW - 30, iH - 30);
							//iCtx.LineTo(iW - 10, iH - 10);

							//iCtx.MoveTo(     10, iH - 10);
							//iCtx.LineTo(     30, iH - 30);
							//iCtx.MoveTo(iW - 30,      30);
							//iCtx.LineTo(iW - 10,      10);
							
							//iCtx.LineWidth = 1;
							//iCtx.Stroke();
						//}
						iCtx.Font         = "20% courier";
						iCtx.TextAlign    = "center";
						iCtx.TextBaseline = "middle";
						iCtx.FillStyle    = "#ff0000";
						iCtx.FillText     ("ERROR", 50,50);

						iCtx.ZoomOut();
					 },

					//DrawError : function(iCtx)
					 //{
						//if(iCtx.IsZoomed) iCtx.ZoomOut();

						//iCtx.ZoomIn();
						//{
						
						//}
						//var iW = iCtx.W, iH = iCtx.H;

						//iCtx.BeginPath();
						//{
							//iCtx.MoveTo(     10,      10);
							//iCtx.LineTo(     30,      30);
							//iCtx.MoveTo(iW - 30, iH - 30);
							//iCtx.LineTo(iW - 10, iH - 10);

							//iCtx.MoveTo(     10, iH - 10);
							//iCtx.LineTo(     30, iH - 30);
							//iCtx.MoveTo(iW - 30,      30);
							//iCtx.LineTo(iW - 10,      10);
							
							//iCtx.LineWidth = 1;
							//iCtx.Stroke();
						//}
						
						//iCtx.Font         = "20% lucida sans";
						//iCtx.TextAlign    = "center";
						//iCtx.TextBaseline = "middle";
						//iCtx.FillStyle    = Colors.Red;
						//iCtx.FillText     ("N/A", iCtx.W / 2, iCtx.H / 2);
					 //}

				}
			 }
		 },

		'Layouts' : 
		 {
			Create    : function(iPath, oLout)
			{
				var _LoutJson = Object.GetNode(this, iPath);
				return Layout.FromJson(_LoutJson);
			}
		 },
		'Indicators' :
		 {
			//GetByPath : {get once(){return Object.GetByPath.Bind(this)}},
			Create    : function(iPath, iArgs, oIndi)
			{
				var _Indi = Object.GetNode(this, iPath);
				return new _Indi(iArgs);
			}
		 }
	 },
});