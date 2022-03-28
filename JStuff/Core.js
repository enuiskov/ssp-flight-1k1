"use strict";

window.onerror = function(iMsg,iUrl,iLineN)
 {
	if(!stuff.IsRuntimeState)
	{
		stuff.IsFailedState = true;
		stuff.AddMessage(stuff.MessageType.FatalError, "JSERRORS", iMsg, undefined, iUrl, iLineN, false);
	}
 };
window.onload  = function()
 {
	if(!stuff.IsInitComplete && stuff.Requests.length == 0) stuff.init();
 };
Object.defineProperties
 (
	window,
	{
		jso  : {value : function _jso  (iJsO)     {return function _jso(){return iJsO;}}},
		any  : {value : function _any  ()         {return function _any(){}}},
		enm  : {value : function _enm  ()         {return function _enm(){}}},
		fnc  : {value : function _fnc  ()         {return function _fnc(){}}},
		arr  : {value : function _arr  (iType)    {return function _arr(){}}},
		num  : {value : function _num  (iV)       {return function _num(){return iV}}},
		str  : {value : function _str  (iV)       {return function _str(){return iV}}},
		boo  : {value : function _boo  (iV)       {return function _boo(){return iV}}},
		rgx  : {value : function _rgx  (iV)       {return function _rgx(){return iV}}},
		obj  : {value : function _obj  (iObj)     {var _CtorAA = arguments; return function _obj(i1,i2){return {ObjOrAlias : iObj, Args : _CtorAA}}}},
		nil  : {value : function _nil  (iPath)    {return function _nil(i1,i2){return {Path : iPath}}}},
		
		self : {value : 1.016104909293719e-21},
	}
 );
//window.$ = window.stuff = function(){};
{
	$.IsTransformedState         = false;     //~~ ;
	$.IsInitComplete             = false;     //~~ To avoid second $.init() call in window.onload handler;
	$.IsFailedState              = false;     //~~ ;
	$.IsRuntimeState             = false;     //~~ ;
	$.CurrentFile                = undefined; //~~ ;
	$.CurrentPack                = undefined; //~~ ;
	$.CurrentItem                = undefined; //~~ ;
	$.LastClassIndex             = -1;        //~~ Base class reference index used in 'this.overriden' substitutions;
	$.OnLoad                     = undefined; //~~ Can be called when no entry point was defined;

	$.Config                     = new function Config()
	 {
		this.InlayRgx     = new RegExp("^_[_a-z]+$");
		this.ValTypeRgx   = new RegExp("^number|string|boolean$");
		this.SelfRgx      = new RegExp("(\\D)" + self + "(\\D)", "g");
		
		this.IdentRgx     = new RegExp(/[~\w][\w\d]*/);
		this.PathRgx      = new RegExp("(?:" + this.IdentRgx.source + "\\s*\\.\\s*)*(" + this.IdentRgx.source + ")");
		this.NameOnlyRgx  = new RegExp("" + this.IdentRgx.source + "$");
		
		this.ParentRgx    = new RegExp("^(?:(.+?)\\.)?" + this.IdentRgx.source + "$");
		this.DeclaRgx     = new RegExp("^\\s*(" + this.PathRgx.source + ")\\s*(?:\\:\\s*(" + this.PathRgx.source + "))?\\s*$");

		this.AssignRgx    = new RegExp("(o" + this.IdentRgx.source + ")\\s*<<\\s*(" + this.PathRgx.source + ")\\s*\\|\\|\\s*([^;]*);", "g"); 
		
		this.ThisArgRgx1  = new RegExp("this\\s*<<\\s*i(" + this.IdentRgx.source + ")\\s*\\|\\|\\s*([^;]+)\\s*;", "g");
		this.ThisArgRgx2  = new RegExp("this\\s*<<\\s*i(" + this.IdentRgx.source + ")\\s*;", "g");
		this.ThisArgRgx3  = new RegExp("this\\s*<<\\s*(" + this.PathRgx.source + ")\\s*\\|\\|\\s*([^;]+)\\s*;", "g");
		this.ThisArgRgx4  = new RegExp("this\\s*<<\\s*(" + this.PathRgx.source + ")\\s*;", "g");
		
		//~~ Is used in "this << iAA.FieldName || error";
		this.ErrorArgRgx1 = new RegExp("\\((" + this.PathRgx.source + ") !== undefined \\? \\2 :\\) error\\s*\\((\".*?\")\\)\\s*;", "g");
		this.ErrorArgRgx2 = new RegExp("\\((" + this.PathRgx.source + ") !== undefined \\? \\2 :\\) error\\s*;", "g");
	 };
	$.ObjectType                 =
	 {
		Undefined    : "Undefined"   , //~~ MemberName  : undefined;

		Object       : "Object"      , //~~ ;
		Value        : "Value"       , //~~ MemberName  : 5;
		
		Array        : "Array"       , //~~ MemberName  : [1,2,3];

		Namespace    : "Namespace"   , //~~ NsName      : {...};
		Class        : "Class"       , //~~ 'ClassName : ParentName' : {};
		Instance     : "Instance"    , //~~ instance    : {};
		Static       : "Static"      , //~~ static      : {};
		Field        : "Field"       , //~~ FieldName   : num | num(1);
		Function     : "Function"    , //~~ FuncName    : function(){};
		Method       : "Method"      , //~~ MethodName  : function(){};
		
		Constructor  : "Constructor" , //~~ constructor : function(){};
		Initializer  : "Initializer" , //~~ initializer : function(){};

		Property     : "Property"    , //~~ Property    : {get : function(oV){}, set : function(iV){}};
		Oncer        : "Oncer"       , //~~ Oncer       : {get once(){return DoSomethingJustOnce()}};
		JsObject     : "JsObject"    , //~~ JsObject    : jso ({...});
	 };
	$.MessageType                =
	 {
		Notification : "Notification",
		Tip          : "Tip"         ,
		Warning      : "Warning"     ,
		Error        : "Error"       ,
		FatalError   : "FatalError"  ,
	 };
	
	$.SourceList                 = {}; //~~ 'embedded' SourceList that do not require additional requests;
	$.Requests                   = []; 
	$.Files                      = {}; 
	$.Nodes                      = {}; 
	$.EntryPoints                = []; 
	
	
	$.File                       = function(iUrl, iSource, iCompiled)
	 {
		this.Url      = iUrl;
		this.Name     = iUrl.match(/([^\/]*)$/)[1];
		this.Source   = iSource;
		this.Compiled = iCompiled;
		this.Packs    = [];
	 };
	$.Pack                       = function(iUrl, iTreeO, iCloseF)
	 {
		$.CurrentPack = this;
		
		this.File      = $.Files[iUrl];
		this.Uses      = iTreeO["uses"]; delete iTreeO["uses"];
		this.Init      = iTreeO["init"]; delete iTreeO["init"];
		this.Main      = iTreeO["main"]; delete iTreeO["main"];

		this.Structure = iTreeO;
		this.Items     = $.Routines.FlattenItems(iTreeO, "", this);
		this.Close     = function(){iCloseF.call(null, this.Closures)}.bind(this);
	 };
	$.Node                       = function(iId, iII)
	 {
		this.ID       = iId;
		this.Name     = $.Routines.GetNameFromID(iId);		
		this.Type     = $.ObjectType.Namespace;
		this.Items    = iII || [];

		this.Parent   = iId.match($.Config.ParentRgx)[1] || undefined; //~~ Initially string, and then Node;
		this.Children = [];
		
		Object.defineProperty(this,"Value", {get : function(){if(this.Items.length != 1) console.error("Attempting to access " + this.Items.length + " items with single item value request"); return this.Items[0].Value;}});
	 };
	$.NodeItem                   = function(iId, iValue, iPack, iIsInstMem)
	 {
		this.ID           = iId;
		this.Name         = $.Routines.GetNameFromID(iId)
		this.Value        = iValue;
		this.Pack         = iPack;
		this.IsInstMember = iIsInstMem;
		this.Node         = undefined;
	 };

	$.Routines = {};
	$.Routines.GetNameFromID     = function(iId, oName)
	 {
		return iId.match($.Config.PathRgx)[1];
	 };
	$.Routines.LinkNodes         = function(iParentN, iChildN)
	 {
		iParentN.Children.push(iChildN);
		iChildN.Parent = iParentN;

		if(iParentN.Type == $.ObjectType.Class && iChildN.Type == $.ObjectType.Constructor)
		{
			iParentN.Constructor = iChildN;
		}
	 };
	$.Routines.FlattenItems      = function(iBranchO, iCurrP, iPack, iIsInstMem, oII)
	 {
		var _IsInstMem = iIsInstMem;
		{
			var _IsInstPathM    = /\.instance$/.test(iCurrP);
			var _IsStatPathM    = /\.static$/.test(iCurrP);
			var _IsInstRoot     = iBranchO.hasOwnProperty("constructor") || iBranchO.hasOwnProperty("static");
			var _IsStatRoot     = iBranchO.hasOwnProperty("initializer") || iBranchO.hasOwnProperty("instance");
			var _IsClassRoot    = _IsInstRoot || _IsStatRoot;
			var _IsDerivedClass = iBranchO.hasOwnProperty("inherits");

			var _HasFields      = false;
			{
				for(var cItemN in Object.getProperties(iBranchO))
				{
					var cItemDesc = Object.getOwnPropertyDescriptor(iBranchO, cItemN);
					var cItemV    = cItemDesc.value;

					if(typeof(cItemV) == "function" && $.Config.InlayRgx.test(cItemV.name) && cItemV.name != "_jso")
					{
						_HasFields = true;
						break;
					}
				}
			}
			if(_IsInstRoot && _IsStatRoot)
			{
				throw "WTF";
				//console.info("ND: _IsInstRoot && _IsStatRoot");
			}
			if(!_IsStatRoot && (_IsInstPathM || _IsInstRoot || _IsDerivedClass || _HasFields)) _IsInstMem = true;
		}

		oII = [];
		{
			for(var cItemN in Object.getProperties(iBranchO))
			{
				var cIsInstMem = _IsInstMem;

				if(cItemN.match(/^(uses|inherits)$/))             continue;
				if(cItemN.match(/^(init|main)$/) && iCurrP == "") continue; //~~ Root 'init' (and 'main'?) can be duplicated;
				if(cItemN == "once")                              continue;

				var cDeclaM = cItemN.replace(/[\/\\]/g,".").match($.Config.DeclaRgx);
				{
					if(!cDeclaM)
					{
						/*
							decl       :: ident [dot ident] [':' ident [dot ident]]
							dot        :: '.' | '/'
							ident      :: ('_' | letter) ('_' | letter | digit)*
							digit      :: '0'...'9'
							letter     :: 'A'...'Z' | 'a'...'z'
						*/

						!$.IsTransformedState && $.AddMessage($.MessageType.FatalError, "DODOCODE", "Invalid member declaration string: \"'" + cItemN + "'\"", undefined, iPack.File.Url);
						
						continue;
					}
				}
				
				var cItemSubP  = cDeclaM[1].replace(/\s*/g,"");
				var cItemId    = (iCurrP != "" ? iCurrP + "." : "") + cItemSubP;
				{
					var cInstaM = cItemId.match(/(.+?\.instance\.)(.+?)$/);
					var cStatiM = cItemId.match(/(.+?)\.static\.(.+?)$/);
					
					if(cInstaM){cIsInstMem = true;  cItemId = cItemId.replace(/\.instance\./g,".");}
					if(cStatiM){cIsInstMem = false; cItemId = cItemId.replace(/\.static\./g,".");}
				}
				
				var cItemV, cPropD = Object.getOwnPropertyDescriptor(iBranchO, cItemN);
				{
					if(cPropD.value != undefined)
					{
						cItemV = iBranchO[cItemN];

						
						if(typeof(cItemV) == "object" && cItemV != null)
						{
							Checks:
							{
								if(cDeclaM[3] != undefined) //~~ Class declaration;
								{
									if(cItemV.inherits == undefined)
									{
										cItemV.inherits = cDeclaM[3];
									}
									else $.IsTransformedState && $.AddMessage($.MessageType.Error, "CLSINHER", "Multiple inheritance values", cItemId, iPack.File.Url, []);
								}
							}
							
							if(typeof(cItemV.get) == "function" || typeof(cItemV.set) == "function")
							{
								//~~ Property that defined in preffered way;
							}
							else if(typeof(cItemV["init"]) == "function")
							{
								//~~ Single member initializer;
							}
							else
							{
								$.CurrentItem = cItemN;
								var cItemSubII = $.Routines.FlattenItems(cItemV, cItemId, iPack, cIsInstMem);
								oII = oII.concat(cItemSubII);
							}
						}
						else if(typeof(cItemV) == "function")
						{
							if(cItemV.name == "_jso")
							{
								//~~cItemV = cItemV();
							}
						}
					}
					else
					{
						//debugger;
						//cItemV = cPropD;

						cItemV = undefined;
					}
				}
				if(!cItemN.match(/^(instance|static)$/))
				{
					oII.push(new $.NodeItem(cItemId, cItemV, iPack, cIsInstMem));
				}
			}
		}
		return oII;
	 },
	$.Routines.Eval              = function(iSrcS, iUrl, oIsOk)
	 {
		$.Files[iUrl].Packs = [];
		
		var _StuffF;
		{
			if(!$.IsTransformedState)
			{
				_StuffF        = function(iPackO){$.AddPack(iUrl, iPackO, undefined)};
				_StuffF.import = $.import;
				
				try
				{
					$.CurrentFile = $.Files[iUrl];
					Function("stuff", iSrcS).call(null, _StuffF);
				}
				catch(_Exc)
				{
					if(1) $.AddMessage($.MessageType.FatalError, "JSERRORS", _Exc.message, $.CurrentItem, iUrl);
					return false;
				}
			}
			else
			{
				_StuffF        = Function("iTuple", "$.AddPack(iTuple[0], iTuple[1], iTuple[2]);");
				_StuffF.import = Function("/*-- empty --*/");
				
				Function("stuff", iSrcS).call(null, _StuffF);
			}
		}
		return true;
	 },
	$.Routines.GetUsedNodes      = function(iUsesS, oCloDict)
	 {
		/**
			uses
			[
				"System.Math",                            //Include all members
				"System.Math: Sin, Cos",                  //Include only specified
				"System.Math: *, -Sin",                   //Include all but specified
				
				"System.Drawing",
				"System.Drawing: Point, Size",            //Point, Size only
				"System.Drawing (*2D)",                   //Point2D, Size2D
				
				"System.Windows.Forms (WinForms)",        //WinForms.Frame, WinForms.Form
				"System.Windows.Forms (WF*)",             //WFFrame, WFForm, WFButton
			]
		*/
		iUsesS = iUsesS.trim();
		
		var _NsId, _ExtraAA, _PickedNN, _AllButNN, _AliasN, _PrefixS = "", _SuffixS = "";
		{
			var _UsingM = iUsesS.match(/^([\w\d\.\s]+)(.*)$/);
			{
				_NsId    = _UsingM[1].trim();
				_ExtraAA = _UsingM[2].trim();
				
				if(_ExtraAA.length != 0)
				{
					var _PickedMM = _ExtraAA.match(/^:\s*(?!\s*\*)([^\(]+)/);  //~~ ": Sin, Cos";
					var _AllButMM = _ExtraAA.match(/^:\s*\*\s*,\s*([^\(]+)/);  //~~ ": *, -Sin, -Cos";
					var _AliasM   = _ExtraAA.match(/\(\s*(\w+)\s*\)$/);        //~~ "(ALIAS)";
					var _PrefixM  = _ExtraAA.match(/\(\s*(\w+)\*\s*\)$/);      //~~ "(PFX*)";
					var _SuffixM  = _ExtraAA.match(/\(\s*\*(\w+)\s*\)$/);      //~~ "(*SFX)";
					
					if(_PickedMM != null) _PickedNN = _PickedMM [1].split(",").map(function(iS){return iS.trim();});
					if(_AllButMM != null) _AllButNN = _AllButMM [1].split(",").map(function(iS){return iS.trim().replace(/^-/,"");});
					if(_AliasM   != null) _AliasN   = _AliasM   [1];
					if(_PrefixM  != null) _PrefixS  = _PrefixM  [1];
					if(_SuffixM  != null) _SuffixS  = _SuffixM  [1];
				}
			}
		}

		oCloDict = new function ClosureDictionary(){};
		{
			if(_AliasN != undefined)
			{
				var cCloNodeI = {};
				{
					cCloNodeI.ID     = _NsId;
					cCloNodeI.Alias  = _AliasN;
				}
				oCloDict[cCloNodeI.Alias] = cCloNodeI;
			}
			else
			{
				var _NsRgx    = new RegExp("^" + _NsId.replace(/\./g,"\\.") + "\\.([A-Z][\\w\\d]*)$");
				
				if(window[_NsId])
				{
					//~~ Using internal 'window' and already imported third-party objects;
					for(var cPropN in Object.getProperties(window[_NsId]))
					{
						if(_PickedNN && _PickedNN.indexOf(cPropN) == -1) continue;
						if(_AllButNN && _AllButNN.indexOf(cPropN) != -1) continue;
						
						var cCloI =  {ID : _NsId + "." + cPropN, Alias : _PrefixS + cPropN + _SuffixS, IsGenerated : false};
						oCloDict[cCloI.Alias] = cCloI;
					}
				}
				
				//~~ Additional objects as nodes;
				for(var cNodeId in Object.getProperties($.Nodes))
				{
					var cNodeNsM    = cNodeId.match(_NsRgx); if(!cNodeNsM)  continue;
					var cNodeAliasN = cNodeNsM[1];
					
					if(_PickedNN && _PickedNN.indexOf(cNodeAliasN) == -1) continue;
					if(_AllButNN && _AllButNN.indexOf(cNodeAliasN) != -1) continue;
					if($.Nodes[cNodeId].Type == $.ObjectType.Field)       continue;
					

					if(oCloDict[cNodeId])throw "WTF";
					
					var cCloNodeI = {ID : cNodeId, Alias : _PrefixS + cNodeAliasN + _SuffixS, IsGenerated : true};
					oCloDict[cCloNodeI.Alias] = cCloNodeI;
				}
			}
		}
		return oCloDict;
	 },
	$.Routines.GetNodeIdByAlias  = function(iAlias, iPack, oFoundId)
	 {
		var _UsedNsSS = Object.getOwnPropertyNames(iPack.Structure).concat(iPack.Uses || []);

		for(var cUsedS,Si = 0; cUsedS = _UsedNsSS[Si], Si < _UsedNsSS.length; Si++)
		{
			var cUsedAA = $.Routines.GetUsedNodes(cUsedS);
			
			for(var cAlias in cUsedAA)
			{
				if(cAlias == iAlias)
				{
					if(oFoundId == undefined) oFoundId = cUsedAA[cAlias].ID;
					else $.AddMessage($.MessageType.FatalError, "CLOSURES", "Alias collision detected", iAlias, iPack.File.Url);
				}
			}
		}
		return oFoundId;
	 };
	$.Routines.GetPrototypeInfo  = function(iNode, oProtoI)
	 {
		oProtoI = {Value : {}, IsModified : false, IsPrimary : false};
		{
			if(window[iNode.ID] != undefined)
			{
				oProtoI.Value      = Object.getDescriptors(window[iNode.ID].prototype, true);
				oProtoI.IsModified = true;
				oProtoI.IsPrimary  = true;
			}
			else
			{
				if(iNode.BaseClass)
				{
					var _BaseProtoI = $.Routines.GetPrototypeInfo(iNode.BaseClass);

					if(_BaseProtoI.IsModified)
					{
						oProtoI.Value = _BaseProtoI.Value;
						oProtoI.IsModified = true;
					}
				}
				
				for(var cI,Ii = 0; cI = iNode.Items[Ii]; Ii++)
				{
					var cInstO = Object.getDescriptors(cI.Value["instance"] || cI.Value);
					{
						for(var cDecla in cInstO)
						{
							if(cDecla == "inherits") continue;
							
							var cMemN = cDecla.match($.Config.DeclaRgx)[1];
							var cMemD = $.Nodes[iNode.ID + ".~" + cMemN];
							{
								if(!cMemD)                                  continue;
								if( cMemD.Type == $.ObjectType.Field)       continue;
								if( cMemD.Type == $.ObjectType.Constructor) continue;
								if( cMemD.Items.length == 0)                throw "WTF";
								if(!cMemD.IsInstMember)                     continue;
							}
							
							if(!cMemN.match(/^inherits|static$/))
							{
								var cDesc = cInstO[cMemN];
								{
									oProtoI.Value[cMemN] = cDesc.get || cDesc.set ? cDesc : (cDesc.value && (cDesc.value.get || cDesc.value.set)) ? cDesc.value : cDesc;
								}
								oProtoI.IsModified = true;
							}
						}
					}
				}
			}
		}
		return oProtoI;
	 };
	$.Routines.CreateDescriptor  = function(iNode, oDesc)
	 {
		switch(iNode.Type)
		{
			case $.ObjectType.Class        : oDesc = {value : iNode.Constructor.Value};              break;
			case $.ObjectType.Initializer  : 
			case $.ObjectType.Function     : 
			case $.ObjectType.Method       : 
			case $.ObjectType.Array        : 
			case $.ObjectType.Undefined    : //~~;
			case $.ObjectType.Value        : oDesc = {value : iNode.Value};                          break;
			case $.ObjectType.JsObject     : oDesc = {value : iNode.Value.call()};                   break;
			case $.ObjectType.Property     : oDesc = iNode.Value;                                    break;
			case $.ObjectType.Oncer        : oDesc = {get : iNode.Value, configurable : true};       break;

			//case $.ObjectType.Undefined    : oDesc = {value : undefined};                            break;
			
			default                        : oDesc = {value : new function Namespace(){}, writable : true};
		}
		return oDesc;
	 };
	

	$.AddPack                    = function(iUrl, iTreeO, iCloseF)
	 {
		var _Pack = new $.Pack(iUrl, iTreeO, iCloseF);
		{
			if($.IsTransformedState)
			{
				if(_Pack.Main) $.EntryPoints.push(_Pack);
			}
		}
		this.Files[iUrl].Packs.push(_Pack);
	 };
	$.AddFile                    = function(iFile, oIsOk)
	 {
		if($.Files[iFile.Url]) throw "WTF";
		
		$.CurrentFile = $.Files[iFile.Url] = iFile;
		
		return $.Routines.Eval(iFile.Source, iFile.Url);
	 };
	$.AddMessage                 = function(iType, iLogN, iText, iNodeII, iFileUU, iLineNN, iDoUseCns)
	 {
		if(iType     == undefined) throw "WTF";
		if(iDoUseCns == undefined) iDoUseCns = true;

		if(iNodeII == undefined) iNodeII = [];  if(!(iNodeII instanceof Array)) iNodeII = [iNodeII];
		if(iFileUU == undefined) iFileUU = [];  if(!(iFileUU instanceof Array)) iFileUU = [iFileUU];
		if(iLineNN == undefined) iLineNN = [];  if(!(iLineNN instanceof Array)) iLineNN = [iLineNN];

		var _MsgS = "JSTUFF(" + iLogN + "): " + (iNodeII.length != 0 ? "'" + iNodeII.join(", ") + "' - " : "") + iText;
		{
			if(iDoUseCns) switch(iType)
			{
				case $.MessageType.Notification :
				case $.MessageType.Tip          : console.info(_MsgS); break;
				case $.MessageType.Warning      : console.warn(_MsgS); break;
				
				case $.MessageType.FatalError   : $.IsFailedState = true;
				case $.MessageType.Error        :
				{
					if(iLogN == "JSERRORS" || iLogN == "DODOCODE")
					{
						_MsgS = "JSTUFF(" + iLogN + "): " + iText + (iFileUU.length == 1 && iLineNN.length == 1 ? " [at " + iFileUU[0] + ":" + iLineNN[0] + "]" : "");
					}
					console.error(_MsgS);
					
					break;
				}
				default : throw "WTF";
			}
		}
		$.Debug && $.Debug.AddLogRecord(iType, iLogN, iText, iNodeII, iFileUU, iLineNN);
	 },
	$.TransformFiles             = function()
	 {
		$.IsTransformedState = true;
		
		for(var cUrl in Object.getProperties(this.Files))
		{
			var cFile = $.CurrentFile = this.Files[cUrl]; if(cFile.Packs.length == 0) continue;
			var cFuncS = cFile.Source;
			{
				var cMuLineComMM = cFuncS.match(/\/\*[\S\s]*?\*\//g);
				{
					if(cMuLineComMM) for(var cM,Mi = 0; cM = cMuLineComMM[Mi], Mi < cMuLineComMM.length; Mi++)
					{
						cFuncS = cFuncS.replace(cM, cM.replace(/stuff[\S\s]*?\(\{/g,"x-$&"));
					}
				}
				cFuncS = cFuncS.replace(/(\/\/.*?)(?!x-)(stuff)(.*?)/g, "$1x-$2$3");

				var cPackMM = [];
				{
					var _BegPackRgx   = /(\w+\s*:\s*)?(stuff[\s\S]*?\n ?\(\{)/;
					var _EndPackRgx   = /\n ?\}\);?/;
					var _WholePackRgx = new RegExp(_BegPackRgx.source + /([\S\s]*?)/.source + _EndPackRgx.source, "g");

					for(var cPackM, cPackI = 0; cPackM = _WholePackRgx.exec(cFuncS); cPackI++)
					{
						cPackMM.push
						({
							Index    : cPackI,
							Position : cPackM.index,
							Source   : cPackM[0].toString(),
							Result   : undefined
						});
					}
					
					if(cPackMM.length == 0) throw "ERR: Packs found in file but not in source (Regex?)";
					if(cPackMM.length != cFile.Packs.length)
					{
						if($.Debug && $.Debug.Logs["JSERRORS"].Records.length != 0)
						{
							continue; //~~ Syntax error may cause this behavior;
						}
						else throw "ERR: Pack count mismatch in source and file (Regex?)";
					}
					
					for(var cPackM,Mi = 0; cPackM = cPackMM[Mi], Mi < cPackMM.length; Mi++)
					{
						var cPack      = cFile.Packs[Mi];
						var cPackCC    = [{ID : "window", Alias : "$"}]; for(var cAlias in Object.getProperties(cPack.Closures)) cPackCC.push(cPack.Closures[cAlias]);
						
						var cOpdS = cPackM.Source;
						{
							cOpdS = cOpdS.replace(/:\s*\(\s*'([A-Z][\w\d]*)\s*'\s*,\s*(.*?)\)/g,": {get once(){return new $1($2)}}"); //~~ Grey : ('Color', 127, 127, 127);
							cOpdS = cOpdS.replace($.Config.AssignRgx, "$1 = $1 === self ? $2 : $1 || $4;");                           //~~ oVal = oVal === self ? this : oVal || new Value;

							cOpdS = cOpdS.replace($.Config.ThisArgRgx1, "this.$1 = i$1 !== undefined ? i$1 : $2;");
							cOpdS = cOpdS.replace($.Config.ThisArgRgx2, "this.$1 = i$1;");
							cOpdS = cOpdS.replace($.Config.ThisArgRgx3, "this.$2 = $1 !== undefined ? $1 : $3;");
							cOpdS = cOpdS.replace($.Config.ThisArgRgx4, "this.$2 = $1;");

							cOpdS = cOpdS.replace($.Config.ErrorArgRgx1, "$1 new function(){throw $3};");
							cOpdS = cOpdS.replace($.Config.ErrorArgRgx2, "$1 new function(){throw \"Argument not specified: '$2'\"};");
							
							/**
								//~~ 'overriden' sugar;

								this.overriden()                     ->  this.overriden.call  (this);
								this.overriden(iX,iY)                ->  this.overriden.call  (this,iX,iY);
								this.overriden(arguments)            ->  this.overriden.apply (this,arguments);
								this.overriden.Method1(iX,iY)        ->  this.overriden.prototype.Method.call   (this,iX,iY);
								

								this.overriden()                     ->  Classes[565].call  (this);
								this.overriden(iX,iY)                ->  Classes[565].call  (this,iX,iY);
								this.overriden(arguments)            ->  Classes[565].apply (this,arguments);
								
								this.overriden.Method1(iX,iY)        ->  Classes[565] .prototype.Method.call (this,iX,iY);
								(???)this.overriden[1].Method(iX,iY) ->  Classes[1238].prototype.Method.call (this,arguments);
							*/

							cOpdS = cOpdS.replace(/[ \t]*\/\/[ \t]*this\s*\.\s*overriden\s*[^;]*;/g, "");
							{
								if(/\bthis\s*\.\s*overriden\b/.test(cOpdS))
								{
									var _Len = cOpdS.length;
									{
										cOpdS = cOpdS.replace(/this\s*\.\s*overriden\s*(?!\.prototype)\.\s*([\.\w\d]+?)\(\s*arguments\s*\)/g,  "this.overriden.prototype.$1.apply(this,arguments)");
										cOpdS = cOpdS.replace(/this\s*\.\s*overriden\s*\.\s*([\.\w\d]+?)\(\s*\)/g,                             "this.overriden.prototype.$1.call(this)");
										cOpdS = cOpdS.replace(/this\s*\.\s*overriden\s*(?!\.prototype)\.\s*([\.\w\d]+?)\(/g,                   "this.overriden.prototype.$1.call(this,");
										
										cOpdS = cOpdS.replace(/this\s*\.\s*overriden\s*\(\s*arguments\s*\)/g,                                  "this.overriden.apply(this,arguments)");
										cOpdS = cOpdS.replace(/this\s*\.\s*overriden\s*\(\s*\)/g,                                              "this.overriden.call(this)");
										cOpdS = cOpdS.replace(/this\s*\.\s*overriden[ \t]*\(/g,                                                "this.overriden.call(this,");
										cOpdS = cOpdS.replace(/this\s*\.\s*overriden[ \t\r]*\n([ \t]*)\(/g,                                    "this.overriden.call\r\n$1(this,");
									}
									if(_Len != cOpdS.length)
									{
										for(var cLen, pLen; cLen = cOpdS.length, cLen != pLen; pLen = cLen)
										{
											cOpdS = cOpdS.replace(/this\s*\.\s*overriden/,"$Classes[" + (++$.LastClassIndex) + "]");
										}
									}
								}
							}
							cOpdS = cOpdS.replace(/([_a-z]\w*)\$\D\w+/g,"$1"); //~~ function(i1$num, i2$num, o1$boo);

							//~~ Pack source wrapping;
							cOpdS = cOpdS.replace(_BegPackRgx, "$1stuff\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t((function(){var $Closures, " + cPackCC.map(function(iV){return iV.Alias}).join(",") + "; var $ = \r\n{");
							cOpdS = cOpdS.replace(_EndPackRgx, "\r\n};\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\treturn [\"" + cFile.Url + "\", $, function(iClosures){$Closures = iClosures; " + cPackCC.map(function(iV){return iV.Alias + " = " + iV.ID}).join("; ") + ";}]})());");
						}
						cPackMM[Mi].Result = cOpdS;
					}
				}
				
				for(var pSrcLen = cFuncS.length, cPosDrift = 0, cPackM,Mi = 0; cPackM = cPackMM[Mi], Mi < cPackMM.length; Mi++, pSrcLen = cFuncS.length)
				{
					if(cPackM.Result == undefined) continue;
					
					var _BefS = cFuncS.substring(0, cPackM.Position + cPosDrift);
					var _AftS = cFuncS.substring(cPackM.Position + cPosDrift + cPackM.Source.length);
					
					cFuncS = _BefS + cPackM.Result + _AftS;
					
					cPosDrift += cFuncS.length - pSrcLen;
				}
				
				cFuncS += "//# sourceURL=jstuff://" + cUrl.match(/(.*?)\.\w+$/)[1] + "\r\n";
				//cFuncS += "//@ sourceURL=" + cUrl.match(/(.*?)\.\w+$/)[1];// + "\r\n";
			}
			cFile.Compiled = cFuncS;
			
			$.Routines.Eval("" + cFuncS.replace(/("use strict";)\s*/,"$1 ") + "", cUrl);
		}
		$.CurrentPack = undefined;
	 };
	$.CreateFiles                = function()
	 {
		for(var cFileId in Object.getProperties(this.SourceList))
		{
			var cFileData = this.SourceList[cFileId];

			if(cFileData && cFileData.length > 0)
			{
				var _IsSuccess = $.AddFile(new $.File(cFileId, cFileData)); if(!_IsSuccess)
				{
					//~~$.load(cFileId.match(/^.*?\/(.*)$/)[1]);
					$.load(cFileId);
				}
			}
		}
	 },
	$.CreateNodes                = function(iDoLogEE, _NN)
	 {
		if(!iDoLogEE) iDoLogEE = $.IsTransformedState;
	
		var _II = [];
		{
			for(var _UrlA = Object.getOwnPropertyNames(this.Files), cFile,Ui = 0; cFile = this.Files[_UrlA[Ui]]; Ui++)
			{
				for(var cPack,Pi = 0; cPack = cFile.Packs[Pi]; Pi++)
				{
					for(var cItem,Ii = 0; cItem = cPack.Items[Ii]; Ii++)
					{
						if(cItem.IsInstMember)
						{
							cItem.ID = cItem.ID.replace(this.Config.NameOnlyRgx, "~$&")
						}
						_II.push(cItem);
					}
				}
			}
			
			_II.sort
			(
				function(ixI,iyI)
				{
					if(ixI.ID == iyI.ID)
					{
						var ixIsO = typeof(ixI.Value) == "object";
						var iyIsO = typeof(iyI.Value) == "object";
						{
							if( ixIsO && !iyIsO) return +1;
							if(!ixIsO &&  iyIsO) return -1;
							
							if( ixIsO &&  iyIsO) return 0;
							if(!ixIsO && !iyIsO) iDoLogEE && this.AddMessage($.MessageType.FatalError, "ITEMCONF", "The node has multiple non-object items", ixI.ID, [ixI.Pack.File.Url, iyI.Pack.File.Url],[]);
						}
						return 0;
					}
					else return ixI.ID > iyI.ID ? +1 : -1;
				}
				.bind(this)
			);
		}
		
		_NN = {};
		{
			
			var fSetNodeType = function(iN,iT)
			{
				if(arguments.length == 3) throw "WTF";

				if(iN.Type == $.ObjectType.Namespace || iT == $.ObjectType.Namespace)
				{
					if(iT != $.ObjectType.Namespace)
					{
						iN.Type = iT;
					}
				}
				else
				{
					if(iN.Type != iT)
					{
						iNoLogEE && $.AddMessage
						(
							$.MessageType.FatalError, "TYPECONF", "Inconsistent object type", iN.ID,
							iN.Items.map(function(iI){return iI.Pack.File.Url}), []
						);
					}
				}
			}

			for(var cI,Ii = 0; cI = _II[Ii], Ii < _II.length; Ii++)
			{
				var cN = _NN[cI.ID] = _NN[cI.ID] || new $.Node(cI.ID);
				
				cN.Items.push(cI);
				cI.Node = cN;

				cN.IsInstMember |= cI.IsInstMember;
			}
			
			
			for(var cNodeId in Object.getProperties(_NN))
			{
				var cN = _NN[cNodeId]; for(var cI,Ii = 0; cI = cN.Items[Ii], Ii < cN.Items.length; Ii++)
				{
					if   (cI.Value == undefined) fSetNodeType(cN, this.ObjectType.Undefined);
					else
					{
						var cValType    = typeof cI.Value;
						var cValIsNull  = cI.Value == null;
						var cValIsUndef = cValType == "undefined";
						var cValIsObj   = cValType == "object" && !cValIsNull;
						var cValIsFunc  = cValType == "function";
						var cValIsNum   = cValType == "number";
						var cValIsStr   = cValType == "string";
						var cValIsArray = cI.Value instanceof Array;
						var cValIsValue = cValIsArray || $.Config.ValTypeRgx.test(cValType);
						
						var cValIsProp  = cValIsObj   && (typeof(cI.Value.get) == "function" || typeof(cI.Value.set) == "function");
						var cValIsOncer = cValIsObj   && cI.Value.hasOwnProperty("once");
						var cValIsInlay = cValIsFunc  && $.Config.InlayRgx.test(cI.Value.name);
						var cValIsJsObj = cValIsInlay && cI.Value.name == "_jso";
						var cValIsClass = cValIsObj   && (cI.Value.hasOwnProperty("instance") || cI.Value.hasOwnProperty("inherits") || cI.Value.hasOwnProperty("constructor"));
						
						if (cValIsUndef) fSetNodeType(cN, this.ObjectType.Undefined);
						else
						{
							if(cValIsValue)
							{
								fSetNodeType(cN, this.ObjectType.Value);
							}
							else if(cValIsObj)
							{
								if      (cI.Name == "instance") fSetNodeType(cN, this.ObjectType.Instance);
								else if (cI.Name == "static")   fSetNodeType(cN, this.ObjectType.Static);
								else if (cValIsClass)           fSetNodeType(cN, this.ObjectType.Class);
								else if (cValIsProp)            fSetNodeType(cN, this.ObjectType.Property);
								else if (cValIsOncer)
								{
									var _OncerD = Object.getOwnPropertyDescriptor(cI.Value, "once");
									
									if(typeof(_OncerD["get"]) == "function")
									{
										cI.Value = Function("iGetterF","return function(){Object.defineProperty(" + cN.Parent + ", \"" + cN.Name + "\", {value : iGetterF(), writable : true}); return " + cN.ID + ";}")(_OncerD["get"]);

										fSetNodeType(cN, this.ObjectType.Oncer);
									}
									else throw "WTF";
								}
								else if(cValIsArray)   fSetNodeType(cN, this.ObjectType.Array);
								else
								{
									if(cI.Name == "LastComputedEntry") debugger;
									fSetNodeType(cN, this.ObjectType.Namespace);
								}
							}
							else
							{
								if(cValIsFunc)
								{
									if(cValIsInlay)
									{
										if(cValIsJsObj) fSetNodeType(cN, this.ObjectType.JsObject);
										else
										{
											fSetNodeType(cN, this.ObjectType.Field);
											
											if(cN.Name.indexOf("~") == -1)
											{
												cN.Name         = cI.Name         = "~" + cI.Name;
												cN.ID           = cI.ID           = cI.ID.match($.Config.ParentRgx)[1] + "." + cI.Name;
												cN.IsInstMember = cI.IsInstMember = true;
											}
										};
									}
									else
									{
										if (cI.IsInstMember) fSetNodeType(cN, cI.Name == "constructor" ? this.ObjectType.Constructor : this.ObjectType.Method);
										else                 fSetNodeType(cN, cI.Name == "initializer" ? this.ObjectType.Initializer : this.ObjectType.Function);
									}
								}
								else throw "WTF";
							}
						}
						if(cN.Type == undefined)
						{
							throw "WTF";
						}
					}
				}
			}
			//~~ Filling missing chain links in 'Existing.Missing.Existing';
			for(var cNodeId in Object.getProperties(_NN)) 
			{
				for(var _IdLL = cNodeId.split('.'), cId = _IdLL[0], Li = 0; Li < _IdLL.length; cId = cId + "." + _IdLL[++Li])
				{
					if(!_NN[cId])
					{
						_NN[cId] = new $.Node(cId);
					}
				}
			}
			
			//~~ Processing relations;
			for(var cNodeId in Object.getProperties(_NN)) 
			{
				var cN = _NN[cNodeId];
				{
					if(cN.Parent)
					{
						$.Routines.LinkNodes(_NN[cN.Parent], cN);
						
						if(cN.Type == $.ObjectType.Field && cN.Parent.Type == $.ObjectType.Namespace)
						{
							cN.Parent.Type = $.ObjectType.Class;
						}
					}
				}
			}
		}
		this.Nodes = _NN;

		if(this.Debug)
		{
			this.Debug.Items = _II;
			this.Debug.Nodes = Object.getOwnPropertyNames(_NN).map(function(iNodeN){return _NN[iNodeN]});
		}
	 };
	$.CreateClosureTables        = function()
	 {
		for(var cUrl in Object.getProperties(this.Files))
		{
			var cFile = this.Files[cUrl]; for(var cPack,Pi = 0; cPack = cFile.Packs[Pi]; Pi++)
			{
				cPack.Closures = {};
				
				var cPackUU = [];
				{
					for(var cNsId in Object.getProperties(cPack.Structure)) cPackUU.push(cNsId);
					
					if(cPack.Uses) cPackUU = cPackUU.concat(cPack.Uses);
				}
				
				for(var cUsesS,Ui = 0; cUsesS = cPackUU[Ui], Ui < cPackUU.length; Ui++)
				{
					var cUsedDict = $.Routines.GetUsedNodes(cUsesS);
					
					for(var cAliasN in Object.getProperties(cUsedDict))
					{
						var cUsedId  = cUsedDict[cAliasN].ID;
						var cUsedNode = $.Nodes[cUsedId];
						{
							if(cUsedNode)
							{
								if(cUsedNode.Type == $.ObjectType.Oncer)
								{
									!this.IsTransformedState && this.AddMessage($.MessageType.FatalError, "CLOSURES","Closed oncer property", cUsedId, cPack.File.Url);
									continue;
								}
							}
						}
						//if(cAliasN == "toSource") debugger;

						if(cPack.Closures[cAliasN] != undefined)
						{
							if(cPack.Closures[cAliasN].ID != cUsedId) !this.IsTransformedState && this.AddMessage
							(
								$.MessageType.FatalError, "CLOSURES",
								"Alias '" + cAliasN + "' is already in use",
								[cUsedId, cPack.Closures[cAliasN].ID],
								cPack.File.Url
							);
							else continue;
						}
						else cPack.Closures[cAliasN] = cUsedDict[cAliasN];
					}
				}
			}
		}
	 };
	$.ProcessInheritance         = function()
	 {
		for(var cNodeId in Object.getProperties($.Nodes))
		{
			var cN = $.Nodes[cNodeId]; if(cN.Type != $.ObjectType.Class) continue;
			
			var _BaseClassId = undefined;
			{
				for(var cI,Ii = 0; cI = cN.Items[Ii]; Ii++)
				{
					var cBaseAlias = cI.Value["inherits"], cBaseClassId = undefined;

					if(cBaseAlias != undefined)
					{
						if($.Nodes.hasOwnProperty(cBaseAlias))
						{
							cBaseClassId = cBaseAlias;
						}
						else if(cBaseAlias.indexOf('.') != -1)
						{
							var _NsPart = $.Routines.GetNodeIdByAlias(cBaseAlias.match(/^([^\.]+)/)[1], cI.Pack);
							
							if(_NsPart != undefined && $.Nodes.hasOwnProperty(_NsPart))
							{
								cBaseClassId = _NsPart + "." + cBaseAlias.match(/^\w+\.([\w\.]+)$/)[1];
							}
						}
						else
						{
							cBaseClassId = $.Routines.GetNodeIdByAlias(cBaseAlias, cI.Pack);
						}

						if(cBaseClassId != undefined)
						{
							if     (_BaseClassId == undefined)    _BaseClassId = cBaseClassId;
							else if(cBaseClassId != _BaseClassId) $.IsTransformedState && $.AddMessage($.MessageType.FatalError, "CLSINHER","Class derives from different base classes: '" + _BaseClassId + "', '" + cBaseClassId +  "'", cN.ID, [cI.Pack.File.Url]);
						}
						else $.IsTransformedState && $.AddMessage($.MessageType.FatalError, "CLSINHER","Base class '" + cBaseAlias + "' not found", cN.ID, [cI.Pack.File.Url]);
					}
				}
			}
			
			if(_BaseClassId != undefined)
			{
				cN.BaseClass = $.Nodes[_BaseClassId];
			}
		}
	 };
	$.CreateConstructors         = function()
	 {
		for(var cNodeId in Object.getProperties($.Nodes)) 
		{
			if($.Nodes[cNodeId].Type != $.ObjectType.Class) continue;

			var cClassNode       = $.Nodes[cNodeId];
			var cBaseClassN      = cClassNode.BaseClass;
			var cIsDerived       = cBaseClassN != undefined;

			var cCtorNodeId      = cClassNode.ID + ".~constructor";
			var cCtorNode        = $.Nodes[cCtorNodeId];
			var cCtorExists      = cCtorNode != undefined;
			var cCtorFunc        = cCtorExists ? cCtorNode.Value : null;
			var cCtorName        = cCtorFunc != undefined ? cCtorFunc.name : "";
			
			var cCtorIsCustom    = cCtorName == "custom";
			var cCtorIsAnnex     = cCtorName == "annex";
			var cCtorIsAnonym    = cCtorName == "";
			

			var cFieldNN         = cClassNode.Children.filter(function(iNestedN){return iNestedN.Type == $.ObjectType.Field});
			var cHasFields       = cFieldNN.Length != 0;

			var cNeedsFieldsInit = (!cCtorExists && cHasFields) || cCtorIsAnnex;
			var cNeedsBaseInvoc  = !cCtorIsCustom && cIsDerived;
			var cCtorNeedsUpdate = !cCtorExists || cCtorIsAnonym || cNeedsFieldsInit || cNeedsBaseInvoc;
			

			if(cCtorNeedsUpdate)
			{
				var _CtorS = "";
				{
					if(!cCtorExists || !cCtorIsCustom)
					{
						_CtorS  = "function " + cClassNode.Name + "(iAA)\r\n";
						_CtorS += "{\r\n";
						{
							if(cNeedsBaseInvoc) _CtorS += "\t" + cBaseClassN.ID + ".call(this, iAA != undefined ? iAA : {});\r\n";
							if(cNeedsFieldsInit)
							{
								_CtorS += "\r\n\r\n\tif(iAA == undefined) iAA = {};\r\n\t{\r\n";
								
								for(var cFieldN,Fi = 0; cFieldN = cFieldNN[Fi]; Fi++)
								{
									var cName  = cFieldN.Name.substring(1);
									var cValue = cFieldN.Value;

									switch(cValue.name)
									{
										case "_boo" : cValue = cValue.length == 1 ? false   : cValue.call();                 break;
										case "_num" : cValue = cValue.length == 1 ? 0       : cValue.call();                 break;
										case "_str" : cValue = cValue.length == 1 ? "\"\""  : "\"" + cValue.call() + "\"";   break;
										case "_arr" : cValue = "[]";                                                         break;
										case "_nil" : cValue = "null";                                                       break;

										case "_obj" :
										{
											if(cValue.length == 2)
											{
												var _CtorInfo    = cValue.call();

												if(typeof(_CtorInfo.ObjOrAlias) == "string")
												{
													//if(_CtorInfo.ObjOrAlias.indexOf("THREE.Scene") != -1) debugger;

													var _CtorPathM   = _CtorInfo.ObjOrAlias.match(/^(\w+)(.*)$/);
													var _RefNsP      = _CtorPathM[1]; //~~ 'Colors' in Colors.White;
													//var _CtorAA      = Array.prototype.slice.call(_CtorInfo.Args, 1).map(function(cA){return cA == self ? "this" : cA});
													var _CtorAA      = Array.prototype.slice.call(_CtorInfo.Args, 1);
													{
														for(var cA,Ai = 0; cA = _CtorAA[Ai], Ai < _CtorAA.length; Ai++)
														{
															if(typeof(cA) == "object") _CtorAA[Ai] = JSON.stringify(_CtorAA[Ai]);
															if(cA == self)             _CtorAA[Ai] = "this";
														}
													}
													
													var _ClosureInfo = cFieldN.Items[0].Pack.Closures[_RefNsP];
													{
														if(!_ClosureInfo && window[_RefNsP])
														{
															//~~_ClosureInfo = {ID : _CtorInfo.ObjOrAlias};
															_ClosureInfo = {ID : _RefNsP};
														}
													}
													
													if(_ClosureInfo) cValue = "new " + _ClosureInfo.ID + _CtorPathM[2] + "(" + _CtorAA.join(",").replace(this.Config.SelfRgx, "$1this$2") + ")";
													else $.AddMessage($.MessageType.FatalError, "CLOSURES", "Referenced class not found: '" + _CtorInfo.Path + "'", cFieldN.ID, [cFieldN.Items[0].Pack.File.Url]);
												}
												else
												{
													var _ObjS = JSON.stringify(_CtorInfo.ObjOrAlias);
													{
														_ObjS = _ObjS.replace(this.Config.SelfRgx, "$1this$2");	
													}
													cValue = _ObjS;
												}
											}
											else cValue = "{}";

											break;
										}
									}
									
									_CtorS += "\t\tthis." + cName + " = iAA." + cName + " !== undefined ? iAA." + cName + " : " + cValue + ";\r\n";
								}

								if(_CtorS.match("new undefined")) debugger;
								_CtorS += "\t}\r\n";
							}
							if(cCtorExists)     _CtorS += "\tiUDefCtorF.apply(this, arguments);\r\n";
						}
						_CtorS += "}";
					}
					else
					{
						if(cCtorIsAnonym)
						{
							_CtorS = cCtorNode.Value.toString().replace(/^\s*function\s*(\w*)/, "function " + cClassNode.Name);
						}
						else continue;
					}
				}
				cCtorNode = new $.Node(cCtorNodeId);
				{
					cCtorNode.Type = $.ObjectType.Constructor;
					cCtorNode.IsAutoGen = true;

					cCtorNode.Items.push(new $.NodeItem(cCtorNode.ID, Function("iUDefCtorF","return " + _CtorS).call(null, cCtorFunc), undefined));
				}
			}
			$.Nodes[cCtorNodeId] = cCtorNode;
			$.Routines.LinkNodes(cClassNode, cCtorNode);
		}
	 };
	$.CompletePrototypes         = function()
	 {
		var fComplete = function(iClassN)
		{
			if(iClassN.BaseClass)
			{
				if(iClassN.BaseClass.Type == $.ObjectType.Class) fComplete(iClassN.BaseClass);
				else
				{
					$.AddMessage($.MessageType.FatalError, "CLSINHER", "Object '" + iClassN.BaseClass.ID + "' of type '" + iClassN.BaseClass.Type + "' is used as a base class", iClassN.ID);
					iClassN.BaseClass = undefined;
				}
			}

			if(!iClassN.IsProtoComplete)
			{
				var _ProtoI = $.Routines.GetPrototypeInfo(iClassN);

				if(_ProtoI.IsModified)
				{
					iClassN.Constructor.Value.prototype = _ProtoI.IsPrimary ? _ProtoI.Value : Object.create(iClassN.Constructor.Value.prototype, _ProtoI.Value);
				}
				iClassN.IsProtoComplete = true;
			}
		};

		for(var cNodeId in Object.getProperties($.Nodes))
		{
			var cNode = $.Nodes[cNodeId]; if(cNode.Type == $.ObjectType.Class)
			{
				fComplete(cNode);
			}
		}
	 };
	$.CreateStructure            = function(iRootO)
	 {
		A : for(var cNodeId in Object.getProperties($.Nodes))
		{
			B : for
			(
				var 
				
				cNsIdLL    = cNodeId.split('.'),
				cNsIdLi    = 0,
				cNsIdLevN  ,
				cNsIdSlice ,
				cNsDesc    ,
				cNode      ,
				pNsDesc    = {value : iRootO},
				pNsId      = ""
				;
				cNsIdLevN  = cNsIdLL[cNsIdLi],
				cNsIdSlice = pNsId != "" ? pNsId + "." + cNsIdLevN : cNsIdLevN,
				cNode      = $.Nodes[cNsIdSlice],
				cNsDesc    = Object.getOwnPropertyDescriptor(pNsDesc.value, cNsIdLevN),
				cNsIdLi    < cNsIdLL.length
				;
				pNsDesc    = cNsDesc,
				pNsId      = cNsIdSlice,
				cNsIdLi    ++
			)
			{
				if(!cNsDesc)
				{
					if(!cNode) throw "WTF: Node not found: '" + cNsIdSlice + "'";
					
					if(cNode.IsInstMember)
					{
						break;
					}
					else
					{
						cNsDesc = $.Routines.CreateDescriptor(cNode);

						if(cNode.Type == $.ObjectType.Value || cNode.Type == $.ObjectType.Array || cNode.Type == $.ObjectType.Undefined)
						{
							Object.defineProperty(pNsDesc.value, cNsIdLevN, {value : cNode.Value, writable : true, enumarable : true});
							break;
						}
						else if(cNode.Type == $.ObjectType.Oncer)
						{
							Object.defineProperty(pNsDesc.value, cNsIdLevN, cNsDesc);
							break;
						}
						else
						{
							if((cNode.Type == $.ObjectType.Function || cNode.Type == $.ObjectType.Initializer) && cNode.Parent != undefined)
							{
								cNsDesc = {value : cNsDesc.value.bind(pNsDesc.value)};
							}
							
							Object.defineProperty(pNsDesc.value, cNsIdLevN, cNsDesc);

							if(cNode.Type == $.ObjectType.Property) break;
						}
					}
				}
			}
		}
	 };
	$.CreateClassList            = function()
	 {
		window.$Classes = [];

		for(var cNodeId in Object.getProperties($.Nodes))
		{
			var cN = $.Nodes[cNodeId];
			{
				if(!cN.Parent)                                                             continue;
				if( cN.Parent.Type != $.ObjectType.Class)                                  continue;
				if(!cN.Parent.BaseClass)                                                   continue;
				if( cN.Type != $.ObjectType.Method && cN.Type != $.ObjectType.Constructor) continue;
			}

			for(var cI,Ii = 0; cI = cN.Items[Ii]; Ii++)
			{
				var cBaClaIdxMM = cI.Value.toString().match(/\$Classes\[\d+\]/g);
				
				if(cBaClaIdxMM != null)
				{
					for(var cM,Mi = 0; cM = cBaClaIdxMM[Mi], Mi < cBaClaIdxMM.length; Mi++)
					{
						for(var cParentN = cN, cM = cM.match(/^\$Classes\[(\d+)\]$/); cParentN != undefined; cParentN = $.Nodes[cN.Parent.ID])
						{
							if(cParentN.Type == $.ObjectType.Class)
							{
								if(cParentN.BaseClass)
								{
									$Classes[cM[1]] = cParentN.BaseClass.Constructor.Value;//Items[0].Value;
								}
								else this.AddMessage($.MessageType.FatalError, "NOTFOUND", "Base class not found", cN.ID, cI.Pack.File.Url);

								break;
							}
							else continue; //~~ Any overriden class member requires class existance;
						}
					}
				}
			}
		}
	 };
	$.InitClosures               = function()
	 {
		for(var cUrl in Object.getProperties($.Files))
		{
			$.Files[cUrl].Packs.forEach(function(cPack){cPack.Close && cPack.Close()});
		}
	 };
	$.InitClasses                = function()
	 {
		for(var cNodeId in Object.getProperties($.Nodes))
		{
			var cNode = $.Nodes[cNodeId]; if(cNode.Type == $.ObjectType.Initializer)
			{
				cNode.Value.call(cNode.Parent.Constructor.Value);
			}
		}
	 };
	$.InitPacks                  = function()
	 {
		for(var cUrl in Object.getProperties($.Files))
		{
			$.Files[cUrl].Packs.forEach(function(cPack){cPack.Init && cPack.Init.call()});
		}
	 };
	
	$.list                       = function(iSrcListO)
	 {
		for(var cUrl in iSrcListO)
		{
			if(!iSrcListO.hasOwnProperty(cUrl)) continue;
			if($.SourceList .hasOwnProperty(cUrl)) throw "Source '" + cUrl + "' is already registered";

			$.SourceList[cUrl] = iSrcListO[cUrl];
		}
	 },
	$.init                       = function()
	 {
		//console.time("Source");
		{
			$.CreateFiles              ();        //~~ Create source files;
			$.CreateNodes              (false);   //~~ Create source nodes (to take closed items from);
			$.CreateClosureTables      ();        //~~ Generate closure tables from 'uses' lists and sibling items id's;
			$.TransformFiles           ();        //~~ Transform file SourceList with embedded closures;

			//console.timeEnd("Source");
		}
		//console.time("Transformed");
		{
			$.CreateNodes              (true);    //~~ Regenerate nodes with the closure initialization functions;
			$.CreateClosureTables      ();        //~~ Regenerate aliases to resolve field initializers in constructors;
			$.ProcessInheritance       ();        //~~ Create inheritance links between nodes;
			$.CreateConstructors       ();        //~~ Generate missing class constructors;
			$.CompletePrototypes       ();        //~~ Build constructor function prototypes;
			
			$.CreateStructure          (window);  //~~ Create hierarchy of namespaces and objects (classes, functions etc); 
			$.CreateClassList          ();        //~~ ;
			
			//console.info               ($.Nodes);
			
			$.InitClosures             ();        //~~ Initialize closed aliases;
			$.InitClasses              ();        //~~ Invoke class initializers;
			$.InitPacks                ();        //~~ Invoke pack initializers;
			
			//console.timeEnd("Transformed");
		}

		$.IsInitComplete = true;

		if(0 || $.IsFailedState)
		{
			if($.Debug)
			{
				document.body.style.backgroundColor = "#ffffff";
				document.body.style.backgroundImage = "none";
				document.body.innerHTML = $.Debug.BuildReport();
			}
		}
		else
		{
			$.IsRuntimeState = true;
			$.run();
		}
	 };
	$.run                        = function()
	 {
		if      ($.EntryPoints.length == 1) $.EntryPoints[0].Main.call();
		else if ($.EntryPoints.length > 1)  $.AddMessage($.MessageType.FatalError, "ENTPOINT", "Found " + $.EntryPoints.length + " entry points", [], $.EntryPoints.map(function(iPack){return iPack.File;}), []); 
		else if ($.OnLoad)                  $.OnLoad()
		else                                $.AddMessage($.MessageType.FatalError, "ENTPOINT", "Entry point not found");
	 };
};

Object.defineProperties
 (
	Object,
	{
		specialPropertyNames : {value : /^toString|toSource|valueOf|ToString|ToSource|ValueOf$/},
		getProperties : {value : function(iObj,iDoIncAll)
		{
			if(iDoIncAll == undefined) iDoIncAll = false;
			var oOwnFF = {};
			{
				for(var _MemNN = Object.getOwnPropertyNames(iObj), cMemN,Ni = 0; cMemN = _MemNN[Ni], Ni < _MemNN.length; Ni++)
				{
					if(cMemN == "toSource") continue;

					if(iObj.hasOwnProperty(cMemN) || (iDoIncAll && iObj[cMemN] != undefined))
					{
						oOwnFF[cMemN] = undefined;// this[cMemN];
					}
				}
			}
			return oOwnFF;
		}},
		getDescriptors : {value : function(iObj,iDoIncAll)
		{
			if(iDoIncAll == undefined) iDoIncAll = false;
			
			var oOwnFF = {};
			{
				if(iDoIncAll)
				{
					for(var _MemNN = Object.getOwnPropertyNames(iObj), cMemN, Mi = 0; cMemN = _MemNN[Mi], Mi < _MemNN.length; Mi++)
					{
						oOwnFF[cMemN] = Object.getOwnPropertyDescriptor(iObj, cMemN);
					}
				}
				else
				{
					for(var cMemN in iObj)
					{
						if(iObj.hasOwnProperty(cMemN))
						{
							var cMemD = Object.getOwnPropertyDescriptor(iObj, cMemN);

							oOwnFF[cMemN] = cMemD;
						}
					}
				}
			}
			return oOwnFF;
		}},
	}
 );
//# sourceURL=jstuff://JStuff/Core
