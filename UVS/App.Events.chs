"use strict";

stuff
({
	uses :
	[
	],
	
	gfInitEvents          : function(iApp)
	 {
		window.onresize = function()
		{
			//if($.iApp.Screen)   iApp.Screen   .UpdateSize();
			//if($.iApp.Renderer) iApp.Renderer .UpdateSize();
			//if($.iApp.FogLayer) iApp.FogLayer .UpdateSize();
		};
		$.gMouse = {X : 0, Y : 0, DX : 0, DY : 0, B1 : false, B2 : false, B3 : false};
		{
			window.onmousemove = function(iEvt)
			{
				gMouse.DX = iEvt.x - gMouse.X;
				gMouse.DY = iEvt.y - gMouse.Y;

				gMouse.X  = iEvt.x;
				gMouse.Y  = iEvt.y;
			};
			window.onmousedown = function(iEvt)
			{
				if(iEvt.button == 0) gMouse.B1 = true;
				if(iEvt.button == 1) gMouse.B2 = true;
				if(iEvt.button == 2) gMouse.B3 = true;

			};
			window.onmouseup = function(iEvt)
			{
				if(iEvt.button == 0) gMouse.B1 = false;
				if(iEvt.button == 1) gMouse.B2 = false;
				if(iEvt.button == 2) gMouse.B3 = false;
			};

		};

		$.gKeys = {};
		{
			
			window.addEventListener("keydown", function(iEvt)
			{
				switch(iEvt.keyCode)
				{
					case 17 : $.gKeys.Control   = true; break;
					case 18 : $.gKeys.Alt       = true; break;

					//case 67 : $.gW3D && gW3D.Cameras.CurrentViewMode++;    break; //~~ Impulse;
					case 13 : $.gKeys.Enter     = true; break;
					case 16 : $.gKeys.Shift     = true; break;
					case 32 : $.gKeys.Space     = true; break;
					
					case 33 : $.gKeys.PageUp    = true; break;
					case 34 : $.gKeys.PageDown  = true; break;
					case 45 : $.gKeys.Insert    = true; break;
					case 46 : $.gKeys.Delete    = true; break;
					case 36 : $.gKeys.Home      = true; break;
					case 35 : $.gKeys.End       = true; break;



					case 38 : $.gKeys.Up        = true; break;
					case 40 : $.gKeys.Down      = true; break;
					case 37 : $.gKeys.Left      = true; break;
					case 39 : $.gKeys.Right     = true; break;

					case 65 : $.gKeys.A         = true; break;
					case 66 : $.gKeys.B         = true; break;
					case 67 : $.gKeys.C         = true; break;
					case 68 : $.gKeys.D         = true; break;
					case 69 : $.gKeys.E         = true; break;
					case 70 : $.gKeys.F         = true; break;
					case 71 : $.gKeys.G         = true; break;
					case 72 : $.gKeys.H         = true; break;
					case 73 : $.gKeys.I         = true; break;
					case 74 : $.gKeys.J         = true; break;
					case 75 : $.gKeys.K         = true; break;
					case 76 : $.gKeys.L         = true; break;
					case 77 : $.gKeys.M         = true; break;
					case 78 : $.gKeys.N         = true; break;
					case 79 : $.gKeys.O         = true; break;
					case 80 : $.gKeys.P         = true; break;
					case 81 : $.gKeys.Q         = true; break;
					case 82 : $.gKeys.R         = true; break;
					case 83 : $.gKeys.S         = true; break;
					case 84 : $.gKeys.T         = true; break;
					case 85 : $.gKeys.U         = true; break;
					case 86 : $.gKeys.V         = true; break;
					case 87 : $.gKeys.W         = true; break;
					case 88 : $.gKeys.X         = true; break;
					case 89 : $.gKeys.Y         = true; break;
					case 90 : $.gKeys.Z         = true; break;


					//case 219 : if($.gAP) gAP.Heading -= 1; break; //~~ [;
					//case 221 : if($.gAP) gAP.Heading += 1; break; //~~ ];
					////case 189 : if($.gAP) gAP.VSpeed  -= 1; break; //~~ -;
					////case 187 : if($.gAP) gAP.VSpeed  += 1; break; //~~ +;
					//case 220 : if($.gAP) gAP.VSpeed  = gSIM.Vehicle.PDelta.Z; break; //~~ \;

					////case 220 : if($.gAP) gAP.VSpeed  = gSIM.Vehicle.PDelta.Z; break; //~~ \;

					case 187 : $.gKeys.Equals   = true; break;
					case 189 : $.gKeys.Minus    = true; break;

					case 188 : $.gKeys.Comma    = true; break;
					case 190 : $.gKeys.Period   = true; break;
					case 191 : $.gKeys.Question = true; break;
					//case 192 : $.gKeys.Tilda    = true; break;

				}
				

				switch(iEvt.keyCode)
				{
					case 13 :
					{
						//gSIM.Vehicle.Autopilot.Toggle();
						gSIM.Vehicle.Control.Inputs.BalRate = -gSIM.Vehicle.Control.Inputs.BalRate || (gSIM.Vehicle.Control.Inputs.Balance > 0.5 ? -1 : +1);
						
						break;
					}

					case 72 : iApp.HUD.ToggleVisibility(); localStorage["HUD.IsVisible"] = gApp.HUD.IsVisible; break;
					

					case 96 : case 97 : case 98 : case 99 : case 100 : case 101 : case 102 : case 103 : case 104 : case 105 :
					{
						if(iApp.Renderer) iApp.Renderer.Camera.Mode = localStorage["Camera.Mode"] = "Num" + (iEvt.keyCode - 96);

						$.gLastCamP = undefined;

						break;
					}

					case  19 : if(iApp.Simulator) iApp.Simulator.IsActive =! iApp.Simulator.IsActive; break;
					case 192 : iApp.ApproachDiagram.ToggleVisibility(); localStorage["Info(ApproachDiagram)"] = gApp.ApproachDiagram.IsVisible; break;

					case  82 :
					{
						if(iEvt.altKey)
						{
							localStorage["IsWebGL"] = !gApp.Renderer.IsWebGL;
							window.location.reload();
							iEvt.preventDefault();
						}
						break;
					}

					case  48 : case 49 : case 50 : case  51 : case  52 :
					case  53 : case 54 : case 55 : case  56 : case  57 : 
					{
						if(iEvt.altKey)
						{
							var _Cns = iApp.Consoles[iEvt.keyCode - 48];

							if(_Cns)
							{
								_Cns.ToggleVisibility();
								localStorage["Info(" + _Cns.Title + ")"] = _Cns.IsVisible;
							}
						}
						else
						{
							if(iEvt.ctrlKey) AppState.Save(iEvt.keyCode - 48);
							else             AppState.Load(iEvt.keyCode - 48);

							iEvt.preventDefault();
						}
						break;
					}
				}
				//iEvt.preventDefault();
				
				if($.gKeys.Control || $.gKeys.Shift || $.gKeys.Alt) 
				{
					iEvt.preventDefault();
				}
			});

			window.addEventListener("keyup", function(iEvt)
			{
				switch(iEvt.keyCode)
				{
					case 17 : $.gKeys.Control   = false; break;
					case 18 : $.gKeys.Alt       = false; break;

					case 13 : $.gKeys.Enter     = false; break;
					case 16 : $.gKeys.Shift     = false; break;
					case 32 : $.gKeys.Space     = false; break;
					
					case 33 : $.gKeys.PageUp    = false; break;
					case 34 : $.gKeys.PageDown  = false; break;
					case 45 : $.gKeys.Insert    = false; break;
					case 46 : $.gKeys.Delete    = false; break;
					case 36 : $.gKeys.Home      = false; break;
					case 35 : $.gKeys.End       = false; break;

					case 38 : $.gKeys.Up        = false; break;
					case 40 : $.gKeys.Down      = false; break;
					case 37 : $.gKeys.Left      = false; break;
					case 39 : $.gKeys.Right     = false; break;

					case 65 : $.gKeys.A         = false; break;
					case 66 : $.gKeys.B         = false; break;
					case 67 : $.gKeys.C         = false; break;
					case 68 : $.gKeys.D         = false; break;
					case 69 : $.gKeys.E         = false; break;
					case 70 : $.gKeys.F         = false; break;
					case 71 : $.gKeys.G         = false; break;
					case 72 : $.gKeys.H         = false; break;
					case 73 : $.gKeys.I         = false; break;
					case 74 : $.gKeys.J         = false; break;
					case 75 : $.gKeys.K         = false; break;
					case 76 : $.gKeys.L         = false; break;
					case 77 : $.gKeys.M         = false; break;
					case 78 : $.gKeys.N         = false; break;
					case 79 : $.gKeys.O         = false; break;
					case 80 : $.gKeys.P         = false; break;
					case 81 : $.gKeys.Q         = false; break;
					case 82 : $.gKeys.R         = false; break;
					case 83 : $.gKeys.S         = false; break;
					case 84 : $.gKeys.T         = false; break;
					case 85 : $.gKeys.U         = false; break;
					case 86 : $.gKeys.V         = false; break;
					case 87 : $.gKeys.W         = false; break;
					case 88 : $.gKeys.X         = false; break;
					case 89 : $.gKeys.Y         = false; break;
					case 90 : $.gKeys.Z         = false; break;

					case 187 : $.gKeys.Equals   = false; break;
					case 189 : $.gKeys.Minus    = false; break;

					case 188 : $.gKeys.Comma    = false; break;
					case 190 : $.gKeys.Period   = false; break;
					case 191 : $.gKeys.Question = false; break;
					case 192 : $.gKeys.Tilda    = false; break;

					//default  : console.info(iEvt.keyCode);
				}
				//iEvt.preventDefault();
				//console.info(iEvt.keyCode);
			});
		}
		window.onresize();
	 },
});