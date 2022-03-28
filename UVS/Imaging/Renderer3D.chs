"use strict";

stuff
({
	uses :
	[
		'THREE : *, -Math, -Geometry (T*)',
		'Math',
		'Math.Geometry',
	],
	
	'UVS.Imaging' : 
	 {
		'Renderer3D' :
		 {
			ThreeRenderer  : nil('THREE.WebGLRenderer'),
			Camera         : obj('THREE.Camera'),
			Scene          : obj('THREE.Scene'),
			
			IsWebGL        : boo(false),
			LastRenderTime : num,
			LastTimeDelta  : num,
			Resolution     : num(1),

			constructor : function annex(iAA)
			 {
				//this << iAA.IsWebGL || false;

				//this.ThreeRenderer = this.IsWebGL ? new WebGLRenderer() : new CanvasRenderer();
				this.ThreeRenderer = this.IsWebGL ? new TWebGLRenderer() : new TCanvasRenderer();
				{
					


					//this.ThreeRenderer.autoClear = false;//setClearColor(0x000000);
					//this.ThreeRenderer.autoClearDepth = false;//setClearColor(0x000000);
					this.ThreeRenderer.setClearColor(this.IsWebGL ? 0xffffff : 0x000000);
					//this.ThreeRenderer.shadowMapEnabled = true;
					this.ThreeRenderer.setSize(window.innerWidth, window.innerHeight);
					this.ThreeRenderer.domElement.id = "W3D";
					
					document.body.appendChild(this.ThreeRenderer.domElement);

					window.addEventListener("resize", this.UpdateSize.Bind(this));
				}
				this.Camera = new TPerspectiveCamera(75, 1, 1, 1e6);
				this.Scene  = iAA.Scene || new TScene;


				// postprocessing
				this.FxComposer = new TEffectComposer(this.ThreeRenderer);
				{
					this.FxComposer.addPass(new TRenderPass(this.Scene, this.Camera));

					var _Effect = new TShaderPass(TATVShader);
					{
						$.gATVUniforms = _Effect.uniforms;

						//_Effect.uniforms['scale'].value = 4;
						_Effect.renderToScreen = true;
					}
					this.FxComposer.addPass(_Effect);

					//var effect = new THREE.ShaderPass( THREE.RGBShiftShader );
					//effect.uniforms[ 'amount' ].value = 0.0015;
					//effect.renderToScreen = true;
					//this.FxComposer.addPass( effect );
				}

				this.LastRenderTime = new Date() - 100;
				this.LastTimeDelta  = 0.1;

				this.UpdateSize();
			 },

			Render : function()
			{
				

				this.UpdateCamera();

				if(this.IsWebGL && 1) this.FxComposer.render(); else this.ThreeRenderer.render(this.Scene, this.Camera);
				

				//var _Now = new Date();
				this.LastTimeDelta  = (new Date() - this.LastRenderTime) / 1000;
				this.LastRenderTime = new Date().ValueOf();
			},

			//constructor : function(iAA)
			 //{
				//this << iAA.IsWebGL || false;

				////this.ThreeRenderer = this.IsWebGL ? new WebGLRenderer() : new CanvasRenderer();
				//this.ThreeRenderer = this.IsWebGL ? new TWebGLRenderer() : new TCanvasRenderer();
				//{
					////this.ThreeRenderer.autoClear = false;//setClearColor(0x000000);
					////this.ThreeRenderer.autoClearDepth = false;//setClearColor(0x000000);
					//this.ThreeRenderer.setClearColor(this.IsWebGL ? 0xf7f3e8 : 0x000000);
					////this.ThreeRenderer.shadowMapEnabled = true;
					//this.ThreeRenderer.setSize(window.innerWidth, window.innerHeight);
					//this.ThreeRenderer.domElement.id = "W3D";
					
					//document.body.appendChild(this.ThreeRenderer.domElement);

					//window.addEventListener("resize", this.UpdateSize.Bind(this));
				//}
				//this.Camera = new TPerspectiveCamera(75, 1, 1, 1e6);
				//this.Scene  = iAA.Scene || new TScene;

				//this.LastRenderTime = new Date() - 100;
				//this.LastTimeDelta  = 0.1;

				//this.UpdateSize();
			 //},

			//Render : function()
			//{
				//this.UpdateCamera();
				//this.ThreeRenderer.render(this.Scene, this.Camera);

				////var _Now = new Date();
				//this.LastTimeDelta  = (new Date() - this.LastRenderTime) / 1000;
				//this.LastRenderTime = new Date().ValueOf();
			//},

			UpdateSize : function()
			{
				this.ThreeRenderer.setSize(window.innerWidth, window.innerHeight);
				
				

				if(this.IsWebGL)
				{
					this.ThreeRenderer.setViewport(0,0, window.innerWidth * this.Resolution, window.innerHeight * this.Resolution);
					this.ThreeRenderer.domElement.width  = window.innerWidth * this.Resolution;
					this.ThreeRenderer.domElement.height = window.innerHeight * this.Resolution;
				}
				//else
				//{
					//var _Ctx = this.ThreeRenderer.domElement;
					
				//}
				
				

				this.Camera.aspect = window.innerWidth / window.innerHeight;
				this.Camera.updateProjectionMatrix();
			},
			UpdateCamera : function(iDeltaT)
			{
				var _VehP = gSIM.Vehicle.Position.Add(new Vector3(0,0,3));
				var _VehR = gSIM.Vehicle.Rotation;

				var _CamP = new Vector3(0,10,10);
				var _TgtP = _VehP.Clone();

				var _UpV  = new Vector3(0,0,1);
				var _FoV  = 70;

				switch(this.Camera.Mode)
				{
					case "Num1"  : //~~ Vehicle front view camera;
					 {
						_CamP = gSIM.Vehicle.Position.Add(new Vector3(0,+18, 2).Rotate(_VehR));
						_TgtP = gSIM.Vehicle.Position.Add(new Vector3(0,+20, 2).Rotate(_VehR));

						_UpV  = new Vector3(0,0,10).Rotate(_VehR);
						
						break;
					 }
					
					case "Num2"  : //~~ Outer view;
					 {
						if(!$.gLastCamR) $.gLastCamR = {X : 3.7, Y : 0};
						
						if(gMouse.B2)
						{
							gLastCamR.X += gMouse.DX * 0.01; //~~ angle (rad);
							gLastCamR.Y += gMouse.DY * 0.5;  //~~ Z bias (meters);

							gLastCamR.Y = Clamp(gLastCamR.Y, 30);
						}
						var _AbsA = gLastCamR.X;

						_CamP = new Vector3
						(
							//Sin(_AbsA) * 50000,
							//Cos(_AbsA) * 50000,
							Sin(_AbsA) * 10000,
							Cos(_AbsA) * 10000,
							gLastCamR.Y * 100
						);
						//_CamP
						_TgtP = new Vector3;
						//_TgtP = new Vector3(0,0,10000);
						
						var _TgtBias = new Vector3(0,14500,4500);
						{
							_CamP.Add(_TgtBias, self);
							_TgtP.Add(_TgtBias, self);
						}

						_FoV = 40;

						break;
					 }
					case "Num3"  : //~~ Near origin, flies around;
					 {
						var _Time = Date.Now.ValueOf();

						_CamP = new Vector3(Sin(-Date.Now / 1000) * 30, Cos(-Date.Now / 1000) * 30, 10);
						_TgtP = new Vector3(0,0,0);
						_FoV  = 50;

						break;
					 }
					case "Num4"  : //~~ Near vehicle, mouse controlled;
					 {
						if(!$.gLastCamR) $.gLastCamR = {X : 3.7, Y : 0};
						
						if(gMouse.B2)
						{
							gLastCamR.X += gMouse.DX * 0.01; //~~ angle (rad);
							gLastCamR.Y += gMouse.DY * 0.5;  //~~ Z bias (meters);

							gLastCamR.Y = Clamp(gLastCamR.Y, 30);
						}
						var _AbsA = gLastCamR.X - EulerAngles.FromQuaternion(_VehR, "ZXY").Z;

						_CamP = _VehP.Add(new Vector3(Sin(_AbsA) * 30, Cos(_AbsA) * 30, gLastCamR.Y));
						_TgtP.Add(new Vector3(0,0,2), self);
						_FoV = 60;

						break;
					 }
					case "Num5"  : //~~ Stationary high-zoom tracking camera;
					 {
						_CamP = new Vector3(-500,0,30);
						_FoV = Clamp(3000 / _CamP.Subtract(_VehP).Length, 0.01, 50);

						break;
					 }
					case "Num6"  : //~~ Camera looks to runway center through vehicle body;
					 {
						_CamP =_VehP.Add(_VehP.Normalize().MultiplyScalar(30));
						_FoV  = 50;

						break;
					 }
					case "Num7"  : //~~ Chases vehicle;
					 {
						_CamP = _VehP.Add(gSIM.Vehicle.Velocity.Linear.Normalize().MultiplyScalar(-30));
						_UpV  = new Vector3(0,0,1).Rotate(_VehR);
						_FoV  = 75;
						
						break;
					 }
					case "Num8": //~~ random fixed spot;
					 {
						var _VehV = gSIM.Vehicle.Velocity.Linear;

						if(!$.gLastCamP || _VehP.DistanceTo($.gLastCamP) > Max(_VehV.Length * 10, 1000))
						{
							$.gLastCamP =
							(
								gSIM.Vehicle.Position
								.Add(_VehV.MultiplyScalar(9.9).Rotate(Quaternion.Rotated(0,0,(Random() - 0.5) * 45 * DTR)))
								//.Add(new Vector3((Random() - 0.5) * _VehV.Length * 10, (Random() - 0.5) * _VehV.Length * 10, 0))
							);
							gLastCamP.Z = Max(gLastCamP.Z, 10);
						}
						_CamP = gLastCamP;
						_FoV = (3000 / _CamP.Subtract(_VehP).Length);

						break;
					 }
					case "Num0": //~~ automatic;
					 {
						
		

						if(_VehP.Z < 5000) //~~ LOCALIZER;
						{
							var _SecTgtP = _TgtP.Clone().Set(0,null,null), _SecTgtW = 1 - Abs(Clamp(Magic(Scale(_VehP.X, 50), 0.3)));

							if(_VehP.Z > 40)
							{
								_CamP = _TgtP.Add(new Vector3(0, Sign(_VehP.Y) * 100, 0)).Set(0,null,null);
								_FoV  = 20;
							}
							else
							{
								_SecTgtP = _VehP.Set(null,0,0);
								_CamP = new Vector3(0, Sign(_VehP.Y) * 5000, 30);
								_FoV  = 1;
							}
							//_SecTgtW = 
							//~~_TgtP = Vector3.Add(_SecTgtP.MultiplyScalar(_SecTgtW), _TgtP.MultiplyScalar(1 - _SecTgtW));

							_TgtP = Vector3.Mix(_TgtP, _SecTgtP, _SecTgtW);



							//_TgtP = _SecTgtP;//.MultiplyScalar(_SecTgtW), _TgtP.MultiplyScalar(1 - _SecTgtW))

							//if(Abs(_TgtP.X) < 50)
							//{
								
								////var _TgtV = new Vector3, _TgtW = 0;

								////Vector3.Add(_VehP.MultiplyScalar(1), _TgtV.MultiplyScalar(1 - )), 
								
								
								////~~_SecTgtP.X = Magic(_TgtP.X / 50, 0.2) * 50;


								////_TgtP.Y = _VehP.Y;
							//}
						}
						else //~~ HAC;
						{
							
							var _GuideS  = UVS.Simulation.Vehicles.Buran.GuidanceSystem;
							var _CylId   = _GuideS.Routines.GetSuitableHAC();
							var _CylInfo = _GuideS.Routines.GetHACInfo(_CylId, gSIM.Vehicle);
							
							var _CamP = _CylInfo.CenPos.Add(_CylInfo.VehRelPos.Rotate(Quaternion.Rotated(0,0, +1 * DTR)).Normalize().MultiplyScalar(6000)).Set(null,null, _VehP.Z - 30);
						
							_FoV = Clamp(2000 / _CamP.DistanceTo(_TgtP),10, 90);
						}
						break;
					 }
					default : throw "WTF";
				}

				var _Cam = this.Camera;
				{
					_Cam.position . copy(_CamP.ToTHREE());
					_Cam.up       . copy(_UpV.ToTHREE());
					_Cam.fov      = _FoV;

					_Cam.lookAt(_TgtP.ToTHREE());
					_Cam.updateProjectionMatrix();
				}
			}
		 },
	 }
});