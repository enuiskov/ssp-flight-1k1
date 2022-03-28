"use strict";

stuff
 ({
	'PrivateCollection' : 
	 {
		Owner : obj,
		Items : arr,

		constructor : function(iOwner, iItems)
		 {
			this << iOwner;
			this << iItems || [];
		 },

		SetOwner : function(iOwner)
		 {
			this << iOwner;

			this.Items.ForEach(function(cI){cI.Parent = iOwner});
		 },
		SyncItem : function(){/* empty */},

		Add : function(iI)
		 {
			iI.Owner = this.Owner;

			this.Items.Add(iI);
		 },
		AddRange : function(iII)
		 {
			for(var cI,Ii = 0; cI = iII[Ii], Ii < iII.Length; Ii++)
			{
				this.Add(cI);
			}
		 },
	 }
 });
