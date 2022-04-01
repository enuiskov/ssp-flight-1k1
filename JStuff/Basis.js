"use strict";
(function()
{
	var $F,$P,$Mod = function(iF){$F = iF, $P = iF.prototype};

	$Mod(Object);
	 {
		Object.defineProperties
		 (
			$F,
			{
				Construct : {value : function(iCtorF, iArgA)
				 {
					var oInst = Object.create(iCtorF.prototype); iCtorF.apply(oInst, iArgA);
					return oInst;
				 }},
				GetNode : {value : function(iSrcO, iPath)
				 {
					for(var _LL = iPath.Split('/'), cO,pO = iSrcO, cL,Li = 0; cL = _LL[Li], cO = pO[cL], Li < _LL.Length; Li++, pO = cO)
					{
						if(cO == undefined)      throw "Node '" + iPath + "' not found in '" + this + "'";
						if(Li == _LL.Length - 1) return cO;
					}
				 }},
				SetNode : {value : function(iPath, iValue){throw "NI"}},
				Select  : {value : function(iPath){throw "NI"}},
			}
		 );
		Object.defineProperties
		 (
			$P,
			{
				ValueOf  : {value : $P.valueOf,  configurable : true, writable : true},
				ToString : {value : $P.toString, configurable : true, writable : true},
				//ToSource : {value : $P.toSource, configurable : true, writable : true},

				//IsOneOf :
				//{
					//value : function()
					//{
						//for(var cA,Ai = 0; cA = arguments[Ai], Ai < arguments.length; Ai++)
						//{
							//if(this == cA) return true;
						//}
						//return false;
					//}
				//},
			}
		 );
	 }
	$Mod(Array);
	 {
		$F.FromArguments = function(iArgsO)
		 {
			var oArray = [];
			{
				for(var Ai = 0; Ai < iArgsO.length; Ai++)
				{
					oArray[Ai] = iArgsO[Ai];
				}
			}
			return oArray;
		 };
		Object.defineProperties
		 (
			$P,
			{
				ToString  : {value : $P.toString},
				Length    : {get : function(){return this.length;}, set : function(iV){this.length = iV;}, enumerable : false},
				
				First     : {get : function(){return this[0]}},
				Last      : {get : function(){return this[this.length - 1]}},

				Push      : {value : $P.push},
				Pop       : {value : $P.pop},
				Sort      : {value : $P.sort},
				Filter    : {value : $P.filter},
				ForEach   : {value : $P.forEach},
				Map       : {value : $P.map},
				
				
				Clear     : {value : function(){this.length = 0}},
				Clone     : {value : $P.slice},
				Concat    : {value : $P.concat},
				Join      : {value : $P.join},
				Slice     : {value : $P.slice},
				
				
				
				Contains  : {value : function(iS){return this.indexOf(iS) != -1}},

				Add       : {value : $P.push},
				AddRange  : {value : function(iII){for(var cI,Ii = 0; cI = iII[Ii], Ii < iII.length; Ii++) this.Add(cI); return this}},
				Remove    : {value : function(iItem){return this.RemoveAt(this.indexOf(iItem))}},
				RemoveAt  : {value : function(iIndex)
				 {
					var _BefII = this.slice(0, iIndex);
					var _AftII = this.slice(iIndex + 1, this.length);
					
					this.length = 0;

					this.AddRange(_BefII);
					this.AddRange(_AftII);
				 }},
				InsertAt  : {value : function(iItem, iIndex)
				 {
					var _BefII = this.slice(0, iIndex);
					var _AftII = this.slice(iIndex, this.length);

					this.length = 0;

					this.AddRange(_BefII);
					this.Add(iItem);
					this.AddRange(_AftII);
				 }},
				Enqueue   : {value : $P.push},
				Dequeue   : {value : $P.shift},
			}
		 );
	 }
	$Mod(Boolean);
	 {
		Object.defineProperties
		(
			$P,
			{
				ToString : {value : $P.toString},
			}
		);
	 }

	$Mod(String);
	 {
		Object.defineProperties
		(
			$P,
			{
				ToString : {value : $P.toString},

				Length       : {get : function(){return this.length;}, enumerable : false},

				CharAt       : {value : $P.charAt},
				Substring    : {value : $P.substring},
				Trim         : {value : $P.trim},
				TrimStart    : {value : undefined},
				TrimEnd      : {value : undefined},
				IndexOf      : {value : $P.indexOf},
				LastIndexOf  : {value : $P.lastIndexOf},

				Replace      : {value : $P.replace},
				Split        : {value : $P.split},

				Contains     : {value : function(iS){return this.indexOf(iS) != -1;}},

				StartsWith   : {value : function(iS){return this.substring(0,iS.length) == iS;}},
				EndsWith     : {value : function(iS){return this.substring(this.length - iS.length, this.length) == iS;}},

				Match        : {value : $P.match},

				ToLower      : {value : $P.toLowerCase},
				ToUpper      : {value : $P.toUpperCase},
			}
		);
	 }
	$Mod(Number);
	 {
		Object.defineProperties
		(
			$P,
			{
				ToFixed   : {value : $P.toFixed},
				ToString  : {value : $P.toString},
				ToString2 : {value : function(iMaxDigits, iDoShowSign)
				 {
					if(iMaxDigits  == undefined) iMaxDigits = 3;
					if(iDoShowSign == undefined) iDoShowSign = true;

					var _ScaV = Math.pow(10, iMaxDigits);

					var _AbsV = Math.abs(Math.round(this * _ScaV) / _ScaV);   //~~   300.1415;
					var _AbsS = _AbsV.toFixed(iMaxDigits);                    //~~  "300.141";
					
					var _IntV = Math.floor(_AbsV);                            //~~   300;
					var _IntS = _IntV.toString();                             //~~  "300";
					var _FraS = _AbsS.substring(_IntS.length - 1);            //~~  "0.141";
					
					var _Sign = this >= 0 ? "+" : "-";                        //~~  "+" | "-";

					var oStr  = "";
					{
						if(iDoShowSign) oStr += _Sign;

						if(_AbsV < _ScaV * 100)
						{
							oStr += _IntS;
							
							if(iMaxDigits != 0 && _IntS.length < iMaxDigits + 1)
							{
								oStr +=  "." + _FraS.substr(2, Math.max(_FraS.length - _IntS.length - 1, 0));
							}
						}
						else
						{
							oStr += _AbsV.toExponential(Math.max(iMaxDigits - 2, 0));
						}
					}
					return oStr;
				 }},
			}
		);
	 }
	
	$Mod(Function);
	 {
		Object.defineProperties
		(
			$P,
			{
				Apply    : {value : $P.apply},
				Bind     : {value : $P.bind},
				Call     : {value : $P.call},
				
				ToString : {value : $P.toString},
			}
		);

	 }
	$Mod(Date);
	 {
		Object.defineProperties
		 (
			$F,
			{
				Create : {value : function(iYea,iMon,iDay, iHou,iMin,iSec, iMilS)
				 {
					if(iYea == undefined) iYea = 1957;
					if(iMon == undefined) iMon = 1;
					if(iDay == undefined) iDay = 1;

					if(iHou == undefined) iHou = 0;
					if(iMin == undefined) iMin = 0;
					if(iSec == undefined) iSec = 0;
					if(iMiS == undefined) iMiS = 0;


					return new Date(iYea,iMon-1,iDay, iHou,iMin,iSec, iMilS);
				 }},
				Now    : {get : function(){return new Date()}},
				Today  : {get : function(){var _D = new Date(); return new Date(_D.getYear(),_D.getMonths(),_D.getDate())}},
			}
		 );
		Object.defineProperties
		 (
			$P,
			{
				ValueOf         : {value : $P.valueOf},
				ToString        : {value : $P.toString},
				ToString2       : {value : function(iFormat)
				{
					if(!iFormat) iFormat = "yyyy-MM-dd HH:mm:ss";

					switch(iFormat)
					{
						//case "yyyy-MM-dd HH:mm:ss" : return this.Year + "-" + this.Month
						default : throw "Time string format not supported";
					}
				}},
				Year            : {get : function(){return this.getFullYear     ()},     set : function(iV){this.setFullYear     (iV)}},
				Month           : {get : function(){return this.getMonth        () + 1}, set : function(iV){this.setMonth        (iV - 1)}},
				Day             : {get : function(){return this.getDate         ()},     set : function(iV){this.setDate         (iV)}},
				Hour            : {get : function(){return this.getHours        ()},     set : function(iV){this.setHours        (iV)}},
				Minute          : {get : function(){return this.getMinutes      ()},     set : function(iV){this.setMinutes      (iV)}},
				Second          : {get : function(){return this.getSeconds      ()},     set : function(iV){this.setSeconds      (iV)}},
				Millisecond     : {get : function(){return this.getMilliseconds ()},     set : function(iV){this.setMilliseconds (iV)}},

				Ticks           : {get : function(){return this.valueOf()}},
				DayOfWeek       : {get : function(){throw "NI"}},
				DayOfYear       : {get : function(){throw "NI"}},
				TimeOfDate      : {get : function(){throw "NI"}},

				AddYears        : {value : function(iV){return new Date(new Date(this.valueOf()).setFullYear     (this.getFullYear     () + iV))}},
				AddMonths       : {value : function(iV){return new Date(new Date(this.valueOf()).setMonth        (this.getMonth        () + iV))}},
				AddWeeks        : {value : function(iV){return new Date(new Date(this.valueOf()).setDate         (this.getDate         () + iV * 7))}},
				AddDays         : {value : function(iV){return new Date(new Date(this.valueOf()).setDate         (this.getDate         () + iV))}},
				AddHours        : {value : function(iV){return new Date(new Date(this.valueOf()).setHours        (this.getHours        () + iV))}},
				AddMinutes      : {value : function(iV){return new Date(new Date(this.valueOf()).setMinutes      (this.getMinutes      () + iV))}},
				AddSeconds      : {value : function(iV){return new Date(new Date(this.valueOf()).setSeconds      (this.getSeconds      () + iV))}},
				AddMilliseconds : {value : function(iV){return new Date(new Date(this.valueOf()).setMilliseconds (this.getMilliseconds () + iV))}},
			}
		 );
	 }
	$Mod(Math);
	 {
		$F.D090   = $F.PI / 2;
		$F.D180   = $F.PI;
		$F.D270   = $F.PI * 1.5;
		$F.D360   = $F.PI * 2;
		$F.RTD    = 180 / $F.PI;
		$F.DTR    = 1 / $F.RTD;

		$F.Max    = $F.max;
		$F.Min    = $F.min;

		$F.Sqrt   = $F.sqrt;
		$F.Abs    = $F.abs;
		
		$F.Sin    = $F.sin;
		$F.Cos    = $F.cos;
		$F.Asin   = $F.asin;
		$F.Acos   = $F.acos;
		$F.Tan    = $F.tan;
		$F.Atan   = $F.atan;
		$F.Atan2  = $F.atan2;

		$F.Exp    = $F.exp;

		$F.Ceil   = $F.ceil;
		$F.Floor  = $F.floor;

		$F.Imul   = $F.imul;
		$F.Log    = function(iV, iBase){return iBase == undefined ? Math.log(iV) : Math.log(iV) / Math.log(iBase)};
		$F.Log10  = function(iV){return Math.log(iV) / Math.log(10)};
		$F.LogN   = function(iV){return Math.log(iV)};
		$F.Pow    = $F.pow;
		
		$F.Magic  = function(iV, iPower){return Math.pow(Math.abs(iV), 1 / iPower) * (iV > 0 ? +1 : -1)},
		

		$F.Round  = $F.round;
		$F.Random = $F.random;


		$F.Round  = function(iValue, iDigits)
		 {
			if(iDigits)
			{
				return Math.round(iValue * Math.pow(10, iDigits)) / Math.pow(10, iDigits);
			}
			else return Math.round(iValue);
		 };
		$F.Sign   = function(iNum)
		 {
			return isNaN(iNum) ? NaN : (iNum == 0 ? 0 : (iNum > 0 ? +1 : -1));
		 };
		
		$F.Avg       = function(iVV)
		 {
			if(arguments.length > 1) iVV = arguments;
			
			var _VVs = NaN;
			var _VVc = 0;
			
			for(var cV,Vi = 0; cV = iVV[Vi], Vi < iVV.length; Vi++)
			{
				if(!isNaN(cV))
				{
					if(isNaN(_VVs)) _VVs = 0;
					
					_VVs += cV;
					_VVc ++;
				}
			}
			return _VVs / _VVc;
		 };
		$F.Mix      = function(ixV,iyV, iA){return (ixV * (1 - iA)) + (iyV * iA)};

		$F.Clamp    = function(iNum, iMin_Max, iMax)
		 {
			if(isNaN(iNum)) return NaN;

			var iMin;
			{
				if(iMax == undefined)
				{
					if     (iMin_Max == undefined) iMin_Max = 1;

					iMin = -iMin_Max;
					iMax = +iMin_Max;
				}
				else iMin = iMin_Max;
			}
			if(iMin > iMax) throw new Error("ARGS: invalid range bounds");
			
			return Math.Min(Math.Max(iNum, iMin), iMax);
		 };
		$F.Clamp01  = function(iNum){return Math.Clamp(iNum, 0,1)};
		
		$F.Scale    = function(iNum, iMin_Max, iMax){return Math.Scale01(iNum, iMin_Max, iMax) * 2 - 1};
		$F.Scale01  = function(iNum, iMin_Max, iMax)
		 {
			if(isNaN(iNum)) return NaN;

			var iMin;
			{
				if(iMax == undefined)
				{
					if     (iMin_Max == undefined) iMin_Max = 1;
					//else if(iMin_Max < 0)          throw "ARGS: positive value expected";

					iMin = -iMin_Max;
					iMax = +iMin_Max;
				}
				else iMin = iMin_Max;
			}
			return (iNum - iMin) / (iMax - iMin);
		 };
		$F.DegToRad  = function(iDegs){return iDegs * Math.DTR};
		$F.RadToDeg  = function(iRads){return iRads * Math.RTD};
		$F.Angle     = function(iFrA, iToA){var _ClwsA = (iToA % Math.D360) - (iFrA % Math.D360), _AbsA = Math.Abs(_ClwsA); return _AbsA > Math.D180 ? (_AbsA - Math.D360) * Math.Sign(_ClwsA) : _ClwsA};
	 }
	$Mod(RegExp);
	 {
		$F.Escape = function(iStr)
		{
			throw "NI";
		};

		$P.Test  = $P.test;
		$P.Match = $P.match;
	 }
	$Mod(CanvasRenderingContext2D);
	 {
		Object.defineProperties
		(
			$P,
			{
				Clear         : {value : function(){this.ClearRect(0,0,this.W,this.H)}},
				ClearRect     : {value : $P.clearRect},
				Clip          : {value : $P.clip},
				AddRect       : {value : function(iX, iY, iW, iH, iR)
				 {
					if(iR != undefined)
					{
						if (iW < 2 * iR) iR = iW / 2;
						if (iH < 2 * iR) iR = iH / 2;
						
						this.moveTo		(iX + iR,   iY);
						this.arcTo		(iX + iW,   iY,        iX + iW,   iY + iH,   iR);
						this.arcTo		(iX + iW,   iY + iH,   iX,        iY + iH,   iR);
						this.arcTo		(iX,        iY + iH,   iX,        iY,        iR);
						this.arcTo		(iX,        iY,        iX + iW,   iY,        iR);
						this.closePath	();
					}
					else
					{
						this.rect(iX,iY,iW,iH);
					}
				 }},
				AddCircle     : {value : function(iX, iY, iR)
				 {
					this.moveTo (iX + iR, iY);
					this.arc    (iX,iY,iR, 0, Math.PI * 2);
				 }},
				//AddCircle     : {value : function(iX, iY, iR)
				 //{
					
					//this.moveTo (iX, (iY - iR));

					//this.arcTo(iX + iR, iY - iR,  iX + iR, iY + iR,  iR);
					//this.arcTo(iX + iR, iY + iR,  iX - iR, iY + iR,  iR);
					//this.arcTo(iX - iR, iY + iR,  iX - iR, iY - iR,  iR);
					//this.arcTo(iX - iR, iY - iR,  iX + iR, iY - iR,  iR);

					//this.closePath	();
				 //}},
				AddArc        : {value : $P.arc},
				//AddPie        : {value : function(iX, iY, iR, iFrac, iRot)
				 //{
					//if(iRot == undefined) iRot = 0;

					//throw "NI";
					////this.moveTo (iX, (iY - iR));

					////this.arcTo(iX + iR, iY - iR,  iX + iR, iY + iR,  iR);
					////this.arcTo(iX + iR, iY + iR,  iX - iR, iY + iR,  iR);
					////this.arcTo(iX - iR, iY + iR,  iX - iR, iY - iR,  iR);
					////this.arcTo(iX - iR, iY - iR,  iX + iR, iY - iR,  iR);

					////this.closePath	();
				 //}},
				Stroke        : {value : $P.stroke},
				Fill          : {value : $P.fill},

				BeginFrame    : {value : function(){if(this.W != undefined && this.H != undefined) this.ClearRect(0,0,this.W,this.H); }},
				BeginPath     : {value : $P.beginPath},
				ClosePath     : {value : $P.closePath},
				
				StrokeRect    : {value : $P.strokeRect},
				FillRect      : {value : $P.fillRect},

				MoveTo        : {value : $P.moveTo},
				LineTo        : {value : $P.lineTo},
				ArcTo         : {value : $P.arcTo},
				
				Font          : {get : function(){return this.font;}, set : function(iV){this.font         = iV;}},
				FontSize      : {get : function(){return this.font.match(/^\d+\S+/).toString();}, set : function(iV){this.font = this.font.replace(/[\d\.]+[\w%]*/, iV);}},
				FontWeight    : {set : function(iV){this.font = this.font.replace(/^(normal|bold|italic)\s*|^/, iV + " ");}},

				TextAlign     : {get:function(){return this.textAlign;},    set:function(iV){this.textAlign    = iV;}},
				TextBaseline  : {get:function(){return this.textBaseline;}, set:function(iV){this.textBaseline = iV;}},

				StrokeText    : {value : $P.strokeText},
				FillText      : {value : $P.fillText},
				MeasureText   : {value : $P.measureText},
				
				LineWidth     : {get:function(){return this.lineWidth;},   set:function(iV){this.lineWidth = iV;}},
				
				StrokeStyle   : {get:function(){return this.strokeStyle;}, set:function(iV){ this.strokeStyle = typeof(iV) == "string" || iV instanceof CanvasGradient ? iV : iV.AsString;}},
				FillStyle     : {get:function(){return this.fillStyle;},   set:function(iV){ this.fillStyle   = typeof(iV) == "string" || iV instanceof CanvasGradient ? iV : iV.AsString;}},
				
				GlobalAlpha   : {get:function(){return this.globalAlpha;}, set:function(iV){ this.globalAlpha = iV;}},
				GlobalCompositeOperation  : {get:function(){return this.globalCompositeOperation;}, set:function(iV){this.globalCompositeOperation = iV;}},


				Save          : {value : $P.save},
				Restore       : {value : $P.restore},

				UpdateSize    : {value : function(){this.W = this.canvas.width; this.H = this.canvas.height; this.canvas.style.fontSize="100px"; }},

				//ZoomIn        : {value : function(iWScalar, iHScalar){if( this.IsZoomed) throw "WTF: Already zoomed in?"; this.IsZoomed = true;  this.Save(); this.Scale(this.W * iWScalar||1, this.H * iHScalar||1);}},
				ZoomIn        : {value : function(iWidF, iHeiF)
				 {
					if(this.IsZoomed) throw "WTF: Already zoomed in?";

					if     (!iWidF && !iHeiF) iWidF = 1, iHeiF = 1;
					else if(!iWidF &&  iHeiF) iWidF = iHeiF * (this.W / this.H);
					else if( iWidF && !iHeiF) iHeiF = iWidF * (this.H / this.W);

					this.Save();

					this.ZoomIn.UnzoomData = {W : this.W, H : this.H};
					this.Scale(this.W / iWidF, this.H / iHeiF);

					this.W = iWidF; this.H = iHeiF;
				 }},
				ZoomOut       : {value : function(){var _UnZ = this.ZoomIn.UnzoomData; if(!_UnZ) throw "WTF: context is not zoomed in"; this.Restore(); this.W = _UnZ.W; this.H = _UnZ.H; this.ZoomIn.UnzoomData = undefined;}},
				
				Translate            : {value : $P.translate},
				Rotate               : {value : $P.rotate},
				Scale                : {value : $P.scale},

				Transform            : {value : $P.transform},
				SetTransform         : {value : $P.setTransform},
				ResetTransform       : {value : function(){this.SetTransform(1,0,0,1,0,0);}},
				
				CreateLinearGradient : {value : $P.createLinearGradient},

				DrawFramerate        : {value : function()
				 {
					var _CurrRate = 1000 / Math.max(new Date() - this.LastDrawTime, 1);
					
					var _AvgRateToShow;
					{
						if(isNaN(this.AverageRate)) this.AverageRate = _CurrRate;
						//this.AverageRate = _CurrRate < 10 ? _CurrRate : this.AverageRate + (_CurrRate - this.AverageRate) / _CurrRate * 10;
						if(_CurrRate >= 10)         this.AverageRate = this.AverageRate + (_CurrRate - this.AverageRate) / _CurrRate * 10;
						if(this.AverageRate < 0)    this.AverageRate = 0;

						_AvgRateToShow = this.AverageRate;
					}
					this.LastDrawTime = new Date();
					
					var _BackColor, _ForeColor;
					{
						if(_AvgRateToShow >= 1000)
						{
							_AvgRateToShow = " ERR";
							_BackColor     = "#000000";
							_ForeColor     = "#ffffff";
						}
						else
						{
							var _V = Math.floor(Math.min(_AvgRateToShow / 10 * 255, 255));
							_BackColor = "rgb(255," + _V + "," + _V + ")";
							_ForeColor = _V < 64 ? "#ffffff" : "#000000";
						}
					}
					var _Ctx = this;
					{
						_Ctx.ResetTransform();
						_Ctx.Font = "18px tahoma";
						_Ctx.TextAlign = "left";
						
						_Ctx.LineWidth = 1;
						_Ctx.FillStyle = _BackColor;
						_Ctx.StrokeStyle = "#000000";
						
						_Ctx.BeginPath();
						_Ctx.AddRect(10, this.canvas.height - 36, 58, 25, 5);

						
						_Ctx.Fill();
						
						
						_Ctx.Stroke();
						
						_Ctx.FillStyle = _ForeColor;
						_Ctx.FillText(typeof(_AvgRateToShow) == "string" ? _AvgRateToShow : _AvgRateToShow.ToString2(3,false), 16, _Ctx.canvas.height - 17);
					}
				 }},
			}
		);
	 };
	$Mod(CanvasGradient);
	 {
		Object.defineProperties
		(
			$P,
			{
				AddColorStop         : {value : $P.addColorStop},
			}
		);
	 }
})();

var $dom = function(iElemId){return document.getElementById(iElemId)};
// );
