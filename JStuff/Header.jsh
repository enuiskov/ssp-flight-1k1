"use strict";

window.$ = window.stuff = 
{
	list : function(iSrcListO)
	 {
		for(var _FileIds = Object.getOwnPropertyNames(iSrcListO), cFileId,Fi = 0; cFileId = _FileIds[Fi]; Fi++)
		{
			var cFileExt  = cFileId.match(/[^\\\/\.]+$/)[0];
			var cFileData = iSrcListO[cFileId];

			//if(cFileExt == "js")
			{
				try         {Function(cFileData).call()}
				//catch(_Exc) {stuff.load((cFileExt == "chs" ? "../" : "") + cFileId)}
				catch(_Exc) {stuff.load(cFileId)}
			}
		}
	 },
	load : function(iUrl)
	 {
		var _ScrE = document.createElement("SCRIPT");
		{
			_ScrE.src   = iUrl;
			_ScrE.async = false;
		
			_ScrE.onreadystatechange = _ScrE.onload = function(iEvt)
			{
				if(iEvt.type == "load" || (_ScrE.readyState != undefined && _ScrE.readyState.match(/loaded|complete/)))
				{
					
				}
			}
		}
		document.head.appendChild(_ScrE);
	 },
};
