"use strict";

stuff
({
	uses :
	[
		'System.Drawing',
	],
	//'BFS.Equipment' : {},
	//'DockStyle' :
	 //{
		//None   : "None",   //~~00000;
		//Top    : "Top",    //~~00001;
		//Bottom : "Bottom", //~~00010;
		//Left   : "Left",   //~~00100;
		//Right  : "Right",  //~~01000;
		//Fill   : "Fill",   //~~10101;


		//var _X,_Y,_W,_H;
		//{
			//if(this.Dock)
			//{
				//_X = (this.Dock & DockStyle.Left ? 0 : this.Bounds.RX);
				//_Y = (this.Dock & DockStyle.Top  ? 0 : this.Bounds.RY);
				//_W = (this.Dock & DockStyle.Fill ? 1 : this.Bounds.RW);
				//_H = (this.Dock & DockStyle.Fill ? 1 : this.Bounds.RH);
			//}
			//else
			//{
				//_X = this.Bounds.RX;
				//_Y = this.Bounds.RY;
				//_W = this.Bounds.RW;
				//_H = this.Bounds.RH;
			//}

			//_X *= window.innerWidth;
			//_Y *= window.innerHeight;
			//_W *= window.innerWidth;
			//_H *= window.innerHeight;
		//}
	 //},
	'GraphicsLayer' : 
	 {
		Canvas      : obj("HTMLCanvasElement"),
		Context     : obj("CanvasRenderingContext2D"),

		Width       : num,
		Height      : num,

		Dock        : enm("DockStyle"),

		IsVisible   : boo,
		IsValidated : boo,

		constructor : function(iAA)
		{
			this.Canvas = document.createElement("canvas");
			{
				var _S = this.Canvas.style;
				_S.position   = "fixed";
				//_S.visibility = "hidden";
				_S.border     = "#ff0000 10px dashed";
				
				document.appendChild(this.Canvas);
			}
			this.Context     = this.Canvas.getContext("2d");
			this.IsValidated = false;

			

			window.addEventListener("resize", this.UpdateBounds.Bind(this));

			this.UpdateBounds();
			window.setInterval(this.Validate.Bind(this), 100);
		 },

		UpdateBounds : function()
		 {
			var _E = this.Canvas, _S = _E.style;
			//var _IsL = this.Dock == DockStyle.Left,
			    //_IsL = this.Dock == DockStyle.Left,
			if(this.Dock == DockStyle.Left) 
			switch(this.Dock)
			{
				case DockStyle.None : throw "WTF";
				case DockStyle.Top  : _S.top  = "0px"; _E.width  = window.innerWidth / 2; break;
				case DockStyle.Left : _S.left = "0px"; _E.width  = window.innerWidth / 2; break;

				case DockStyle.Fill : _E.width  = window.innerWidth; _E.height = window.innerHeight; break;
			}
			
			_S.left = "0px";
			_S.top  = "0px";

			if(this.Dock == DockStyle.Fill)
			{
				
			}

			_S.width  = _E.width  + "px";
			_S.height = _E.height + "px";

			this.Context.UpdateSize();
			this.Invalidate();
		 },
		Invalidate : function(){this.IsValidated = false;},
		Validate   : function()
		 {
			if(!this.IsVisible || this.IsValidated) return;
			
			

			this.IsValidated = true;
		 },
		UpdateGraphics : function()
		 {
			var _Ctx = this.Context;


		 },
		static : 
		 {
			Drawing : 
			{
				DrawBackground : function(iCtx)
				{
					iCtx.FillStyle   = new Color(255,0,0, 0.3);
					iCtx.StrokeStyle = new Color(255,0,0, 1.0);

					iCtx.BeginPath();
					 iCtx.AddRect(1,1,iCtx.W - 2, iCtx.H - 2, 10);
					iCtx.Fill();
					 iCtx.MoveTo(5,         5); iCtx.LineTo(iCtx.W - 5,iCtx.H - 5);
					 iCtx.MoveTo(5,iCtx.H - 5); iCtx.LineTo(iCtx.W - 5,         5);
					iCtx.Stroke();
				},
			}
		 }
	 },
	'Console : GraphicsLayer' :
	 {
		ID          : str,
		Lines       : arr,
		Canvas      : obj("HTMLCanvasElement"),
		Context     : obj("CanvasRenderingContext2D"),

		IsVisible   : boo,
		IsValidated : boo,
		

		constructor : function(iCnsId)
		{
			this.ID    = iCnsId;
			this.Lines = [];
			//var _CnsParamO = JSON.parse(localStorage["Console['" + this.ID + "']"]);
			//this.IsVisible = JSON.parse(localStorage["Console['" + this.ID + "']"]) || true;

			this.Canvas = document.createElement("canvas");
			{
				this.Canvas.id        = "Console(" + this.ID + ")";
				this.Canvas.className = "Console";
				//this.Canvas.style.visibility
				document.appendChild(this.Canvas);
			}
			this.IsValidated = false;
		},
		UpdateSize : function()
		 {
			
		 },

		Invalidate : function(){this.Validated = false;},
		Validate   : function()
		 {
			this.Context
		 },


		Write     : function(iStr){},
		WriteLine : function(iStr){},
		Clear     : function(){},

		

		LoadSettings : function()
		{
			var _JsonO = JSON.parse(localStorage["Console(" + this.ID + ")"]);
			
			this.ID        = _JsonO.ID;
			this.IsVisible = _JsonO.IsVisible;
		},
		SaveSettings : function()
		{
			var _JsonO =
			{
				ID        : this.ID,
				IsVisible : this.IsVisible
			};
			localStorage["Console(" + this.ID + ")"] = JSON.stringify(_JsonO);
		},
	 },
});