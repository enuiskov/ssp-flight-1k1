"use strict";

stuff
 ({
	uses : 
	[
		'Math',
	],

	'System.Data' :
	 {
		'TimeSeries' : 
		 {
			'Set' :
			 {
				Entries : arr('Entry'),

				constructor : function(iEntries)
				 {
					this << iEntries || [];
				 },
				
				Add : function(iEntry)
				 {
					this.Entries.Add(iEntry);
				 },
				CreateEntry : function(iTime, iValue, oEntry)
				 {
					var oEntry = new TimeSeries.Entry(iTime, iValue);
					
					this.Add(oEntry);

					return oEntry;
				 },
				
			 },
			'Entry' : 
			 {
				Time  : obj('Date'),
				Value : any,
				
				constructor : function(iTime, iValue)
				{
					this << iTime  || new Date(0);
					this << iValue || undefined;
				},
			 },
			'Range' :
			 {
				MinI : num,
				MaxI : num,
				MinT : obj('Date'),
				MaxT : obj('Date'),

				LowI : num,
				UppI : num,
				LowT : obj('Date'),
				UppT : obj('Date'),

				constructor : function(iSeries, iFrT, iToT, iFrI, iToI)
				{
					if(!iSeries)             throw "No series specified";
					if( iSeries.Length == 0) throw "Empty series specified";

					this.MinI = 0;
					this.MaxI = iSeries.Length - 1;
					this.MinT = iSeries[this.MinI].Time;
					this.MaxT = iSeries[this.MaxI].Time;

					this.LowI = (iFrI != undefined) ? iFrI : this.MinI;
					this.UppI = (iToI != undefined) ? iToI : this.MaxI;
					
					this.LowT = (iFrT != undefined) ? iFrT : this.MinT;
					this.UppT = (iToT != undefined) ? iToT : this.MaxT;
				},
			 }
		 }
	 }
 });
