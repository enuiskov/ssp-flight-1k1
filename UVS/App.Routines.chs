"use strict";

stuff
({
	uses :
	[
		'System.Drawing',
		'Math.Geometry',
		//'THREE: *, -Math'     ,
		//'THREE.Math (Math3D)' ,
		'Math'                ,
	],
	gfInitConsoles : function(iApp)
	 {
		var _BackColor = new Color(127,95,0,0.5);
		//return;
		//$.gAPCns = new GraphicsConsole({Title : "Autopilot", Dock : DockStyle.Right, Bounds : new Rectangle(0,0,300,0), ZIndex : 10, ForeColor : Colors.White, BackColor : new Color(255,255,0,0.25)});
		//{
			//gAPCns.ToggleVisibility(true);
		//}
		$.gSysCns   = new GraphicsConsole({Title : "Systems",     IsVisible : localStorage["Info(Systems)"]    == "true", Dock : DockStyle.Right, Bounds : new Rectangle(0,0,300,0), ZIndex : 10, ForeColor : Colors.White, BackColor : _BackColor});
		//$.localStorage["Info(Systems)"]    != "true" && gSysCns .ToggleVisibility(false);
		
		$.gPhysCns  = new GraphicsConsole({Title : "Physics",     IsVisible : localStorage["Info(Physics)"]    == "true", Dock : DockStyle.Left,  Bounds : new Rectangle(0,0,300,0), ZIndex : 10, ForeColor : Colors.White, BackColor : _BackColor});
		//$.localStorage["Info(Physics)"]    != "true" && gPhysCns.ToggleVisibility(false);
		
		$.gAlgoCns  = new GraphicsConsole({Title : "Algorithms",  IsVisible : localStorage["Info(Algorithms)"] == "true", Dock : DockStyle.Left,  Bounds : new Rectangle(0,0,300,0), ZIndex : 10, ForeColor : Colors.White, BackColor : _BackColor});
		//$.localStorage["Info(Algorithms)"] != "true" && gAlgoCns.ToggleVisibility(false);
		

		iApp.Consoles =
		[
			//gApp.Diagram,
			gPhysCns,
			gAlgoCns,
			gSysCns,
		];
		


	 },
	
	gfApplyFixes : function(iDeltaT)
	 {
		//var self = gfApplyFixes;

		if(!$.gfApplyFixes.Data) $.gfApplyFixes.Data = {UpdDelay : 0, CurrRow : 0};
		var _Data = gfApplyFixes.Data;


		if(gKeys.Minus)  _Data.CurrRow -= 0.3;
		if(gKeys.Equals) _Data.CurrRow += 0.3;

		//_Data.CurrRow = Clamp(_Data.CurrRow, 0, gSeries.Entries.Length);
		//_Data.CurrRow = Clamp(_Data.CurrRow, 0, gSeries.Entries.Length);


		
		
		
		var _CurrIndex = Round(_Data.CurrRow) * 8;
		var _NextIndex = _CurrIndex + 8;


		


		var _CurrPos   = new Vector3(gTable[_CurrIndex + 1], gTable[_CurrIndex], gTable[_CurrIndex + 2]);
		var _NextPos   = new Vector3(gTable[_NextIndex + 1], gTable[_NextIndex], gTable[_NextIndex + 2]);
		
		var _LookVec   = _CurrPos.Subtract(_NextPos);
		var _Angle     = Atan2(+_LookVec.X, -_LookVec.Y);
		var _RotQuat   = Quaternion.Rotated(0,0,_Angle);

		if(gKeys.Left || gKeys.Right || gKeys.Up || gKeys.Down)
		{
			if(gKeys.Left ^ gKeys.Right)
			{
				_NextPos.Add(new Vector3(gKeys.Left ? -5 : +5,0,0).Rotate(_RotQuat), self);
			}
			
			gTable[_NextIndex + 1] = _NextPos.X;
			gTable[_NextIndex    ] = _NextPos.Y;
			gTable[_NextIndex + 2] = _NextPos.Z;
		}



		_Data.UpdDelay += 0.1; if(_Data.UpdDelay > 1)
		{
			UVS.Imaging.Routines.UpdateTrajectory();
			_Data.UpdDelay = 0;
		}
		//if(gKeys.Left || gKeys.Right || gKeys.Up || gKeys.Down)
		//{
			//if(gKeys.Left ^ gKeys.Right)
			//{
				//_CurrPos.Add(new Vector3(gKeys.Left ? -5 : +5,0,0).Rotate(_RotQuat), self);
			//}
			
			//gTable[_CurrIndex + 1] = _CurrPos.X;
			//gTable[_CurrIndex    ] = _CurrPos.Y;
			//gTable[_CurrIndex + 2] = _CurrPos.Z;

			//UVS.Imaging.Routines.UpdateTrajectory();
		//}

		gSIM.Vehicle.Position = _CurrPos;
		gSIM.Vehicle.Rotation = _RotQuat;
		
		gfSyncGraphics3D();


		
		//if(isNaN(_VehP.Z)) debugger;
		//if(0)
		//{
			//var _ActP = gSIM.Vehicle.Position;
			//var _TgtP = UVS.Simulation.DataX.GetNearestEntry(_ActP).Value.Position.Clone();

			//if(isNaN(_TgtP.Z)) debugger;

			//var _PosD =  _TgtP.Subtract(_ActP).Rotate(gSIM.Vehicle.Rotation.Inverse()).Set(null,0,null).Rotate(gSIM.Vehicle.Rotation);

			//var _AltF = Clamp01(Scale01(_ActP.Z,  500, 1000));
			//var _AuPF = gSIM.Vehicle.Control.Inputs.Balance;

			////gMagic = 

			//gSIM.Vehicle.Velocity.Linear.Add(_PosD.MultiplyScalar(0.1 * _AltF * _AuPF * iDeltaT), self);
			//gSIM.Vehicle.Position       .Add(_PosD.MultiplyScalar(1   * _AltF * _AuPF * iDeltaT), self);
		//}
		
		
	 },
	
	'AppState' : 
	 {
		//LastStateID : 0,

		//Default : 
		 //{
			//"State0" : {Vehicle : {PosV : "0,-10000,1000", RotQ : "0,0,0,1", VelL : "0,150,0", VelA : "0,0,0"}},
			////"State2" : {Vehicle : {PosV : "0,-10000,1000", RotQ : "0,0,0,1", VelL : "0,150,0", VelA : "0,0,0"}},
		 //},

		Save : function(iStateID)
		 {
			if(iStateID == undefined) iStateID = localStorage["LastState"] || 0;

			var _Veh   = gSIM.Vehicle;
			var _VehAA = _Veh.Surfaces.Actuators;

			
			var _StateO =
			{
				Vehicle : 
				{
					Position : _Veh.Position         .ToString(),
					Rotation : _Veh.Rotation         .ToString(),

					Velocity : 
					{
						Linear  : _Veh.Velocity.Linear  .ToString(),
						Angular : _Veh.Velocity.Angular .ToString(),
					},
					
					Systems : 
					{
						Guidance : 
						{
							ApproachDirection : undefined,
							TargetHAC         : 0,
						},
						Control : 
						{
							Pitch    : _Veh.Control.Pitch,
							Roll     : _Veh.Control.Roll,
							Yaw      : _Veh.Control.Yaw,

							SpdBrake : _Veh.Control.SpdBrake,
							BodyFlap : _Veh.Control.BodyFlap,

							//Ailerons : _Veh.Control.Ailerons,
							//Elevator : _Veh.Control.Elevator,
							//Rudder   : _Veh.Control.Rudder,
							//AirBrake : _Veh.Control.AirBrake,
							//BodyFlap : _Veh.Control.BodyFlap,

						},
						Surfaces :
						{
							ElevInL  : _VehAA.ElevInL  .CurrValue,
							ElevOuL  : _VehAA.ElevOuL  .CurrValue,
							ElevInR  : _VehAA.ElevInR  .CurrValue,
							ElevOuR  : _VehAA.ElevOuR  .CurrValue,

							//ElevR  : _VehAA.ElevonR  .CurrValue,
							//RudderL  :_VehAA.RudderL  .CurrValue,
							Rudder   : _VehAA.Rudder   .CurrValue,
							SpdBrake : _VehAA.SpdBrake .CurrValue,
							BodyFlap : _VehAA.BodyFlap .CurrValue,
						},
					}
				},
			};
			localStorage["State" + iStateID] = JSON.stringify(_StateO);
			localStorage["LastStateID"] = iStateID;
		 },
		Load : function(iStateID)
		 {
			if(iStateID == undefined) iStateID = localStorage["LastStateID"] || 0;

			gApp.ApproachDiagram.SimData.Entries.Length = 0;//360;

			var _Veh = gSIM.Vehicle;
			var _VehAA = _Veh.Surfaces.Actuators;

			//debugger;
			gSIM.Vehicle.Reset();
			
			
			//_Veh.Position         = new Vector3;
			//_Veh.Rotation         = new Quaternion;
			//_Veh.Velocity = new Velocity();//.Linear  = new Vector3;
			////_Veh.Velocity.Angular = new Vector3;

			//_Veh.Data.Update();
			////_Veh.Autopilot.Programs.Clear();
			////_Veh.Guidance.Phase = "ERROR:ERROR";
			//_Veh.Guidance .Reset();
			//_Veh.Autopilot.Reset();
			//_Veh.Control.Reset();
			//_Veh.Surfaces.Reset();



			var _StateS = localStorage["State" + iStateID];
			{
				if(_StateS)
				{
					var _StateO = JSON.parse(_StateS);
					{
						_Veh.Position             = Vector3    .FromString(_StateO.Vehicle.Position);
						_Veh.Rotation             = Quaternion .FromString(_StateO.Vehicle.Rotation);
						_Veh.Velocity.Linear      = Vector3    .FromString(_StateO.Vehicle.Velocity.Linear);
						_Veh.Velocity.Angular     = Vector3    .FromString(_StateO.Vehicle.Velocity.Angular);

						_Veh.Control.Pitch        = _StateO.Vehicle.Systems.Control.Pitch;
						_Veh.Control.Roll         = _StateO.Vehicle.Systems.Control.Roll;
						_Veh.Control.Yaw          = _StateO.Vehicle.Systems.Control.Yaw;
						_Veh.Control.SpdBrake     = _StateO.Vehicle.Systems.Control.SpdBrake;
						_Veh.Control.BodyFlap     = _StateO.Vehicle.Systems.Control.BodyFlap;

						_VehAA.ElevInL.CurrValue  = _StateO.Vehicle.Systems.Surfaces.ElevInL;
						_VehAA.ElevOuL.CurrValue  = _StateO.Vehicle.Systems.Surfaces.ElevOuL;
						_VehAA.ElevInR.CurrValue  = _StateO.Vehicle.Systems.Surfaces.ElevInR;
						_VehAA.ElevOuR.CurrValue  = _StateO.Vehicle.Systems.Surfaces.ElevOuR;

						_VehAA.Rudder.CurrValue   = _StateO.Vehicle.Systems.Surfaces.Rudder;
						_VehAA.SpdBrake.CurrValue = _StateO.Vehicle.Systems.Surfaces.SpdBrake;
						_VehAA.BodyFlap.CurrValue = _StateO.Vehicle.Systems.Surfaces.BodyFlap;
					}
					localStorage["LastStateID"] = iStateID;
				}
				else
				{
					console.info("Empty state slot: 'State" + iStateID + "'");
					
					var _Mach1 = 295;

					var _AppA = 76, _HdgDelta = +18, _BnkA = 14,  _Dist = 20000, _Alt  = 20400, _VSpd = -70, _MSpd = 1.8;
					{
						//~~{_AppA = 76, _HdgDelta = +18, _Dist = 20000, _Alt  = 20400, _MSpd = 1.85};
						//{_AppA = 76, _HdgDelta = +18, _Dist = 20000, _Alt  = 20350, _MSpd = 1.87};
						{_AppA = 76, _HdgDelta = +18, _Dist = 20000, _Alt  = 20300, _MSpd = 1.96};

						//{_AppA = 244, _HdgDelta = 0, _BnkA = 0, _Dist = 20000, _Alt  = 500, _VSpd = 0, _MSpd = 0.3};

						//{_AppA = 246, _Dist = 20000, _Alt  = 5000, _MSpd = 0.5}

						//{_AppA = 246; _Dist = 0.001; _Alt  = 500; _VSpd = 0.01;  _MSpd = 0.1};

						//{_AppA = 66; _HdgDelta = 0; _BnkA = 0; _Dist = 30000; _Alt  = 10000; _VSpd = 0.01;  _MSpd = 0.3};
					}

					//debugger;
					//var _PosQ = ;
					//var _VelQ = ;

					var _PosQ = Quaternion.Rotated(0,0, (-_AppA + _Veh.Data.Attitude.HdgFix) * DTR);
					var _VelQ = Quaternion.Rotated(Math.Asin(_VSpd / Max(_MSpd * _Mach1, _VSpd)), _BnkA * DTR, (-_AppA + _Veh.Data.Attitude.HdgFix - _HdgDelta) * DTR, "ZXY");
					//var _VelQ = Quaternion.Rotated(0 * Math.DTR, _BnkA * Math.DTR, Math.DegToRad(-_AppA) + _Veh.Data.Attitude.HdgFix - Math.DegToRad(_HdgDelta), "ZXY");

					var _PosV = new Vector3(0,1,0).Rotate(_PosQ).MultiplyScalar(_Dist * -1) .Set(null,null,_Alt);
					var _VelV = new Vector3(0,1,0).Rotate(_VelQ).MultiplyScalar(_MSpd * _Mach1);//.Set(null,null, _VSpd);
					
					var _WindQ = Quaternion.Rotated(0,0, -_VelV.Add(_Veh.Data.Wind.Inverse()).Normalize().AngleTo(_VelV));

					_Veh.Position         = _PosV;
					_Veh.Rotation         = _VelQ.Multiply(_WindQ);

					_Veh.Velocity = new UVS.Simulation.Velocity({Linear : _VelV});





					
					//_Veh.Velocity.Angular = ;
					
				//debugger;

					
					//_Veh.Data      .Update();
					//_Veh.Guidance  .Reset();
					//_Veh.Autopilot .Reset();
					//_Veh.Control   .Reset();
					//_Veh.Surfaces  .Reset();

					//_Veh.Guidance.Phase = {ID : "ENTRY:ET5", TransRate : 0.1};
					//debugger;
					//_Veh.Guidance.Update();
					//_Veh.Autopilot.Update(0.001);
						//gSIM.Vehicle.Reset();

					_Veh.Surfaces.Actuators.SpdBrake.CurrValue =
					_Veh.Surfaces.SpdBrake                     = 70;

					//_Veh.Position         = new Vector3(+30000,-30000,20000);
					//debugger;
				}

				//if(1)
				//{
					//_Veh.Position = UVS.Simulation.DataX.GetNearestEntry(_Veh.Position, false).Value.Position.Clone();
				//}

				//var _Veh   = _Veh;
				//var _VehAA = _Veh.Actuators;
				
				gSIM.Vehicle.Data.Update();
				gApp.Simulator.IsActive = true;

			}
			
			//gApp.ApproachDiagram.Series.Entries.Clear();
		 },
	 },
	'Routines' : 
	 {
	 },
	
	'PathFixer'                     : 
	 {
		Table : arr,
		State : obj,

		constructor : function(iAA)
		{
			this.Table = iAA.Table || error;
			this.State = {UpdDelay : 0, CurrRow : 0};

			window.addEventListener
			(
				"keypress", function(iEvt)
				{
					switch(iEvt.keyCode)
					{
						case 44  : this.State.CurrRow = Math.Round(this.State.CurrRow - 1);     break;
						case 46  : this.State.CurrRow = Math.Round(this.State.CurrRow + 1);     break;
							
						
						
						//case 60  : this.TabPos.Row -= 10;  break;
						//case 62  : this.TabPos.Row += 10;  break;

						//case 91  : this.TabPos.Col --;     break;
						//case 93  : this.TabPos.Col ++;     break;

						case 115 : this.SaveData(); break; //~~S;
						case 108 : this.LoadData(); break; //~~L;

						//default  : console.info(iEvt.keyCode);
					}
					this.Update();

					if(gApp.DataLeveler) gApp.DataLeveler.Invalidate();
				}
				.Bind(this)
			);

			this.LoadData();
		},

		Update : function(iDeltaT)
		 {
			this.State.CurrRow = Clamp(this.State.CurrRow, 0, this.Table.Length / 8);
			//if(gKeys.Minus)  this.State.CurrRow -= 0.3;
			//if(gKeys.Equals) this.State.CurrRow += 0.3;

			//_Data.CurrRow = Clamp(_Data.CurrRow, 0, gSeries.Entries.Length);
			//_Data.CurrRow = Clamp(_Data.CurrRow, 0, gSeries.Entries.Length);

			var _CurrIndex = Round(this.State.CurrRow) * 8;
			var _NextIndex = _CurrIndex + 8;


			


			var _CurrPos   = new Vector3(this.Table[_CurrIndex + 1], this.Table[_CurrIndex], this.Table[_CurrIndex + 2]);
			var _NextPos   = new Vector3(this.Table[_NextIndex + 1], this.Table[_NextIndex], this.Table[_NextIndex + 2]);
			
			var _LookVec   = _CurrPos.Subtract(_NextPos);
			var _Angle     = Atan2(+_LookVec.X, -_LookVec.Y);
			var _RotQuat   = Quaternion.Rotated(0, this.Table[_CurrIndex + 4] * DTR,_Angle, "ZXY");
			
			var _AffPos, _AffIndex;
			{
				if(0){_AffPos = _NextPos; _AffIndex = _NextIndex;}
				else {_AffPos = _CurrPos; _AffIndex = _CurrIndex;}

				if(gKeys.Left || gKeys.Right || gKeys.Up || gKeys.Down)
				{
					if(gKeys.Left ^ gKeys.Right)
					{
						_AffPos.Add(new Vector3(gKeys.Left ? -0.1 : +0.1,0,0).Rotate(_RotQuat), self);
					}
					if(gKeys.Up ^ gKeys.Down)
					{
						_AffPos.Add(new Vector3(0,0,gKeys.Up ? +1 : -1), self);
					}
					
					this.Table[_AffIndex + 1] = _AffPos.X;
					this.Table[_AffIndex    ] = _AffPos.Y;
					this.Table[_AffIndex + 2] = _AffPos.Z;
				}
			}



			this.State.UpdDelay += 0.1; if(this.State.UpdDelay > 1)
			{
				this.State.UpdDelay = 0;

				gApp.DataLeveler.UpdateData();
				gApp.DataLeveler.Invalidate();
				
				UVS.Imaging.Routines.UpdateTrajectory();
			}
			

			gSIM.Vehicle.Position = _CurrPos;
			gSIM.Vehicle.Rotation = _RotQuat;
			
			gfSyncGraphics3D();
		 },

		SaveData       : function()
		 {
			window.localStorage["PathFixes"] = JSON.stringify(this.Table);
		 },
		LoadData       : function()
		 {
			var _Table = JSON.parse(window.localStorage["PathFixes"] || "[]");

			this.Table.Clear();
			this.Table.AddRange(_Table);
		 },
	 },
	'PlotGrabber   : GraphicsLayer' :
	 {
		Data   : arr,
		MouPos : obj,
		TabPos : obj,

		constructor    : function(iAA)
		 {
			this.MouPos = {AX : 0, AY : 0, RX : 0, RY : 0};
			this.TabPos =
			{
				Row_ : 0, Col_ : 0,

				get Row(){return this.Row_}, set Row(i0){this.Row_ = Math.Clamp(i0,0,1000)},
				get Col(){return this.Col_}, set Col(i0){this.Col_ = Math.Clamp(i0,0,10)}
			};

			
			//this.Data = []; for(var Ri = 0; Ri < 1000; Ri++)
			//{
				//this.Data.Add([NaN]);
			//}
			this.Data   = iAA.Data || [];
			this.Series = iAA.Series;

			window.addEventListener("mousemove", function(iEvt){this.MouPos.AX = iEvt.x; this.MouPos.AY = iEvt.y; this.UpdateForeground(this.Context);}.Bind(this));
			window.addEventListener("mousedown", function(iEvt){this.UpdateData(); this.UpdateForeground(this.Context);}.Bind(this));
			window.addEventListener
			(
				"keypress", function(iEvt)
				{
					switch(iEvt.keyCode)
					{
						case 44  : this.TabPos.Row --;     break; //~~ <>;
						case 46  : this.TabPos.Row ++;     break;

						//case 60  : this.TabPos.Row -= 10;  break;
						//case 62  : this.TabPos.Row += 10;  break;

						case 91  : this.TabPos.Col --;     break; //~~ [];
						case 93  : this.TabPos.Col ++;     break;

						case 115 : this.SaveData(); break; //~~S;
						case 108 : this.LoadData(); break; //~~L;

						default  : console.info(iEvt.keyCode);
					}
					this.UpdateForeground(this.Context);
				}
				.Bind(this)
			);

			if(window.localStorage["PlotData"]) this.LoadData();
		 },

		UpdateData     : function(iValue)
		 {
			var _CurrRow = this.Data[this.TabPos.Row]; if(!_CurrRow) _CurrRow = this.Data[this.TabPos.Row] = [];
			{
				if(this.TabPos.Col == 0)
				{
					_CurrRow[0] = this.MouPos.RX;
					_CurrRow[1] = this.MouPos.RY;
				}
				else
				{
					_CurrRow[this.TabPos.Col] = this.MouPos.RY;
				}
			}
			this.TabPos.Row ++;
		 },
		SaveData       : function()
		 {
			window.localStorage["PlotData"] = JSON.stringify(this.Data);
		 },
		LoadData       : function()
		 {
			this.Data = JSON.parse(window.localStorage["PlotData"] || "[]");
		 },
		UpdateForeground : function(iCtx)
		 {
			//var _Ctx = this.Context;

			iCtx.W = window.innerWidth;
			iCtx.H = window.innerHeight;

			iCtx.FillStyle = "#000000";
			
			var _ScaX = 960 * 1.006;
			var _ScaY = 960;
	

			iCtx.SetTransform(_ScaX, 0,0, _ScaY, 1, 0);
			iCtx.Translate(0.5,0.5);

			this.MouPos.RX = ((this.MouPos.AX - 1) / _ScaX) - 0.5;
			this.MouPos.RY = ((this.MouPos.AY - 1) / _ScaY) - 0.5;

			
			iCtx.ClearRect(-0.5,-0.5, 1.5, 1);
			
			this.DrawCursor(iCtx, this.MouPos.RX, this.MouPos.RY);
			this.DrawPlot(iCtx);
			this.DrawInfo(iCtx);
		 },

		DrawCursor     : function(iCtx,iX,iY)
		 {
			iCtx.StrokeStyle = "#000000";
			iCtx.LineWidth   = 0.002;
			iCtx.StrokeStyle = "rgba(0,0,0,0.3)";

			iCtx.StrokeRect(-0.5,-0.5,1.1,1.0);

			iCtx.BeginPath();
			{
				iCtx.MoveTo(-0.01, -0.01); iCtx.LineTo(+0.01, +0.01);
				iCtx.MoveTo(-0.01, +0.01); iCtx.LineTo(+0.01, -0.01);

				iCtx.MoveTo(-0.5, iY); iCtx.LineTo(iX - 0.005, iY);
				iCtx.MoveTo(iX + 0.005, iY); iCtx.LineTo(+1.1, iY);

				iCtx.MoveTo(iX, -0.5); iCtx.LineTo(iX, iY - 0.005);
				iCtx.MoveTo(iX, iY + 0.005); iCtx.LineTo(iX, +0.5);
				
				iCtx.Stroke();
			}
		 },
		DrawInfo       : function(iCtx)
		 {
			iCtx.SetTransform(1,0,0,1,1075,10);

			iCtx.LineWidth = 1;
			iCtx.Font = "20px courier";
			iCtx.TextBaseline = "top";

			iCtx.FillText("X = " + this.MouPos.RX.ToString2(3), 10,0);
			iCtx.FillText("Y = " + this.MouPos.RY.ToString2(3), 10,20);

			iCtx.FillText("R = " + this.TabPos.Row,             10,60);
			iCtx.FillText("C = " + this.TabPos.Col,             10,80);
		 },
		DrawPlot       : function(iCtx)
		 {
			var _YCol = this.TabPos.Col != 0 ? this.TabPos.Col : 1;

			iCtx.BeginPath();
			{
				for(var cR,Ri = 0; cR = this.Data[Ri], Ri < this.Data.Length; Ri++)
				{
					var cX = Ri == this.TabPos.Row && this.TabPos.Col == 0 ? this.MouPos.RX : cR[0];
					var cY = Ri == this.TabPos.Row ?  this.MouPos.RY : cR[_YCol];

					iCtx.LineTo(cX, cY);
				}
				iCtx.StrokeStyle = "#000000";
				iCtx.Stroke();
			}
			iCtx.BeginPath();
			{
				var _CrsRow = this.Data[this.TabPos.Row];
				var _CrsX   = _CrsRow[0];
				var _CrsY   = _CrsRow[_YCol];

				iCtx.MoveTo(_CrsX - 0.01, _CrsY); iCtx.LineTo(_CrsX + 0.01, _CrsY);
				iCtx.MoveTo(_CrsX, _CrsY - 0.01); iCtx.LineTo(_CrsX, _CrsY + 0.01);

				iCtx.StrokeStyle = "rgba(255,0,0,0.7)";
				iCtx.Stroke();
			}
		 },
	 },
	'DataLeveler   : GraphicsLayer' :
	 {
		Table  : arr,
		Series : obj('TimeSeries.Set'),
		//MouPos : obj,
		TabPos : obj,
		Field  : str,


		constructor    : function(iAA)
		 {
			//this.MouPos = {AX : 0, AY : 0, RX : 0, RY : 0};
			this.TabPos =
			{
				Row_ : 0, Col_ : 0,

				get Row(){return this.Row_}, set Row(i0){this.Row_ = Math.Clamp(i0,0,1000)},
				get Col(){return this.Col_}, set Col(i0){this.Col_ = Math.Clamp(i0,0,10)}
			};

			this.Table  = iAA.Table || error;
			this.Series = iAA.Series;
			
			this.Field = "PosZ";
			//this.BackColor = "#000000";
			//window.addEventListener("mousemove", function(iEvt){this.MouPos.AX = iEvt.x; this.MouPos.AY = iEvt.y; this.UpdateGraphics();}.Bind(this));
			//window.addEventListener("mousedown", function(iEvt){this.UpdateData(); this.UpdateGraphics();}.Bind(this));
			window.addEventListener
			(
				"keypress", function(iEvt)
				{
					switch(iEvt.keyCode)
					{
						//case 44  : this.TabPos.Row --;     break;
						//case 46  : this.TabPos.Row ++;     break;

						//case 60  : this.TabPos.Row -= 10;  break;
						//case 62  : this.TabPos.Row += 10;  break;

						//case 91  : this.TabPos.Col --;     break;
						//case 93  : this.TabPos.Col ++;     break;

						case 115 : this.SaveData(); break; //~~S;
						case 108 : this.LoadData(); break; //~~L;

						default  : console.info(iEvt.keyCode);
					}
					this.Invalidate();
				}
				.Bind(this)
			);

			if(window.localStorage["DataLevels"]) this.LoadData();
		 },
		//SyncS2P : function()
		 //{
			
		 //},
		UpdateData     : function(iValue)
		 {
		 
			//debugger;

			if(!gApp.PathFixer) return;



			this.Table = gApp.PathFixer.Table;

			//var _Table = gApp.DataFixer.Table;

			//this.Table.Clear();
			//this.Table.AddRange(_Table);

			this.Series = UVS.Data.GetSeriesFromTable(this.Table);
		 },
		SaveData       : function()
		 {
			window.localStorage["DataLevels"] = JSON.stringify(this.Table);
		 },
		LoadData       : function()
		 {
			var _Table = JSON.parse(window.localStorage["DataLevels"] || "[]");

			this.Table.Clear();
			this.Table.AddRange(_Table);
		 },
		UpdateForeground : function(iCtx)
		 {
			//iCtx.W = 
			//iCtx.FillStyle = "#àààààà";
			iCtx.ClearRect(0,0,iCtx.W, iCtx.H);

			iCtx.FillStyle = "#ffff00";
			iCtx.FillText(new Date().ToString(),10,10);

			

			//var _Ctx = this.Context;

			//_Ctx.W = window.innerWidth;
			//_Ctx.H = window.innerHeight;

			//_Ctx.FillStyle = "#ffffff";
			
			//var _ScaX = 960 * 1.006;
			//var _ScaY = 960;
	

			//_Ctx.SetTransform(_ScaX, 0,0, _ScaY, 1, 0);
			//_Ctx.Translate(0.5,0.5);

			//this.MouPos.RX = ((this.MouPos.AX - 1) / _ScaX) - 0.5;
			//this.MouPos.RY = ((this.MouPos.AY - 1) / _ScaY) - 0.5;

			
			//_Ctx.ClearRect(-0.5,-0.5, 1.5, 1);
			
			//this.DrawCursor(_Ctx, this.MouPos.RX, this.MouPos.RY);
			this.DrawPlot(iCtx);
			//this.DrawInfo(_Ctx);
		 },

		DrawCursor     : function(iCtx,iX,iY)
		 {
			//iCtx.StrokeStyle = "#ffffff";
			//iCtx.LineWidth   = 0.002;
			//iCtx.StrokeStyle = "rgba(255,255,0,0.3)";

			//iCtx.StrokeRect(-0.5,-0.5,1.1,1.0);

			//iCtx.BeginPath();
			//{
				//iCtx.MoveTo(-0.01, -0.01); iCtx.LineTo(+0.01, +0.01);
				//iCtx.MoveTo(-0.01, +0.01); iCtx.LineTo(+0.01, -0.01);

				//iCtx.MoveTo(-0.5, iY); iCtx.LineTo(iX - 0.005, iY);
				//iCtx.MoveTo(iX + 0.005, iY); iCtx.LineTo(+1.1, iY);

				//iCtx.MoveTo(iX, -0.5); iCtx.LineTo(iX, iY - 0.005);
				//iCtx.MoveTo(iX, iY + 0.005); iCtx.LineTo(iX, +0.5);
				
				//iCtx.Stroke();
			//}
		 },
		DrawInfo       : function(iCtx)
		 {
			//iCtx.SetTransform(1,0,0,1,1075,10);

			//iCtx.LineWidth = 1;
			//iCtx.Font = "20px courier";
			//iCtx.TextBaseline = "top";

			//iCtx.FillText("X = " + this.MouPos.RX.ToString2(3), 10,0);
			//iCtx.FillText("Y = " + this.MouPos.RY.ToString2(3), 10,20);

			//iCtx.FillText("R = " + this.TabPos.Row,             10,60);
			//iCtx.FillText("C = " + this.TabPos.Col,             10,80);
		 },
		DrawPlot       : function(iCtx)
		 {
			var fDrawGraph = function(iField,iColor)
			{
				var _W = 0.000014;

				iCtx.StrokeStyle = iColor;
				iCtx.FillStyle   = iColor;

				iCtx.BeginPath(); for(var _EE = this.Series.Entries, _CursorI = gApp.PathFixer ? gApp.PathFixer.State.CurrRow : 0, cE,Ei = 0, cX = 0, cY; cE = _EE[Ei]; Ei++)
				{
					cX += cE.Value.Velocity.Set(null,null,0).Length * _W;
					
				
					switch(iField)
					{
						case "PosZ" : cY  = Scale01(cE.Value.Position.Z,    0,    21000); break;
						//case "VSpd" : cY  = Scale01(cE.Value.VSpd,          0,  -300); break;
						case "VSpd" : cY  = Scale01(cE.Value.VSpd,         -300,      0); break;
						//case "IAS"  : cY  = Scale01(cE.Value.IAS,           0,   600); break;
						case "IAS"  : cY  = Scale01(cE.Value.IAS,           300,   1000); break;

						case "MSpd" : cY  = Scale01(cE.Value.MSpd,          0.25,     2); break;

						case "Vel"  : cY  = Scale01(cE.Value.Vel,           0,  1000); break;
						case "Acc"  : cY  = Scale01(cE.Value.Acc,           -1000,  +1000); break;

						default : throw "WTF";
					}

					var cAX = cX * iCtx.W,  cAY = (1 - cY) * iCtx.H;
					{
						if(isNaN(cAX * cAY)) continue;

						iCtx.LineTo(cAX, cAY);
						{
							//iCtx.MoveTo(cAX - 5, cAY - 5);
							//iCtx.LineTo(cAX + 5, cAY + 5);
							//iCtx.MoveTo(cAX - 5, cAY + 5);
							//iCtx.LineTo(cAX + 5, cAY - 5);

							

							

							if(Ei == _CursorI) iCtx.FillRect(cAX - 3, cAY - 3, 6,6);
							else               iCtx.FillRect(cAX - 1, cAY - 1, 2,2);


							//if()
							//{
								
							//}


							//iCtx.LineTo(cAX + 5, cAY + 5);
							//iCtx.MoveTo(cAX - 5, cAY + 5);
							//iCtx.LineTo(cAX + 5, cAY - 5);
						}
						//iCtx.MoveTo(cAX, cAY);
					}
				}
				iCtx.Stroke();
			}
			.Bind(this);
			
			fDrawGraph("VSpd", "#ff0000");
			fDrawGraph("PosZ", "#00aaff");

			fDrawGraph("Vel",  "#ffffff");
			fDrawGraph("Acc",  "#00ffff");
			fDrawGraph("MSpd", "#00cc00");
			fDrawGraph("IAS",  "#cc00cc");
		 },
	 }
	
});






