<%@Language="C#" Debug="true"%>
<%
	string   _RootPath  = Server.MapPath(Request.QueryString["path"]);
	string   _AsmName   = System.IO.Path.GetFileName(_RootPath);
	string   _Header    = Request.QueryString["header"];
	string   _Prefix    = Request.QueryString["prefix"];
	string   _Extension = Request.QueryString["ext"] ?? "js";
	string   _ExportTo  = Request.QueryString["export"];
	
	string[] _FileList  = System.IO.Directory.GetFiles(_RootPath, "*." + _Extension, System.IO.SearchOption.AllDirectories);
	
	
	
	System.Text.StringBuilder oSrc = new System.Text.StringBuilder();
	{
		if(!String.IsNullOrEmpty(_Header))
		{
			oSrc.Append(System.IO.File.ReadAllText(Server.MapPath(_Header)));
		}
		
		oSrc.Append("stuff.list\r\n({\r\n");

		foreach(string cFilePath in _FileList)
		{
			string cFileId = cFilePath;
			{
				cFileId = cFileId.Substring(_RootPath.Length + 1);
				//cFileId = cFileId.Replace("\\","/");
				cFileId = _Prefix + _AsmName + "\\" + cFileId;
				//cFileId = cFileId.Replace("\\","\\\\");
				cFileId = cFileId.Replace("\\","/");
			}
			if(cFileId.Contains("~") || cFileId.Contains(" ") || cFileId.ToLower().Contains(".old/")) continue;

			string cFileData = System.IO.File.ReadAllText(cFilePath);
			{
				cFileData = cFileData.Replace("\\","\\\\");
				cFileData = cFileData.Replace("\"","\\\"");
				
				//cFileData = cFileData.Replace("\\\r","");
				//cFileData = cFileData.Replace("\\\n","");
				
				//cFileData = cFileData.Replace("\r","\\r");
				//cFileData = cFileData.Replace("\n","\\n");
				
				
				//cFileData = cFileData.Replace("\r\n","\\\r\n");
				
				
				cFileData = cFileData.Replace("\r","\\r");
				cFileData = cFileData.Replace("\n","\\n");
			}
			
			//oSrc.Append("\t\"" + (!String.IsNullOrEmpty(_Prefix) ? _Prefix + "/" : "") + cFileId + "\" : \"" + cFileData + "\",\r\n");
			
			oSrc.Append("\t\"" + cFileId + "\" : \"" + cFileData + "\",\r\n");
		}

		oSrc.Append("});");
	}
	if(!String.IsNullOrEmpty(_ExportTo))
	{
		string _ExpPath = Server.MapPath(_ExportTo);
		
		//System.IO.Directory.CreateDirectory(System.IO.Path.GetDirectoryName(_ExpPath));
		System.IO.File.WriteAllText(_ExpPath, oSrc.ToString());
	}
	Response.AddHeader("Access-Control-Allow-Origin", "*");
	Response.ContentType = "text/javascript";
	Response.Write(oSrc.ToString());
%>