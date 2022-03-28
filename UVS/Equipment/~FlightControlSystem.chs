"use strict";

/*
	NASA-TP-170019800023921
*/

stuff
({
	uses :
	[
		'Math',
		'Math.Geometry',

		'UVS',
	],
	'UVS' : 
	 {
		'_' :
		 {
			Init : function(iOrbiter)
			 {
				this.ORB = iOrbiter;
			 },
			Update : function()
			 {
				
			 },
			
			ADI      : {get : function(){throw "NI"; return}}, //~~normal-acceleration error for flight director, g units;
			ADIF     : {get : function(){throw "NI"; return}}, //~~filtered normal-acceleration error for flight director, g units;
			AL       : {get : function(){throw "NI"; return}}, //~~approach and landing guidance;
			ALFERR   : {get : function(){throw "NI"; return}}, //~~angle-of-attack error, deg;
			ALFERRL  : {get : function(){throw "NI"; return}}, //~~limited angle-of-attack error, deg;
			ALPDG    : {get : function(){throw "NI"; return}}, //~~angle of attack, deg;
			ALPHACM  : {get : function(){throw "NI"; return}}, //~~entry-guidance angle-of-attack command, deg;
			ALPHCMS  : {get : function(){throw "NI"; return}}, //~~smoothed entry-guidance angle-of-attack command, deg;
			AUTO     : {get : function(){throw "NI"; return}}, //~~autopilot control mode;
			BANKERR  : {get : function(){throw "NI"; return}}, //~~roll-angle error, deg;
			BANKYAW  : {get : function(){throw "NI"; return}}, //~~roll-rate command, deg/sec;
			BCSL     : {get : function(){throw "NI"; return}}, //~~filtered pitch-rate error, deg/sec;
			BETAF    : {get : function(){throw "NI"; return}}, //~~filtered angle of sideslip, deg;
			BETDG    : {get : function(){throw "NI"; return}}, //~~angle of sideslip, deg;
			BFT      : {get : function(){throw "NI"; return}}, //~~commanded body-flap-deflection rate, deg/sec;
			BFTI     : {get : function(){throw "NI"; return}}, //~~body-flap-deflection command, deg;
			BINC     : {get : function(){throw "NI"; return}}, //~~increment used in description of FADER;
			CM       : {get : function(){throw "NI"; return}}, //~~guidance-system command used in description of SMOOTHER;
			CMS      : {get : function(){throw "NI"; return}}, //~~smoothed command used in description of SMOOTHER;
			COSALP   : {get : function(){throw "NI"; return}}, //~~cosine of angle of attack;
			COSPHIL  : {get : function(){throw "NI"; return}}, //~~cosine of limited sensed roll angle;
			COSTHE   : {get : function(){throw "NI"; return}}, //~~cosine of pitch angle;
			COTALP   : {get : function(){throw "NI"; return}}, //~~cotangent of angle of attack;
			DAM      : {get : function(){throw "NI"; return}}, //~~roll rotation-hand-controller (RHC) command, deg;
			DAMS     : {get : function(){throw "NI"; return}}, //~~shaped roll-stick command, deg;
			DAMSF    : {get : function(){throw "NI"; return}}, //~~filtered roll-stick command, deg;
			DAMTR    : {get : function(){throw "NI"; return}}, //~~roll-panel-trim command;
			DAMTRS   : {get : function(){throw "NI"; return}}, //~~roll-panel-trim rate, deg/sec;
			DAT      : {get : function(){throw "NI"; return}}, //~~aileron-trim rate, deg/sec;
			DATRIM   : {get : function(){throw "NI"; return}}, //~~aileron-trim command, deg;
			DAY      : {get : function(){throw "NI"; return}}, //~~lateral-acceleration error, g units;
			DAYF     : {get : function(){throw "NI"; return}}, //~~filtered lateral-acceleration error, g units;
			DBFDC    : {get : function(){throw "NI"; return}}, //~~body-flap-deflection-rate change;
			DBFPC    : {get : function(){throw "NI"; return}}, //~~body-flap-deflection command, deg;
			DBFRM    : {get : function(){throw "NI"; return}}, //~~manual body-flap command, deg/sec;
			DEC      : {get : function(){throw "NI"; return}}, //~~preliminary elevator-deflection command, deg;
			DECC     : {get : function(){throw "NI"; return}}, //~~preliminary elevator command, deg;
			DEL      : {get : function(){throw "NI"; return}}, //~~left-elevon-command rate, deg/sec;
			DELAC    : {get : function(){throw "NI"; return}}, //~~aileron-deflection command, deg;
			DELBF    : {get : function(){throw "NI"; return}}, //~~body-flap-position feedback, deg;
			DELBFRC  : {get : function(){throw "NI"; return}}, //~~commanded body-flap-deflection change, deg;
			DELEC    : {get : function(){throw "NI"; return}}, //~~elevator-deflection command, deg;
			DELEFB   : {get : function(){throw "NI"; return}}, //~~elevator-position feedback, deg;
			DELELC   : {get : function(){throw "NI"; return}}, //~~rate-limited left-elevon-deflection command, deg;
			DELELT   : {get : function(){throw "NI"; return}}, //~~left-elevon-deflection command, deg;
			DELERC   : {get : function(){throw "NI"; return}}, //~~rate-limited right-elevon-deflection command, deg;
			DELERT   : {get : function(){throw "NI"; return}}, //~~right-elevon-deflection command, deg;
			DELES    : {get : function(){throw "NI"; return}}, //~~preliminary pitch-trim command, deg;
			DELRC    : {get : function(){throw "NI"; return}}, //~~rate-limited rudder-deflection command, deg;
			DELRCP   : {get : function(){throw "NI"; return}}, //~~past value of rate-limited rudder-deflection command, deg;
			DELSBC   : {get : function(){throw "NI"; return}}, //~~rate-limited speed-brake-deflection command, deg;
			DELSBCP  : {get : function(){throw "NI"; return}}, //~~past value of rate-limited speed-brake-deflection command, deg;
			DELSBE   : {get : function(){throw "NI"; return}}, //~~speed-brake-increment cross feed, deg;
			DEM      : {get : function(){throw "NI"; return}}, //~~pitch-rotation-hand-controller command, deg;
			DEMS     : {get : function(){throw "NI"; return}}, //~~shaped-pitch-controller command, deg;
			DEMTR    : {get : function(){throw "NI"; return}}, //~~panel-pitch trim, deg/sec;
			DEMTRS   : {get : function(){throw "NI"; return}}, //~~trim rate due to panel-pitch trim, deg/sec;
			DER      : {get : function(){throw "NI"; return}}, //~~right-elevon-command rate, deg/sec;
			DETRIM   : {get : function(){throw "NI"; return}}, //~~pitch-trim command, deg;
			DNCAL    : {get : function(){throw "NI"; return}}, //~~turn-compensated pitch rate, deg/sec;
			DPJET    : {get : function(){throw "NI"; return}}, //~~pitch-rate error, deg/sec;
			DR       : {get : function(){throw "NI"; return}}, //~~coordinated rudder command, deg;
			DRC      : {get : function(){throw "NI"; return}}, //~~rudder-deflection command, deg;
			DRCRL    : {get : function(){throw "NI"; return}}, //~~rudder-deflection-command rate, deg/sec;
			DRF      : {get : function(){throw "NI"; return}}, //~~filtered rudder-deflection command, deg;
			DRFS     : {get : function(){throw "NI"; return}}, //~~rudder-trim rate, deg/sec;
			DRFSI    : {get : function(){throw "NI"; return}}, //~~rudder-trim command, deg;
			DRI      : {get : function(){throw "NI"; return}}, //~~rudder command, deg;
			DRINCLM  : {get : function(){throw "NI"; return}}, //~~rudder-command-rate limit, deg/sec;
			DRJET    : {get : function(){throw "NI"; return}}, //~~yaw-rate error, deg/sec;
			DRM      : {get : function(){throw "NI"; return}}, //~~rudder-pedal command, deg;
			DRMS     : {get : function(){throw "NI"; return}}, //~~shaped-rudder-pedal command, deg;
			DRPC     : {get : function(){throw "NI"; return}}, //~~rudder command, deg;
			DRRC     : {get : function(){throw "NI"; return}}, //~~yaw-rate error, deg/sec;
			DRT      : {get : function(){throw "NI"; return}}, //~~filtered rudder-deflection command, deg;
			DSBC     : {get : function(){throw "NI"; return}}, //~~speed-brake command, deg;
			DSBCM    : {get : function(){throw "NI"; return}}, //~~guidance speed-brake command, deg;
			DSBCOM   : {get : function(){throw "NI"; return}}, //~~entry-guidance speed-brake command schedule, deg;
			DSBM     : {get : function(){throw "NI"; return}}, //~~manual speed-brake command, deg;
			DSBNLM   : {get : function(){throw "NI"; return}}, //~~negative speed-brake-rate limit, deg/sec;
			DSBPLM   : {get : function(){throw "NI"; return}}, //~~positive speed-brake-rate limit, deg/sec;
			DSBRL    : {get : function(){throw "NI"; return}}, //~~speed-brake-deflection-command rate, deg/sec;
			EARLY    : {get : function(){throw "NI"; return}}, //~~flight-control-system subphase;
			ENTRY    : {get : function(){throw "NI"; return}}, //~~entry guidance;
			ERRNZ    : {get : function(){throw "NI"; return}}, //~~pitch rate due to normal-acceleration error, deg/sec;
			ERRNZF   : {get : function(){throw "NI"; return}}, //~~filtered pitch rate due to normal-acceleration error, deg/sec;
			FADER    : {get : function(){throw "NI"; return}}, //~~signal fading logic;
			FADOFF   : {get : function(){throw "NI"; return}}, //~~FADER logic flag;
			FLATURN  : {get : function(){throw "NI"; return}}, //~~flat-turn regime;
			GBFT     : {get : function(){throw "NI"; return}}, //~~body-flap-positive-deflection-limit schedule, deg;
			GDAC     : {get : function(){throw "NI"; return}}, //~~gain to convert roll-rate error into aileron command, deg/(deg/sec);
			GDAM     : {get : function(){throw "NI"; return}}, //~~gain to convert roll-stick command to rate command, (deg/sec)/deg;
			GDAY     : {get : function(){throw "NI"; return}}, //~~gain to convert lateral-acceleration error to yaw-rate command, (deg/sec)/g units;
			GDBF     : {get : function(){throw "NI"; return}}, //~~gain to scale body-flap-deflection rate, deg/sec;
			GDEM     : {get : function(){throw "NI"; return}}, //~~gain to convert pitch-controller command into pitch-rate command, (deg/sec)/deg;
			GDQ      : {get : function(){throw "NI"; return}}, //~~gain to convert pitch-rate error into elevator command, deg/(deg/sec);
			GDRE     : {get : function(){throw "NI"; return}}, //~~gain to convert yaw-rate error into rudder command, deg/(deg/sec);
			GDRF     : {get : function(){throw "NI"; return}}, //~~gain to convert rudder command to rudder-trim rate, deg/(deg/sec);
			GGDRC    : {get : function(){throw "NI"; return}}, //~~gain to convert yaw-rate error to rudder command, deg/(deg/sec);
			GLIN     : {get : function(){throw "NI"; return}}, //~~linear coefficient in roll-stick shaping, deg/deg;
			GNY      : {get : function(){throw "NI"; return}}, //~~gain to convert rudder-pedal command to lateral-acceleration command, g units per degree;
			GNZ      : {get : function(){throw "NI"; return}}, //~~airspeed-variable gain;
			GPDAC    : {get : function(){throw "NI"; return}}, //~~scale factor;
			GPE      : {get : function(){throw "NI"; return}}, //~~gain to convert compensated roll-rate error into aileron command, deg/(deg/sec);
			GPIT     : {get : function(){throw "NI"; return}}, //~~variable used to calculate GDQ, deg (N/m2) 1/2 (deg (lb/ft2)l/2_ deg/sec \ deg/sec ];
			GPPHI    : {get : function(){throw "NI"; return}}, //~~gain to convert roll-angle error to roll-rate command, (deg/sec)/deg;
			GQAL     : {get : function(){throw "NI"; return}}, //~~gain to convert angle-of-attack error into pitch-rate command, (deg/sec)/deg;
			GRJ      : {get : function(){throw "NI"; return}}, //~~gain to scale RCS thruster pulses into trim rate, deg/sec;
			GRPF     : {get : function(){throw "NI"; return}}, //~~gain to scale filtered yaw rate;
			GSBB     : {get : function(){throw "NI"; return}}, //~~scaling gain to convert trim increment into trim rate, (deg/sec)/deg;
			GSBP     : {get : function(){throw "NI"; return}}, //~~gain to convert speed-brake increment into pitch-trim increment;
			GTEMB    : {get : function(){throw "NI"; return}}, //~~gain to scale coordinating rudder command;
			GTRE     : {get : function(){throw "NI"; return}}, //~~gain to convert preliminary pitch-trim command into pitch-trim rate, (deg/sec)/deg;
			GUIDDT   : {get : function(){throw "NI"; return}}, //~~guidance-system step size, sec;
			GUY      : {get : function(){throw "NI"; return}}, //~~gain to convert pitch RCS thruster command into pitch-trim rate, deg/sec;
			GXALR    : {get : function(){throw "NI"; return}}, //~~gain to convert aileron command to coordinating rudder command;
			HA       : {get : function(){throw "NI"; return}}, //~~altitude, m (ft);
			HS       : {get : function(){throw "NI"; return}}, //~~SMOOTHER step size, sec;
			HI       : {get : function(){throw "NI"; return}}, //~~flight-control fast-cycle time, sec;
			IMAJ     : {get : function(){throw "NI"; return}}, //~~SMOOTHER control flag;
			KGDRE    : {get : function(){throw "NI"; return}}, //~~variable used for computation of GDRE;
			LATE     : {get : function(){throw "NI"; return}}, //~~flight-control-system subphase;
			MACH     : {get : function(){throw "NI"; return}}, //~~Mach number;
			MANBF    : {get : function(){throw "NI"; return}}, //~~pilot-commanded body-flap mode;
			MANP     : {get : function(){throw "NI"; return}}, //~~pilot-commanded pitch mode;
			MANRY    : {get : function(){throw "NI"; return}}, //~~pilot-commanded roll and yaw modes;
			MANSB    : {get : function(){throw "NI"; return}}, //~~pilot-commanded speed-brake mode;
			NUM      : {get : function(){throw "NI"; return}}, //~~number of FADER steps remaining;
			NY       : {get : function(){throw "NI"; return}}, //~~lateral-acceleration feedback, g units;
			NZ       : {get : function(){throw "NI"; return}}, //~~normal-acceleration feedback, g units;
			NZCM     : {get : function(){throw "NI"; return}}, //~~TAEM/AL guidance normal-acceleration command, g units;
			NZCMS    : {get : function(){throw "NI"; return}}, //~~smoothed guidance normal-acceleration command, g units;
			PAR      : {get : function(){throw "NI"; return}}, //~~coefficient of squared term in roll-stick shaping, deg/deg 2;
			PC       : {get : function(){throw "NI"; return}}, //~~roll-rate command, deg/sec;
			PCLIM    : {get : function(){throw "NI"; return}}, //~~roll-rate limit, deg/sec;
			PCP      : {get : function(){throw "NI"; return}}, //~~roll-stick-rate command, deg/sec;
			PDAC     : {get : function(){throw "NI"; return}}, //~~scaled aileron Command, deg;
			PDACF    : {get : function(){throw "NI"; return}}, //~~filtered aileron command, deg;
			PDG      : {get : function(){throw "NI"; return}}, //~~sensed roll rate, deg/sec;
			PE       : {get : function(){throw "NI"; return}}, //~~roll-rate error, deg/sec;
			PES      : {get : function(){throw "NI"; return}}, //~~compensated roll-rate error, deg/sec;
			PHICM    : {get : function(){throw "NI"; return}}, //~~guidance roll-angle command, deg;
			PHICMS   : {get : function(){throw "NI"; return}}, //~~smoothed guidance roll-angle command, deg;
			PHIDG    : {get : function(){throw "NI"; return}}, //~~sensed roll angle, deg;
			PSTABDG  : {get : function(){throw "NI"; return}}, //~~stability-axis roll rate, deg/sec;
			QB       : {get : function(){throw "NI"; return}}, //~~dynamic pressure, N/m 2 (lb/ft 2);
			QC       : {get : function(){throw "NI"; return}}, //~~pitch-rate command, deg/sec;
			QCAL     : {get : function(){throw "NI"; return}}, //~~pitch-rate error, deg/sec;
			QDG      : {get : function(){throw "NI"; return}}, //~~sensed pitch rate, deg/sec;
			QTR      : {get : function(){throw "NI"; return}}, //~~pitch-trim rate, deg/sec;
			QTRU     : {get : function(){throw "NI"; return}}, //~~unlimited pitch-trim rate, deg/sec;
			RDG      : {get : function(){throw "NI"; return}}, //~~sensed yaw rate, deg/sec;
			RJPULSE  : {get : function(){throw "NI"; return}}, //~~net RCS thruster pulses;
			RLIMR    : {get : function(){throw "NI"; return}}, //~~rudder-deflection limit, deg;
			RNZ      : {get : function(){throw "NI"; return}}, //~~= (GNZ)(NZCMS);
			RP       : {get : function(){throw "NI"; return}}, //~~=(RDG)- _RTDG)(SINPHI)(COSTHE)Od/eVg/,sec;
			RSTAB    : {get : function(){throw "NI"; return}}, //~~scaled stability-axis yaw rate, deg/sec;
			RSTABG   : {get : function(){throw "NI"; return}}, //~~gain to scale yaw rate;
			RTDG     : {get : function(){throw "NI"; return}}, //~~= 57.3 g, deg-m/sec 2 (deg-ft/sec2);
			RTPHI    : {get : function(){throw "NI"; return}}, //~~= (RDG) (TANPHI), deg/sec;
			SINALP   : {get : function(){throw "NI"; return}}, //~~sine of angle of attack;
			SINPHI   : {get : function(){throw "NI"; return}}, //~~sine of roll angle;
			SMERR    : {get : function(){throw "NI"; return}}, //~~command increment used in each SMOOTHER step;
			SMOOTHER : {get : function(){throw "NI"; return}}, //~~guidance-command smoothing logic;
			TAEM     : {get : function(){throw "NI"; return}}, //~~terminal-area-energy-management guidance;
			TANPHI   : {get : function(){throw "NI"; return}}, //~~tangentof rollangle;
			TEMA     : {get : function(){throw "NI"; return}}, //~~lateral-acceleratiocnommand due torudder pedals,g units;
			TEMB     : {get : function(){throw "NI"; return}}, //~~preliminary aileron command, deg;
			TEMD     : {get : function(){throw "NI"; return}}, //~~guidance yaw-rate command, deg/sec;
			TEME     : {get : function(){throw "NI"; return}}, //~~coordinating rudder command, deg;
			TEMF     : {get : function(){throw "NI"; return}}, //~~elevator trim-deflection error, deg;
			TEMI     : {get : function(){throw "NI"; return}}, //~~scaled coordinating rudder command, deg;
			THEPHI   : {get : function(){throw "NI"; return}}, //~~= -(COSTHE)/(COSPHIL);
			TRBF     : {get : function(){throw "NI"; return}}, //~~scheduled elevator trim deflection, deg;
			UIN      : {get : function(){throw "NI"; return}}, //~~combination of roll and yaw RCS thrusters commanded to fire on current pass;
			UINP     : {get : function(){throw "NI"; return}}, //~~pastvalue of UIN;
			UXC      : {get : function(){throw "NI"; return}}, //~~number of roll RCS thrusters commanded to fire;
			UYC      : {get : function(){throw "NI"; return}}, //~~number of pitch RCS thrusters commanded to fire;
			UZC      : {get : function(){throw "NI"; return}}, //~~number of yaw RCS thrusters commanded to fire;
			V        : {get : function(){throw "NI"; return}}, //~~airspeed, m/sec (ft/sec);
			X        : {get : function(){throw "NI"; return}}, //~~past value of signal to be faded;
			XNEW     : {get : function(){throw "NI"; return}}, //~~current value of signal to be faded;
			YALCM    : {get : function(){throw "NI"; return}}, //~~guidance yaw-rate command, deg/sec;
			YAWJET   : {get : function(){throw "NI"; return}}, //~~yaw-rate error, deg/sec;
			Z        : {get : function(){throw "NI"; return}}, //~~Z-transform variable;
		 }
	}
});