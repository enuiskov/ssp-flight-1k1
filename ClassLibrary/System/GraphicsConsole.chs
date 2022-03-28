"use strict";

stuff
 ({
	uses :
	[
		'Math',
		//'Math.Geometry',
	],

	'System.Drawing' :
	 {
		'GraphicsConsole : GraphicsLayer' : 
		 {
			Title   : str("???"),
			Enabled : boo(true),
			Lines   : arr(str),
			Columns : arr(num),
			

			//constructor : function(iAA)
			 //{
				//this.Title   = iAA.Title || null;
				//this.Enabled = true;
				//this.Lines   = [];
			 //},
			UpdateForeground : function()
			 {
				var _Ctx = this.Context;
				{
					_Ctx.ResetTransform();
					//_Ctx.Scale(0.8,0.8);
					_Ctx.TextAlign    = "left";
					_Ctx.TextBaseline = "top";
					
					//_Ctx.ResetTransform();
					//_Ctx.GlobalAlpha = 1;

					_Ctx.ClearRect(0, 0, _Ctx.W, _Ctx.H);
				//_Ctx.AddRect(0, 0, _Ctx.W, _Ctx.H, 10);
				//GraphicsLayer.Drawing.DrawBackground(this);
					_Ctx.FillStyle = this.ForeColor;

				}

				if(this.Title != undefined)
				{
					_Ctx.Font = "18px tahoma";
					_Ctx.FillText(this.Title, 10, 5);
					_Ctx.BeginPath(); _Ctx.MoveTo(10, 30); _Ctx.LineTo(_Ctx.W - 10, 30); _Ctx.Stroke();
					_Ctx.Translate(10, 35);
				}

				if(true)
				{
					//_Ctx.Font = ;

					var _CharW = _Ctx.MeasureText(" ").width;
					
					for(var cL,Li = 0; cL = this.Lines[Li], Li < this.Lines.Length; Li++)
					{
						if(Li * 12 > _Ctx.H) break;
						
						_Ctx.Translate(0,12);

						_Ctx.FillStyle = this.ForeColor;
						_Ctx.Font      = "12% courier";
						
						_Ctx.Save(); switch(typeof(cL))
						{
							case "object" :
							{
								if(cL instanceof Array)
								{
									//var _Offs = _Ctx.MeasureStringGraphicsConsole.Drawing.Symbol(_Ctx, "*");
									//if(typeof cL[0] == "string" && cL[0][0] != " ") GraphicsConsole.Drawing.Symbol(_Ctx, "*")
									
									//_Ctx.Translate(_CharW * 2, 0);
									
									//GraphicsConsole.Drawing.Symbol(_Ctx, "*")
									
									//cY += GraphicsConsole.Drawing.Symbol(_Ctx, "*", cX, cY).Y;

									for(var cF,Fi = 0; cF = cL[Fi], Fi < cL.Length; Fi++)
									{
										var cColW = this.Columns[Fi] * _CharW;
										//var cCelW = 0;
										//debugger;

										if      (typeof(cF) == "number")                  GraphicsConsole.Drawing.Number     (_Ctx, cF);
										else if (typeof(cF) == "boolean")                 GraphicsConsole.Drawing.Boolean    (_Ctx, cF);
										else if (cF instanceof Math.Geometry.Vector3)     GraphicsConsole.Drawing.Vector3    (_Ctx, cF);
										else if (cF instanceof Math.Geometry.Quaternion)  GraphicsConsole.Drawing.Quaternion (_Ctx, cF);
										else if (typeof(cF) == "object")                  GraphicsConsole.Drawing.Object     (_Ctx, cF);
										
										else                                              GraphicsConsole.Drawing.String     (_Ctx, cF);
										//switch(cF.constructor.name)
										//{
											//case "Vector3" : break;
											//case "String"  : _Ctx.FillText; break;

											//default : throw "WTF";
										//}
										
										//cX += 10;
										//cCelW = Max(cCelW, cColW);

										//cCelW = Max(cCelW, cColW);


										//_Ctx.Translate(cCelW + 10, 0);
										_Ctx.Translate(cColW + 10, 0);
									}
								}
								else throw "WTF";
								break;
							}
							case "number"  : GraphicsConsole.Drawing.Number  (_Ctx, cL); break;
							case "boolean" : GraphicsConsole.Drawing.Boolean (_Ctx, cL); break;
							case "string"  : GraphicsConsole.Drawing.String  (_Ctx, cL); break;

							
							

							default : throw "WTF";
						}
						_Ctx.Restore();
					}
						//if(cL
						//_Ctx.FillText(cL, 10, (Li * 12) + 5);
					

					//var _Line = []; for(var cC,Ci = 0; cC = arguments[Ci], Ci < arguments.length; Ci++)
					//{
						//switch(typeof(cC))
						//{
							//case "string" : _Line.Push({Type : "String", Value : cC}); break;
							//case "object" :
							//{
								//_Line.Push
									
							//}
						//}
					//}
				}
			 },
			UpdateBackground : function()
			 {
				GraphicsLayer.Drawing.DrawBackground(this);
			 },
			
			Clear       : function()
			 {
				var _IsInvalReq = this.Lines.Length != 0;

				this.Lines  .Length = 0;
				this.Columns.Length = [];
				
				_IsInvalReq && this.Invalidate();
			 },
			WriteHeader : function(iHeaderS)
			 {
				if(!this.Enabled) return;
				
				this.WriteLine(("= " + iHeaderS + " ====================================================================").Substring(0, this.Context.W / 7.5));
			 },
			WriteLine   : function(iLineS)
			 {
				if(!this.Enabled) return;

				if(iLineS == undefined) iLineS = "";

				if(iLineS instanceof Array)
				{
					for(var cF,Fi = 0; cF = iLineS[Fi], Fi < iLineS.Length; Fi++)
					{
						if(cF == undefined)
						{
							iLineS[Fi] = "UNDEF";
							continue;
						}

						var cFieW = cF.Length;
						var cColW = this.Columns[Fi];

						if(cColW == undefined || (typeof(cF) == "string" && cFieW > cColW))
						{
							this.Columns[Fi] = cFieW;
						}
						if(cF.Clone) iLineS[Fi] = cF.Clone(); //~~ Breaks instance links;
					}
				}
				this.Lines.Enqueue(iLineS);

				while(this.Lines.Length * 12 > this.Context.H - 50) this.Lines.Dequeue(1);
				this.Invalidate();
			 },
			//BeginTable : function()
			 //{
				
			 //},
			//AddRow     : function()
			 //{
				////this.Lines.Push();
				////var _Line = {Text, Fields};
				//var _Line = Array.prototype.clone.call(arguments);
				//this.WriteLine(_Line);
				
				
				
			 //}
			//WriteBorder : function(iLen)
			 //{
				//if(iLen == undefined) iLen = this.MaxLineLength;
				//this.Lines.Push(GraphicsConsole.Border.Substring(0, iLen));
			 //},
			
			
			static : 
			{
				Border : "--------------------------------------------------------------------------------------------------------------------------",
				Drawing : 
				{
					Objects : 
					{
					
						Bar : function(iCtx, iObj)
						 {
							var _VV = iObj.Values;
							{
								_VV[0] = _VV[0] == null ? null : _VV[0] / 2 + 0.5;
								_VV[1] = _VV[1] == null ? null : _VV[1] / 2 + 0.5;
								_VV[2] = _VV[2] == null ? null : _VV[2] / 2 + 0.5;
							}
							return this.Bar01(iCtx, iObj);
						 },
						Bar01 : function(iCtx, iObj)
						 {
							var iWidth = iObj.Width || 100;
							var iText  = iObj.Text || "";
							
							iCtx.Save();
							iCtx.Translate(+2,+2);
							iCtx.BeginPath(); iCtx.AddRect(0, 0, iWidth, 12);

							iCtx.FillStyle   = "#000000"; iCtx.Fill();
							iCtx.StrokeStyle = "#ffffff"; iCtx.Stroke();

							for(var _VV = iObj.Values, _CC = ["#ff0000","#00ee00","#00aaff"], cV,cC,Ci = 0; cV = _VV[Ci], cC = _CC[Ci], Ci < 3; Ci++)
							{
								if(cV == null) continue;

								if(cV < 0 || cV > 1)
								{
									cV = Clamp01(cV);

									iCtx.GlobalAlpha = ((Date.Now  - (333 * Ci)) % 1000) < 333 ? 0.5 : 1.0;
								}

								

								iCtx.FillStyle = cC;
								iCtx.FillRect(cV * (iWidth - 4), 0, 4, 12);

								iCtx.GlobalAlpha = 1;
							}
							iCtx.Restore();
							iCtx.FillText(typeof(iText) == "number" ? iText.ToString2() : iText,8,0);

							return;
						 },
						ProgressBar : function(iCtx, iObj)
						 {
						 //return;
							//iObj = {Value : 0.5, TgtValue : 1, Min : -1, Max : +1, Center : 0, ShowDelta : true};
							//iObj.Min       = 0;
							//iObj.Max       = +1;
							//var iMinV = iObj.Min != undefined ? iObj.Min : -1;
							//var iMaxV = iObj.Max != undefined ? iObj.Max : +1;

							if(iObj.Min    == undefined) iObj.Min = -1;
							if(iObj.Max    == undefined) iObj.Max = +1;
							//if(iObj.Center == undefined) iObj.Center =  = -1;

							if(iObj.Center == undefined) iObj.Center = (iObj.Min + iObj.Max) / 2;

							if(iObj.W      == undefined) iObj.W = 100;
							//iObj.ShowDelta = true;
							//var iW = 
							
							//{Value : 0.5, TgtValue : 1, Min : -1, Max : +1, Center : 0, ShowDelta : true};

							//iObj.Min
							//var iCntV  = (iObj.Max + iObj.Min) / 2;
							//var iRange = (iObj.Max - iObj.Min);
							
							var iCurV = Scale01(iObj.CurrValue, iObj.Min, iObj.Max);
							var iCmdV = Scale01(iObj.CommValue, iObj.Min, iObj.Max);

							//debugger;
							//var Clamp(iObj.Value, iObj.Min, iObj.Max);
							//Clamp(iObj.ÅïåValue, iObj.Min, iObj.Max);

							var iText = iObj.Text; if(iText == undefined) iText = (iObj.CommValue != undefined ? iObj.CommValue : iObj.CurrValue).ToString2();


							iCtx.Save();
							iCtx.GlobalAlpha = 1;
							
							iCtx.Translate(+2,+2);
							iCtx.BeginPath(); iCtx.AddRect(0, 0, iObj.W, 12);

							iCtx.FillStyle   = "#000000"; iCtx.Fill();
							iCtx.StrokeStyle = "#ffffff"; iCtx.Stroke();
							//iCtx.Translate(Clamp((iObj.Min + iObj.Max) / 2, 0,1),0);

							
							


							

							//iCtx.FillStyle = "#ffff00"; iCtx.FillRect((iCurV * iObj.W), 0, 5, iObj.H);
							iCtx.FillStyle = "#ff0000"; iCtx.FillRect((iCurV * (iObj.W - 4)), 0, 4, 12);
							iCtx.FillStyle = "#00ff00"; iCtx.FillRect((iCmdV * (iObj.W - 4)), 0, 4, 12);

							//if(!isNaN(iObj.Center)) iCtx.FillStyle   = "#cccccc"; iCtx.FillRect((iObj.Center * iObj.W) + 2, iY + 1, 3, iObj.H);
							//return;

							//iCtx.FillStyle   = iObj.FillColor || "#aaaaaa";

							////iCtx.FillRect(iX + 2, iY + 1, iObj.W * iCurV, iObj.H);
							//iCtx.FillRect(iX + 2, iY + 1, iObj.W * iCurV, iObj.H);
							

							////iObj.Min

							//if(iTgtV != undefined)
							//{
								//iCtx.FillStyle = "#ffff00";
								//iCtx.FillRect((iX + (iTgtV * iObj.W)) + 2, iY + 2, 4, iObj.H - 1);

							//}
							
							iCtx.Restore();
							//iCtx.FillStyle = "#ffffff";
							iCtx.FillText(iText,8,0);
							//iCtx.Save();
							//iCtx.Scale(1,0.8);
							
							//iCTx.Restore();
							
							iCtx.GlobalAlpha = 1;
						 },
					},

					Symbol     : function(iCtx, iStr)
					 {
						iStr += " ";

						iCtx.FillText(iStr,0,0);
						return iCtx.MeasureText(iStr).width;
					 },
					String     : function(iCtx, iStr)
					 {
						iCtx.FillText(iStr,0,0);
						return iCtx.MeasureText(iStr).width;
					 },
					Boolean    : function(iCtx, iBoo)
					 {
						iCtx.FillStyle = iBoo ? "#00cc00" : "#ff3300";
						iCtx.FillRect(-2, +1, 40, 13);
						iCtx.FillStyle = "#ffffff";
						iCtx.FillText(iBoo,0,0);
						return 40;
					 },
					Number     : function(iCtx, iNum)
					 {
						var iStr = iNum.ToString2();

						iCtx.FillText(iStr,0,0);
						return iCtx.MeasureText(iStr).width;
					 },
					Vector3    : function(iCtx, iVec)
					 {
						return this.Quaternion(iCtx, iVec);

						//var _H = parseInt(iCtx.FontSize);
						////var _VecLen = iVec.Length'
						////de
						////var _X1 = iVec.X;
						//var _Len = iVec.Length, _OpaX = Math.Abs(iVec.X / _Len), _OpaY = Math.Abs(iVec.Y / _Len), _OpaZ = Math.Abs(iVec.Z / _Len);
						
						//iCtx.Save(); iCtx.GlobalAlpha = _OpaX || 0; iCtx.FillStyle = "#ff0000";  iCtx.FillRect(iX +   0 - 2, iY + 2, 48, _H); iCtx.Restore(); iCtx.FillText(iVec.X.ToString2(), iX +   0, iY);
						//iCtx.Save(); iCtx.GlobalAlpha = _OpaY || 0; iCtx.FillStyle = "#00cc00";  iCtx.FillRect(iX +  50 - 2, iY + 2, 48, _H); iCtx.Restore(); iCtx.FillText(iVec.Y.ToString2(), iX +  50, iY);
						//iCtx.Save(); iCtx.GlobalAlpha = _OpaZ || 0; iCtx.FillStyle = "#00aaff";  iCtx.FillRect(iX + 100 - 2, iY + 2, 48, _H); iCtx.Restore(); iCtx.FillText(iVec.Z.ToString2(), iX + 100, iY);
						//iCtx.GlobalAlpha = 1;

						////iCtx.
						
						////iCtx.StrokeStyle = Colors.White;
						////iCtx.StrokeRect(iX, iY, 100, _H);
						//return 200;
					 },
					Quaternion : function(iCtx, iQua)
					 {
						var _X  = iQua.X,       _AX = Abs(_X),
						    _Y  = iQua.Y,       _AY = Abs(_Y),
						    _Z  = iQua.Z,       _AZ = Abs(_Z),
						    _W  = iQua.W || 0,  _AW = Abs(_W);
							 
						var _Max = Max(_AX,_AY,_AZ,_AW, 1);

						//var _RX = _AX >= 0.001 ? _AX / _Max : 0,
						    //_RY = _AY >= 0.001 ? _AY / _Max : 0,
							 //_RZ = _AZ >= 0.001 ? _AZ / _Max : 0,
							 //_RW = _AW >= 0.001 ? _AW / _Max : 0;

						var _RX = _AX / _Max,
						    _RY = _AY / _Max,
							 _RZ = _AZ / _Max,
							 _RW = _AW / _Max;

						//var _X  = iQua.X,      _Y  = iQua.Y,      _Z  = iQua.Z,      _W  = iQua.W || 0;
						//var _AX = Abs(_X),     _AY = Abs(_Y),     _AZ = Abs(_Z),     _AW = Abs(_W),      _Max = Max(_AX,_AY,_AZ,_AW);


						var _H  = parseInt(iCtx.FontSize);


					
						if(iQua.X != undefined) {iCtx.Save(); iCtx.GlobalAlpha = _RX || 0; iCtx.FillStyle = "#ff0000";  iCtx.FillRect(  0, 2, 48, _H); iCtx.Restore(); iCtx.FillText(_X.ToString2(),   0 + 2, 0);}
						if(iQua.Y != undefined) {iCtx.Save(); iCtx.GlobalAlpha = _RY || 0; iCtx.FillStyle = "#00cc00";  iCtx.FillRect( 50, 2, 48, _H); iCtx.Restore(); iCtx.FillText(_Y.ToString2(),  50 + 2, 0);}
						if(iQua.Z != undefined) {iCtx.Save(); iCtx.GlobalAlpha = _RZ || 0; iCtx.FillStyle = "#00aaff";  iCtx.FillRect(100, 2, 48, _H); iCtx.Restore(); iCtx.FillText(_Z.ToString2(), 100 + 2, 0);}
						if(iQua.W != undefined) {iCtx.Save(); iCtx.GlobalAlpha = _RW || 0; iCtx.FillStyle = "#aaaa00";  iCtx.FillRect(150, 2, 48, _H); iCtx.Restore(); iCtx.FillText(_W.ToString2(), 150 + 2, 0);}

						iCtx.GlobalAlpha = 1;

						//iCtx.
						
						//iCtx.StrokeStyle = Colors.White;
						//iCtx.StrokeRect(iX, iY, 100, _H);
						return 200;
					 },
					
					Object     : function(iCtx, iObj)
					 {
						//this.Objects[iObj.Type].ApplyiCtx, iObj);
						this.Objects[iObj.Type](iCtx, iObj);

						//switch(iObj.Type)
						//{
							//case "ProgressBar" :  this.Objects.ProgressBar(iCtx, iObj); break;
							
							//default : 
							//{
								//this.String(iCtx, iObj);
							//}
						//}
					 },
				}
			}
		 },
	}
 });
