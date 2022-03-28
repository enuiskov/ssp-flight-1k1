"use strict";

$.Debug          = {};
{
	$.Debug.Files         = [],
	$.Debug.Packs         = [],
	$.Debug.Items         = [],
	$.Debug.Nodes         = [],
	
	$.Debug.Notifications = 0,
	$.Debug.Tips          = 0,
	$.Debug.Warnings      = 0,
	$.Debug.Errors        = 0,
	$.Debug.FatalErrors   = 0,
	
	$.Debug.TotalMessages = 0,
	
	$.Debug.Logs          =
	 {
		"JSERRORS" : {Records : [], Description: "JavaScript syntax, semantics and early referencing"  },
		"DODOCODE" : {Records : [], Description: "Invalid or obsolete syntax, semantics or structure" },
		"WTFERROR" : {Records : [], Description: "It's something wrong"                                },
		"NOTFOUND" : {Records : [], Description: "Something not found"                                 },
		"ITEMCONF" : {Records : [], Description: "Item conflicts"                                      },
		"TYPECONF" : {Records : [], Description: "Type conflicts"                                      },
		"STRUCTER" : {Records : [], Description: "Module structure"                                    },
		"CLOSURES" : {Records : [], Description: "Closure conflicts"                                   },
		"CLSINHER" : {Records : [], Description: "Class inheritance"                                   },
		"ENTPOINT" : {Records : [], Description: "Application entry points"                            },
		"CODECONV" : {Records : [], Description: "Code design conventions"                             },
		"PERFTIPS" : {Records : [], Description: "Performance tips"                                    },
	 },

	$.Debug.AddLogRecord  = function(iType, iLogN, iText, iDefII, iFileUU, iLineNN)
	 {
		this.Logs[iLogN].Records.push({Type : iType, Message : iText, Definitions : iDefII, Files : iFileUU, Lines : iLineNN});
		
		switch(iType)
		{
			case $.MessageType.Notification : this.Notifications ++; break;
			case $.MessageType.Tip          : this.Tips          ++; break;
			case $.MessageType.Warning      : this.Warnings      ++; break;
			case $.MessageType.Error        : this.Errors        ++; break;
			case $.MessageType.FatalError   : this.FatalErrors   ++; break;
			
			default : throw "WTF";
		}
	 },
	$.Debug.BuildReport   = function()
	 {
		var _FormatID       = function(iIdS,  iDoIncP) {return "<nobr>" + iIdS.replace(/(.*\.)?([_A-Za-z0-9]+\.)?([_A-Za-z0-9]+)$/g, (iDoIncP ? "$1" : "") + "<span title=\"$&\" class=\"MajStr\"><b>$2$3</b></span>") + "</nobr>";};
		var _FormatUrl      = function(iUrlS, iDoIncP) {return iUrlS != "" ? iUrlS .replace(/(.*\/)([\.\w]+)(:\d+)?$/g, (iDoIncP ? "$1" : "") + "<span title=\"$&\" class=\"MajStr\">$2$3</span>") : "<span class=\"MinStr\">--</span>";};
		var _FormatMessage  = function(iMsg)           {return iMsg.replace(new RegExp("'([^']*)'","g"), "<b>$1</b>");};
		var _FormatNodeType = function(iTypeS)          
		 {
			iTypeS = iTypeS.toLowerCase();
			
			var _Color;
			{
				switch(iTypeS)
				{
					case "value"       : _Color = "#00aaff"; break;
					case "class"       : _Color = "#66aa00"; break;
					case "instance"    : _Color = "#aa0000"; break;
					case "static"      : _Color = "#aa0000"; break;
					case "field"       : _Color = "#00ff00"; break;
					case "function"    : _Color = "#00aaff"; break;
					case "method"      : _Color = "#00aaff"; break;
					case "property"    : _Color = "#ff6600"; break;
					case "initializer" : _Color = "#aa0000"; break;
					case "constructor" : _Color = "#aa0000"; break;
					
					
					default            : _Color = "#cccccc";
				}
			}
			return "<span style=\"color: " + _Color + "\">" + iTypeS + "</span>";
		 };
		var _FormatItemType = function(iIsInstM)        
		 {
			return "<span style=\"font-weight: bold; color: " + (iIsInstM ? "#000000" : "#cccccc") + "\">" + (iIsInstM ? "+" : "-") + "</span>";
		 };
		var _FormatValue    = function(iI)              
		 {
			var iV = iI.Value;
			var iT = typeof(iI.Value);
			var oHTML = "";
			{
				if(iT == "object")
				{
					if(iV == null) oHTML = "null";
					else oHTML = "[Object]";
				}
				else if(iT == "undefined") oHTML = "undefined";
				else oHTML = "???";
			}
			return oHTML;
		 };
		var _FormatSources  = function(iDefII)          
		 {
			var oSrcS = "";
			{
				var _UniqueSS = [];
				{
					for(var cS,Si = 0; cS = iDefII[Si], Si < iDefII.length; Si++)
					{
						if(!_UniqueSS.some(function(iS){return iS.Url == cS.Url;}))
						{
							_UniqueSS.push(cS);
						}
					}
					_UniqueSS.forEach
					(
						function(iS,iI)
						{
							_UniqueSS[iI] = _FormatID(iS,false);
						}
					);
				}
				oSrcS = _UniqueSS.join("<br/>");
			}
			return oSrcS;
		 };
		var _FormatFiles    = function(iFileUU, iLineNN)
		 {
			var oFilesS = "";
			{
				var _UniqueII = [];
				{
					for(var cId,Fi = 0; cId = iFileUU[Fi] + (iLineNN[Fi] != undefined? ":" + iLineNN[Fi] : ""), Fi < iFileUU.length; Fi++) if(!_UniqueII.some(function(iId){return iId == cId;}))_UniqueII.push(cId);
					
					_UniqueII.forEach(function(iId,iI){_UniqueII[iI] = _FormatUrl(iId);});
				}
				oFilesS =  _UniqueII.length > 0 ? _UniqueII.join("<br/>") : "<nobr>--</nobr>";
			}
			return oFilesS;
		 };

		var oHTML = "";
		{
			oHTML +=
			"<html>\
				<head>\
					\
					<style>\
						BODY					{font-family: tahoma; font-size: 12px; margin: 0; padding: 0; background-color: #ffffff}\
						\
						H1						{margin: 20px 25px 20px 25px; font-family: verdana; font-weight: normal}\
						#Content				{padding: 0px 40px 30px 40px}\
						\
						#Content > DIV		{}\
						TABLE					{}\
							TR.LogDesc TD	{font-size: 14px; font-weight: bold; padding: 5px 10px}\
							TR.EmptyRow		{height: 20px}\
						\
							TR.Even			{background-color: #fafafa}\
							TR.Even:hover,\
							   .Odd:hover	{background-color: #fff0e0; outline: #ffaa00 1px solid}\
								TD				{font-size: 12px; padding: 3px 10px; vertical-align: top;}\
							\
							.MinStr			{color: #cc0000; font-weight: normal}\
							.MajStr			{color: #cc0000}\
							.File				{color: #cc0000}\
						\
						.ApxSrc				{color: #888888}\
						\
					</style>\
				</head>\
				<body>\
					<div id=\"Header\"></div></div>\
					<h1><span style=\"color: #cc0000\">O</span>ops...</h1>\
					<div id=\"Content\">";
					{
						oHTML += "<table cellspacing=\"0\">"; for(var cLogN in Object.getProperties(this.Logs))
						{
							if(!cLogN.match(/^[A-Z]+$/)) continue;
							
							var cLog = this.Logs[cLogN];
							{
								if(cLog.Records.length == 0) continue;
								 
								oHTML += "<tr class=\"LogDesc\"><td colspan=\"3\">" + (cLog.Description || cLogN) + "</td></tr>";
								{
									for(var cR,Ri = 0; cR = cLog.Records[Ri], Ri < cLog.Records.length; Ri++)
									{
										oHTML += "<tr class=\"LogItem " + (Ri % 2 ? "Even" : "Odd") + "\"><td style=\"padding-left: 30px\">" + _FormatSources(cR.Definitions) + "</td><td width=\"100%\">" + _FormatMessage(cR.Message) + "</td><td>" + (cR.Files != undefined ? _FormatFiles(cR.Files, cR.Lines) : "-") + "</td></tr>";
									}
								}
								oHTML += "<tr class=\"EmptyRow\"><td colspan=\"3\"></td></tr>";
							}
						}
						oHTML += "</table>";
					}
					//~~ Item table;
					if(0)
					{
						oHTML += "<table cellspacing=\"0\"><tr><td>ItemN</td><td>NodeT</td><td>IsInstM</td><td>Value</td><td>File</td></tr>";

						for(var cI,Ii = 0; cI = this.Items[Ii]; Ii++)
						{
							oHTML += "<tr class=\"" + (Ii % 2 ? "Even" : "Odd") + "\"><td>" + _FormatID(cI.ID, true) + "</td><td><b>" + _FormatNodeType(cI.Node.Type) + "</b></td><td>" + _FormatItemType(cI.IsInstMember) + "</td><td width=\"100%\" style=\"font-family: courier\">" + _FormatValue(cI) + "</td><td>" + _FormatUrl(cI.Pack ? cI.Pack.File.Url : "", false) + "</td></tr>";
						}
						oHTML += "</table>";
					}
					//~~ Node table;
					if(0)
					{
						oHTML += "<table cellspacing=\"0\"><tr><td>DefId</td><td>DefType</td><td>AutoGen</td><td>IsInstM</td><td>ItemCnt</td></tr>";

						for(var cN,Ni = 0; cN = this.Nodes[Ni]; Ni++)
						{
							oHTML += "<tr class=\"" + (Ni % 2 ? "Even" : "Odd")  + "\">\
											<td>"       + _FormatID(cN.ID, true)                 + "</td>\
											<td><b>"    + _FormatNodeType(cN.Type)               + "</b></td>\
											<td>"       + (cN.IsAutoGen ? "+" : "-")             + "</td>\
											<td>"       + _FormatItemType(cN.IsInstMember)       + "</td>\
											<td>"       + cN.Items.length                        + "</td>\
										</tr>";
						}
						oHTML += "</table>";
					}
					
					oHTML += "</div>\
					<div id=\"Footer\"></div>\
				</body>\
			</html>";
		}
		return oHTML;
	 }
	$.Debug.ParseNodes    = function(iNN)
	 {
		for(var cNodeId in iNN)
		{
			this.Nodes.push({ID : cNodeId, Value : iNN[cNodeId]});
		}
		this.Nodes.sort
		(
			function(ixN,iyN)
			{
				ixN = ixN.ID;
				iyN = iyN.ID;

				for(var Ci = 0; Ci < Math.min(ixN.length, iyN.length); Ci++)
				{
					var cxC = ixN.charAt(Ci);
					var cyC = iyN.charAt(Ci);
					
					if(cxC == cyC) continue;
					else return cxC > cyC ? +1 : -1;
				}
			}
		);

	 };
};