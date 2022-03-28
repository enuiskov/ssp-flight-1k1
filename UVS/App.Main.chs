"use strict";

stuff
({
	uses :
	[
		'Math'           ,
		'Math.Geometry'  ,
		'System.Data'    ,
		'System.Drawing' ,
		'UVS'            ,
		'THREE (T*)'     ,
	],
	
	main : function()
	 {
		$.Q = Math.Geometry.Quaternion;
		$.V = Math.Geometry.Vector3;
		$.D090 = Math.D090;

		$.gApp = new function Application(){};
		 {
			
				$.gTable  = Data["SSPF1K1"].Table.Fixed;
				$.gSeries = Data["SSPF1K1"].Series.Fixed;

			if(0)
			{
				//gApp.PlotGrabber = new PlotGrabber({ZIndex : 8});
				gApp.PathFixer   = new PathFixer({Table : gTable,  ZIndex : 9});
				gApp.DataLeveler = new DataLeveler({Table : gTable, Series : gSeries, ZIndex : 10});
			}
			//return;
			//return;
			//return;
			//window.addEventListener("keypress", function(iEvt){console.info(iEvt.keyCode);}.Bind(this));


			gApp.ApproachDiagram      = new Imaging.ApproachDiagram ({VymData : Data["SSPF1K1"].Series.Original, ZIndex : 5, IsVisible : localStorage["Info(ApproachDiagram)"] == "true"});
			gApp.Simulator            = new Simulation.Engine       ({});

			gApp.HUD                  = new Equipment.HUD.Screen    ({Type : "Aircraft", Color : "#ffaa00", ZIndex : 2, IsVisible : localStorage["HUD.IsVisible"] != "false"});
			
			if(1)if(1) gApp.Renderer  = new Imaging.Renderer3D      ({IsWebGL : localStorage["IsWebGL"] == "true"});
			else       gApp.Fog       = new Imaging.FogLayer        ({});

			gfInitConsoles(gApp);
		 }
		
		$.gSIM = new function SimulatorObjects(){};
		 {

			gSIM.Vehicle = new Simulation.Vehicles.Buran();
			
			gApp.Simulator.Objects.Add(gSIM.Vehicle);

			if(gApp.HUD)
			{
				gApp.HUD.DataSource = gSIM.Vehicle;
			}
		 }
		
		gfInitW3D();
		gfInitEvents(gApp);
		
		window.onresize();


		if(1 && gApp.ApproachDiagram) gfCyclicUpdateALD();
		if(1 && gApp.HUD)         gfCyclicUpdateHUD();
		if(1 && gApp.Fog)         gfCyclicUpdateFOG();
		if(1 && gApp.Renderer)    gfCyclicUpdateR3D();

		setTimeout
		(
			function()
			{
				if    (0)                    gfCyclicUpdateALL();
				else
				{
					if(gApp.Simulator && 1) 1 ? gfCyclicUpdateSIM() : gfStartUpdateSIM();


					//gApp.Simulator.IsActive = true;
				}
			},
			1000
		);


		AppState.Load();
	 },
	gUpdateSpeed      : 1,
	gfStartUpdateSIM  : function()
	 {
		//gApp.ApproachDiagram.Series.Entries.Length = 360;//.Clear();

		var _StepC = 0;
		var _StepF = function()
		{
			if(gSIM.Vehicle.Position.Z < -7000) gApp.Simulator.IsActive = false;
			//if(gSIM.Vehicle.Velocity.Length < 10000) gApp.Simulator.IsActive = false;

			for(var cI = 0; cI < 10; cI++)
			{
				gApp.Simulator.Update(0.03);

				gfApplyKinematics(gApp.Simulator.LastDelta);
				gfApplyControl(gApp.Simulator.LastDelta);
			};
			//if(_StepC % 10 == 0) gApp.ApproachDiagram.Invalidate();
			if(_StepC % 1 == 0) gfUpdateDiagram();
			//if(_StepC % 10 == 0) gApp.ApproachDiagram.Invalidate();

			_StepC++;
		};
		setInterval(_StepF, 0);
	 },
	gfCyclicUpdateSIM : function(){setTimeout(gfCyclicUpdateSIM,  10 / gUpdateSpeed); 1 && gApp.Simulator.Update(); gfApplyKinematics(gApp.Simulator.LastDelta); gfApplyControl(gApp.Simulator.LastDelta); gfUpdateDiagram(true);},
	gfCyclicUpdateALL : function(){setTimeout(gfCyclicUpdateALL,  50 / gUpdateSpeed);                                           gApp.Simulator.Update(); gApp.HUD.Validate(); gApp.Renderer.Render(); },
	gfCyclicUpdateALD : function(){setTimeout(gfCyclicUpdateALD, 100 / gUpdateSpeed);                                         gApp.ApproachDiagram.Invalidate();},
	gfCyclicUpdateHUD : function(){setTimeout(gfCyclicUpdateHUD,  10 / gUpdateSpeed); if(gApp.ApproachDiagram.IsVisible) return;  gApp.HUD.Invalidate();},
	gfCyclicUpdateR3D : function(){setTimeout(gfCyclicUpdateR3D,  30 / gUpdateSpeed); if(gApp.ApproachDiagram.IsVisible) return;  gfSyncGraphics3D(); gApp.Renderer.Render();},
	gfCyclicUpdateFOG : function(){setTimeout(gfCyclicUpdateFOG,  50 / gUpdateSpeed); gApp.Fog.Render();},
	
	gfApplyKinematics : function(iDeltaT)
	 {
	 	//return;
		//if($.gApp.PathFixer) gApp.PathFixer.Update(iDeltaT);


		//gfApplyFixes(iDeltaT);
		//if(!gfApplyKinematics.FixRate) gfApplyKinematics.FixRate = 0;

		
		var _VehP = gSIM.Vehicle.Position;
		
		//if(isNaN(_VehP.Z)) debugger;
		if(1)
		{
			var _ActP = gSIM.Vehicle.Position;
			var _TgtP = UVS.Data.GetNearestEntry(_ActP).Value.Position.Clone();

			if(isNaN(_TgtP.Z)) debugger;

			var _PosD =  _TgtP.Subtract(_ActP).Rotate(gSIM.Vehicle.Rotation.Inverse()).Set(null,0,null).Rotate(gSIM.Vehicle.Rotation);

			var _AltF = Clamp01(Scale01(_ActP.Z,  500, 1000));
			var _AuPF = gSIM.Vehicle.Control.Inputs.Balance;

			//gMagic = 

			gSIM.Vehicle.Velocity.Linear.Add(_PosD.MultiplyScalar(0.1 * _AltF * _AuPF * iDeltaT), self);
			gSIM.Vehicle.Position       .Add(_PosD.MultiplyScalar(1   * _AltF * _AuPF * iDeltaT), self);
		}


		//return;
	 },
	gfApplyControl    : function(iDeltaT)
	 {
		if(gKeys.Control)
		{
			if(gKeys.Q)        {gSIM.Vehicle.Position.Z += 10;}
			if(gKeys.Period)   {gSIM.Vehicle.Velocity.Linear  = new Vector3; gSIM.Vehicle.Velocity.Angular = new Vector3;}
			if(gKeys.Question) {gSIM.Vehicle.Velocity.Angular = new Vector3;}
			

		}
		else
		{
			if(gKeys.Period)   gSIM.Vehicle.Cockpit.AttRates.MultiplyScalar(1.0 + (1 * iDeltaT), self);
			if(gKeys.Comma)    gSIM.Vehicle.Cockpit.AttRates.MultiplyScalar(1.0 - (1 * iDeltaT), self);
		}

		

		if(gKeys.Space) AppState.Load();
		
		if(!$.gWindV) $.gWindV = new Vector3(-5,+15,0);
		///if(!$.gWindV) $.gWindV = new Vector3(0,0,0);

		if(1)
		{
			var _Alt = gSIM.Vehicle.Position.Z;
			
			//var _V1 = new Vector3(-30, +50, 0).MultiplyScalar(1 - Abs(Clamp(Scale(_Alt, 10000, 17000))));
			//var _V2 = new Vector3( -0, +50, 0).MultiplyScalar(1 - Abs(Clamp(Scale(_Alt, 10000, 13000))));
			//var _V3 = new Vector3(  0,   0, 0).MultiplyScalar(1 - Abs(Clamp(Scale(_Alt,  5000, 10000))));

			//var _V1 = new Vector3(-5,+15,0);
			var _V1 = new Vector3(0,+75,0);
			//var _V2 = new Vector3(0, +10000, 0).MultiplyScalar(1 - Abs(Clamp(Scale(_Alt, 100000, 100))));;
			var _V2 = new Vector3(+10000, +10000, 0).MultiplyScalar(Clamp(Scale01(_Alt, 0, 100000)));
			var _V3 = new Vector3;


			//gWindV = _V1.Add(_V2).Add(_V3);
			//gWindV = _V1.Add(_V2);
		}
		if(1)
		{
			gSIM.Vehicle.LocTorqX.Factor *= 0.5;
			gSIM.Vehicle.LocTorqY.Factor *= 0.5;
			gSIM.Vehicle.LocTorqZ.Factor *= 0.5;
			//gSIM.Vehicle.GloTorqX.Factor *= 0.5;
			//gSIM.Vehicle.GloTorqY.Factor *= 0.5;
			//gSIM.Vehicle.GloTorqZ.Factor *= 0.5;
			
			

			if(gKeys.Shift)
			{
				var _Att = gSIM.Vehicle.Data.Attitude, _HdgF = Sign(Cos((_Att.Heading - _Att.HdgFix) * DTR));
				var _Inc  = 5 * iDeltaT;

				if(gKeys.Delete)   gWindV.X -= _Inc * _HdgF;
				if(gKeys.PageDown) gWindV.X += _Inc * _HdgF;

				if(gKeys.Home)     gWindV.Y += _Inc * _HdgF;
				if(gKeys.End)      gWindV.Y -= _Inc * _HdgF;
				
				if(gKeys.Insert)   gWindV.Z -= _Inc;
				if(gKeys.PageUp)   gWindV.Z += _Inc;
			}
			else
			{
				if(gKeys.Home)     gSIM.Vehicle.LocTorqX.Factor = -100;// * iDeltaT;
				if(gKeys.End)      gSIM.Vehicle.LocTorqX.Factor = +100;// * iDeltaT;

				if(gKeys.Insert)   gSIM.Vehicle.LocTorqZ.Factor = +100;// * iDeltaT;
				if(gKeys.PageUp)   gSIM.Vehicle.LocTorqZ.Factor = -100;// * iDeltaT;

				if(gKeys.Delete)   gSIM.Vehicle.LocTorqY.Factor =  -50;// * iDeltaT;
				if(gKeys.PageDown) gSIM.Vehicle.LocTorqY.Factor =  +50;// * iDeltaT;
			}
		}
		var _CPit = gSIM.Vehicle.Cockpit;
		{
			_CPit.Joystick.Set(0,0,0, self);

			
			
			if(gKeys.Shift)
			{
				if(gKeys.Up)    _CPit.BodyFlap += 1;
				if(gKeys.Down)  _CPit.BodyFlap -= 1;
			}
			else if(gKeys.Control)
			{
				var _VehC = gSIM.Vehicle.Control;

				if(gKeys.Minus)  _VehC.Inputs.Balance -= 0.05;
				if(gKeys.Equals) _VehC.Inputs.Balance += 0.05;

				_VehC.Inputs.Balance = Clamp(_VehC.Inputs.Balance);
			}
			else
			{
				//var _ManAngR = 90;
				

				if(gKeys.Up)      _CPit.Joystick.X = -1;
				if(gKeys.Down)    _CPit.Joystick.X = +1;

				if(gKeys.Left)    _CPit.Joystick.Y = -1;
				if(gKeys.Right)   _CPit.Joystick.Y = +1;

				var _FlatTurnF = Clamp01(Scale01(gSIM.Vehicle.Data.RAlt, 10, 0));

				_CPit.Joystick.Z = Mix(_CPit.Joystick.Z, -_CPit.Joystick.Y, _FlatTurnF);
				_CPit.Joystick.Y = Mix(_CPit.Joystick.Y, 0, _FlatTurnF);


				//if(gKeys.Left)    _CPit.Joystick.Z = +100;//_ManAngR;
				//if(gKeys.Right)   _CPit.Joystick.Z = -100;//_ManAngR;

				
				var _AccelF = _CPit.Throttle - (_CPit.SpdBrake / 87.0);
				{
					if(gKeys.Minus)  _AccelF -= 0.5 * iDeltaT;
					if(gKeys.Equals) _AccelF += 0.5 * iDeltaT;

					_AccelF = Clamp(_AccelF);

					_CPit.Throttle = +Max(0, _AccelF);
					_CPit.SpdBrake = -Min(0, _AccelF) * 87.0;
				}
			}
		}
		return;

		//gSIM.Vehicle.Engine.Factor = gKeys.A ? 1 : 0;
		
		
		
		//if(gKeys.Question) gSIM.Vehicle.Velocity.Angular = new Vector3;


		//if(0)
		//{
			//gForcesData.Enabled = true;
			//gForcesData.WriteLine("-- Linear --");
			//gForcesData.WriteLine(["G:Vel", gSIM.Vehicle.Velocity.Linear]);
			//gForcesData.WriteLine(["G:Acc", gSIM.Vehicle.Velocity.Acceleration.Linear]);
			//gForcesData.WriteLine(["G:Jrk", gSIM.Vehicle.Velocity.Acceleration.Jerk.Linear]);
			////gForcesData.WriteLine("--");
			////gForcesData.WriteLine(["L Vel  ", gSIM.Vehicle.Data.Velocity.Linear]);
			////gForcesData.WriteLine(["L  Acc ", gSIM.Vehicle.Data.Velocity.Acceleration.Linear]);
			////gForcesData.WriteLine(["L   Jrk", gSIM.Vehicle.Data.Velocity.Acceleration.Jerk.Linear]);
			//gForcesData.WriteLine();
			//gForcesData.WriteLine("-- Angular --");
			////gForcesData.WriteLine(["G:Vel", gSIM.Vehicle.Velocity.Angular]);
			////gForcesData.WriteLine(["G:Acc", gSIM.Vehicle.Velocity.Acceleration.Angular]);
			////gForcesData.WriteLine(["G:Jrk", gSIM.Vehicle.Velocity.Acceleration.Jerk.Angular]);
			////gForcesData.WriteLine("--");
			//gForcesData.WriteLine(["L Vel  ", gSIM.Vehicle.Data.Velocity.Angular]);
			//gForcesData.WriteLine(["L  Acc ", gSIM.Vehicle.Data.Velocity.Acceleration.Angular]);
			//gForcesData.WriteLine(["L   Jrk", gSIM.Vehicle.Data.Velocity.Acceleration.Jerk.Angular]);

		//}
		//if(1)
		//{
			//var _FliC = gSIM.Vehicle.Control;
			//{
				//_FliC.AngRates.Set(0,0,0, self);
				
				//if(gKeys.Shift)
				//{
					//if(gKeys.Up)    _FliC.BodyFlap += 0.01;
					//if(gKeys.Down)  _FliC.BodyFlap -= 0.01;
				//}
				//else
				//{
					//var _ManAngR = 30 * DTR;

					//if(gKeys.Up)      _FliC.AngRates.X = -_ManAngR;
					//if(gKeys.Down)    _FliC.AngRates.X = +_ManAngR;

					//if(gKeys.Left)    _FliC.AngRates.Y = -_ManAngR;
					//if(gKeys.Right)   _FliC.AngRates.Y = +_ManAngR;

					//if(gKeys.Minus)    _FliC.SpdBrake -= 0.05;
					//if(gKeys.Equals)   _FliC.SpdBrake += 0.05;
				//}
			//}
		//}
	 },
	gfUpdateDiagram   : function(iDoOncePerSecond)
	 {
		if(iDoOncePerSecond)
		{
			if(gfUpdateDiagram.LastDiagramUpdate == undefined) gfUpdateDiagram.LastDiagramUpdate = Date.Now - 1000;
			if(Date.Now - gfUpdateDiagram.LastDiagramUpdate < 1000) return;

			gfUpdateDiagram.LastDiagramUpdate = Date.Now;
		}
		
		if(gApp.PathFixer)
		{
			gApp.ApproachDiagram.SimData = gApp.DataLeveler.Series;
			gApp.ApproachDiagram.Cursor  = gApp.PathFixer.State.CurrRow;


			return;
		}
		else
		{
			if(!gApp.Simulator.IsActive || gSIM.Vehicle.Velocity.Linear.Length < 10) return;

			var _V = gApp.ApproachDiagram.SimData.CreateEntry(Date.Now,{}).Value;
			{
				_V.Time = Date.Now.ValueOf();

				_V.Position = gSIM.Vehicle.Position.Clone();
				_V.Vel      = gSIM.Vehicle.Velocity.Linear.Length;

				_V.MSpd = gSIM.Vehicle.Data.MSpd;
				_V.IAS  = gSIM.Vehicle.Data.IAS;
				//_V.IAS  = gSIM.Vehicle.Velocity.Linear.Length;
				//_V.IAS  = Simulation.Planets.Earth.Atmosphere.GetIAS(gSIM.Vehicle.Velocity.Linear.Length, gSIM.Vehicle.Data.BAlt); //~~ not an IAS;
				_V.VSpd = gSIM.Vehicle.Data.VSpd;
				_V.Bank = gSIM.Vehicle.Data.Attitude.Bank;
				_V.SpdB = gSIM.Vehicle.Surfaces.Actuators.SpdBrake.CurrValue;

				_V.FiEng = gSIM.Vehicle.Engine.Factor;
			}
			gApp.ApproachDiagram.Cursor = gApp.ApproachDiagram.SimData.Entries.Length - 1;
		}
	 },
});
stuff
({
	uses : 
	[
		'THREE (T*)',
		'Math',
		'Math.Geometry',
		'UVS',
	],
	gfInitW3D : function()
	 {
		$.gW3D = new function World3DObjects(){}; if(gApp.Renderer)
		 {
			Imaging.Routines.CreateScene("LandingSites/Baikonur");

			gApp.Renderer.Camera.Mode = localStorage["Camera.Mode"] || "Num1";

			gW3D.Scene        = gApp.Renderer.Scene;

			gW3D.Stratosphere = gW3D.Scene.getObjectByName("Stratosphere");
			gW3D.Troposphere  = gW3D.Scene.getObjectByName("Troposphere");
			gW3D.Clouds       = gW3D.Scene.getObjectByName("Clouds");
			//gW3D.TerrScreen   = gW3D.Scene.getObjectByName("TerrScreen");
			gW3D.Terrain      = gW3D.Scene.getObjectByName("Terrain");
			gW3D.Camera       = gApp.Renderer.Camera;
			gW3D.Vehicle      = Imaging.Routines.CreateBuran();
			{

				if(gW3D.Vehicle.getObjectByName("Tail") != undefined)
				{
					gW3D.Tail = gW3D.Vehicle.getObjectByName("Tail");
					{
						gW3D.Tail.position      = gSIM.Vehicle.Tail.Position.ToTHREE();
						gW3D.Tail.quaternion    = gSIM.Vehicle.Tail.Rotation.ToTHREE();
					}
				}
				
				gW3D.RudderL   = gW3D.Vehicle.getObjectByName("RudderL");
				gW3D.RudderR   = gW3D.Vehicle.getObjectByName("RudderR");

				gW3D.ElevInL   = gW3D.Vehicle.getObjectByName("ElevInL");
				gW3D.ElevOuL   = gW3D.Vehicle.getObjectByName("ElevOuL");
				gW3D.ElevInR   = gW3D.Vehicle.getObjectByName("ElevInR");
				gW3D.ElevOuR   = gW3D.Vehicle.getObjectByName("ElevOuR");

				gW3D.BodyFlap  = gW3D.Vehicle.getObjectByName("BodyFlap");

				gW3D.NoseGear  = gW3D.Vehicle.getObjectByName("NoseGear");
				gW3D.MainGearL = gW3D.Vehicle.getObjectByName("MainGearL");
				gW3D.MainGearR = gW3D.Vehicle.getObjectByName("MainGearR");

				gW3D.LandingGears = gW3D.Vehicle.getObjectByName("LandingGears");

				gW3D.NoseEngine = gW3D.Vehicle.getObjectByName("NoseEngine",true);


				gW3D.Vehicle.Shadow = gW3D.Scene.getObjectByName("VehicleShadow");
				gW3D.EnvFrame       = gW3D.Scene.getObjectByName("EnvFrame");

				gW3D.ShadowNG = gW3D.Scene.getObjectByName("ShadowNG");
				gW3D.ShadowLG = gW3D.Scene.getObjectByName("ShadowLG");
				gW3D.ShadowRG = gW3D.Scene.getObjectByName("ShadowRG");
			}
			gW3D.Scene.add(gW3D.Vehicle);

			//~~UVS.Imaging.Routines.UpdateTrajectory();

			//gApp.Renderer.ThreeRenderer.scene = gW3D.Scene;
			//gApp.Renderer.Scene = gW3D.Scene;
			//gApp.Renderer.Scene
		 };
	 },
	gfSyncGraphics3D  : function()
	 {
		gW3D.PosV = gSIM.Vehicle.Position.ToTHREE();
		gW3D.RotV = gSIM.Vehicle.Rotation.ToTHREE();

		//gW3D.CamPos = ;

		gW3D.Vehicle.position    .copy(gW3D.PosV);
		gW3D.Vehicle.quaternion  .copy(gW3D.RotV);

		gW3D.RudderL.position    .copy(gSIM.Vehicle.RudderL.Position.ToTHREE()  || new TVector3);
		gW3D.RudderL.quaternion  .copy(gSIM.Vehicle.RudderL.Rotation.ToTHREE()  || new TQuaternion);
		gW3D.RudderR.position    .copy(gSIM.Vehicle.RudderR.Position.ToTHREE()  || new TVector3);
		gW3D.RudderR.quaternion  .copy(gSIM.Vehicle.RudderR.Rotation.ToTHREE()  || new TQuaternion);
		
		gW3D.ElevInL.position    .copy(gSIM.Vehicle.ElevInL.Position.ToTHREE()  || new TVector3);
		gW3D.ElevInL.quaternion  .copy(gSIM.Vehicle.ElevInL.Rotation.ToTHREE()  || new TQuaternion);
		gW3D.ElevOuL.position    .copy(gSIM.Vehicle.ElevOuL.Position.ToTHREE()  || new TVector3);
		gW3D.ElevOuL.quaternion  .copy(gSIM.Vehicle.ElevOuL.Rotation.ToTHREE()  || new TQuaternion);

		gW3D.ElevInR.position    .copy(gSIM.Vehicle.ElevInR.Position.ToTHREE()  || new TVector3);
		gW3D.ElevInR.quaternion  .copy(gSIM.Vehicle.ElevInR.Rotation.ToTHREE()  || new TQuaternion);
		gW3D.ElevOuR.position    .copy(gSIM.Vehicle.ElevOuR.Position.ToTHREE()  || new TVector3);
		gW3D.ElevOuR.quaternion  .copy(gSIM.Vehicle.ElevOuR.Rotation.ToTHREE()  || new TQuaternion);

		gW3D.BodyFlap.position   .copy(gSIM.Vehicle.BodyFlap.Position.ToTHREE() || new TVector3);
		gW3D.BodyFlap.quaternion .copy(gSIM.Vehicle.BodyFlap.Rotation.ToTHREE() || new TQuaternion);

		var _GearCmd = 1.001 - ((Clamp(gW3D.PosV.z, 400, 500) - 400) / 100);
		///var _GearCmd = Clamp(Scale01(gW3D.PosV.z, 10,5), 0,1) + 0.001;// 1.001 - ((Clamp(gW3D.PosV.z, 400, 500) - 400) / 100);

		if(gApp.Renderer.IsWebGL)
		{
			var _Shadow = gW3D.Vehicle.Shadow;
			{
				_Shadow.position.copy(gW3D.PosV.clone().setZ(0));
				_Shadow.rotation.set (0,0,(gSIM.Vehicle.Data.Attitude.HdgFix - gSIM.Vehicle.Data.Attitude.Heading) * DTR);
				
				var _AltF = Clamp(Scale01(gSIM.Vehicle.Data.BAlt, 0, 30), 0,1);

				_Shadow.scale.set(1 + (_AltF * 1), 1 + (_AltF * 1), 1);
				_Shadow.material.opacity = 0.8 - _AltF;
			}
			
			
			gW3D.LandingGears.scale.z = _GearCmd;
			gW3D.LandingGears.position.z = (4.6 * _GearCmd) -1;

			Environment :
			{
				gApp.Renderer.UpdateCamera();

				var _Alt  = gApp.Renderer.Camera.position.z;
				var _Dist = gApp.Renderer.Camera.position.clone().setZ(0).length();
				
				var _StrMat = gW3D.Stratosphere.material,  _StrOpa = _Alt > 10000 ? 1 : 0;//Clamp01(Scale01(_Alt, 10000, 11000));
				//var _TroMat = gW3D.Troposphere .material,  _TroOpa = Min(Scale01(_Alt, 15000, 10000), Scale01(_Alt, 1500, 1600));
				var _TroMat = gW3D.Troposphere .material,  _TroOpa = Min(Scale01(_Alt, 15000, 10000), Scale01(_Alt, 1000, 1200));
				///var _TroMat = gW3D.Troposphere .material,  _TroOpa = Min(Scale01(_Alt, 15000, 10000), Scale01(_Alt, -100, 0));
				//var _CloMat = gW3D.Clouds      .material,  _CloOpa = 0;//~~Clamp01(Scale01(_Alt, 600, 500));//Max(Min(_TroOpa, Scale01(_Alt, 5000,2000)), Scale01(_Alt, 900, 800));
				var _CloMat = gW3D.Clouds      .material,  _CloOpa = Clamp01(Scale01(_Alt, 1000, 900));//Max(Min(_TroOpa, Scale01(_Alt, 5000,2000)), Scale01(_Alt, 900, 800));
				//var _TScMat = gW3D.TerrScreen  .material,  _TScOpa = _Alt > 1000 ? 0 : 1 - _CloOpa;//Scale01(_Alt, 1200,1100);
				//var _TerMat = gW3D.Terrain     .material,  _TerOpa = 1;//~~_Alt < 1000 ? 1 : 0;//Min(_CloOpa, _Alt > 900 ? 0 : 1);
				var _TerMat = gW3D.Terrain     .material,  _TerOpa = _Alt < 1000 ? 1 : 0;//Min(_CloOpa, _Alt > 900 ? 0 : 1);

				_StrMat.opacity = _StrOpa;  _StrMat.transparent = false; gW3D.Stratosphere.visible = _StrOpa > 0;
				_TroMat.opacity = _TroOpa;  _TroMat.transparent = true;  gW3D.Troposphere.visible  = _TroOpa > 0;
				_CloMat.opacity = _CloOpa;  _CloMat.transparent = true;  gW3D.Clouds.visible       = _CloOpa > 0;//_CloOpa > 0;


				//_TScMat.opacity = _TScOpa;  _TScMat.transparent = _TScOpa < 1;  gW3D.TerrScreen.visible  = _TScOpa > 0;
				_TerMat.opacity = _TerOpa;  _TerMat.transparent = false; gW3D.Terrain.visible      = _TerOpa > 0;

				gW3D.Stratosphere.position.x = gW3D.Troposphere.position.x = gW3D.Camera.position.x;
				gW3D.Stratosphere.position.y = gW3D.Troposphere.position.y = gW3D.Camera.position.y;

				//gW3D.Clouds.quaternion       . copy(Quaternion.Rotated(0, _Alt > 1000 ? 0 : D180,0).ToTHREE());

				gW3D.Scene.fog.far = 10 + (Clamp(Abs(Scale(1000 - _Alt, 200)) * 10000, 100, 100000));// * (_Alt < 1000 ? Clamp01(1 - (_Dist / 30000)) : 1));
				//gW3D.Scene.fog.far = 10000;
				
				var _Signal, _Noise;
				{
					var _DistF  = Clamp01(Scale01(_Dist, 0, 20000));
					var _AltF   = Clamp01(_Dist / (_Alt * 100));
					var _ShakeF = Clamp01(gSIM.Vehicle.Velocity.Acceleration.Linear.Length * 0.005 + gSIM.Vehicle.Velocity.Acceleration.Angular.Length * 0.25);
					var _Noise  = Min(_DistF, _AltF) + _ShakeF;
					
					_Signal = 1 - Clamp01(_Noise);
					
				}
				
				gATVUniforms["time"].value = new Date() / 1000 % 1;
				gATVUniforms["sheet"].value = 1 - Abs(Clamp(Scale(1000 - _Alt, 200)));
				gATVUniforms["signal" ].value = gApp.Renderer.Camera.Mode == "Num1" ? _Signal : 1;

				/*
					
					1300 = 0
					1250 = 0.5
					1200 = 1
					1100
					1000 = 1
					 900
					 800 = 1
					 750 = 0.5
					 700 = 0
				*/

				gATVUniforms["signal"].value = gApp.Renderer.Camera.Mode == "Num1" ? _Signal : 1;
			}
		}
		else
		{
			var _GearOffsV = new TVector3(0,0, 2.5 - (_GearCmd * 2.5));

			gW3D.NoseGear  .position   .copy((gSIM.Vehicle.NoseGear .Position || new Vector3)     .ToTHREE().add(_GearOffsV));
			gW3D.NoseGear  .quaternion .copy((gSIM.Vehicle.NoseGear .Rotation || new Quaternion)  .ToTHREE()                );
			gW3D.MainGearL .position   .copy((gSIM.Vehicle.MainGearL.Position || new Vector3)     .ToTHREE().add(_GearOffsV));
			gW3D.MainGearR .position   .copy((gSIM.Vehicle.MainGearR.Position || new Vector3)     .ToTHREE().add(_GearOffsV));

			gW3D.ShadowNG  .position   .copy(gSIM.Vehicle.LocalToGlobal(gSIM.Vehicle.NoseGear.Position) .ToTHREE().setZ(0));
			gW3D.ShadowLG  .position   .copy(gSIM.Vehicle.LocalToGlobal(gSIM.Vehicle.MainGearL.Position).ToTHREE().setZ(0));
			gW3D.ShadowRG  .position   .copy(gSIM.Vehicle.LocalToGlobal(gSIM.Vehicle.MainGearR.Position).ToTHREE().setZ(0));

			if(1)
			{
				var _EnvP = gSIM.Vehicle.Position.Add(new Vector3(0,0,-200).Rotate(Quaternion.FromTHREE(gW3D.Camera.quaternion)));
				{
					_EnvP.X = Round(_EnvP.X / 200) * 200;
					_EnvP.Y = Round(_EnvP.Y / 200) * 200;
					_EnvP.Z = Round(_EnvP.Z / 200) * 200;

					_EnvP.Z = Max(_EnvP.Z, 500);
				}
				gW3D.EnvFrame.position.copy(_EnvP.ToTHREE());
			}
		}
	 },
});