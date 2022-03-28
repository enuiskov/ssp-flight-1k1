"use strict";

stuff
({
	uses :
	[
		'Math',
		'Math.Geometry',
		'System.Data',
	],
	
	'UVS.Data' : 
	 {
		DefaultFlight : "SSPF1K1",

		"SSPF1K1" : 
		 {
			Table : 
			 {
				Original : 
				 {
					get once()
					{
						var oTable =
						[
							-17101,  -2000, 20789,  -67.2,  13.3, 1.725, 617, 65,
							-16562,  -1708, 20588,  -63.5,  13.3, 1.725, 613, 65,
							-16024,  -1375, 20387,  -59.9,  12.9, 1.725, 608, 65,

							//-20101,  -2000, 20789,  -167.2,  13.3, 1.725, 617, 65,
							//-18562,  -1708, 20588,  -63.5,  13.3, 1.725, 613, 65,
							//-16024,  -1375, 20387,  -59.9,  12.9, 1.725, 608, 65,


							-15444,  -1042, 20186,  -58.3,   7.1, 1.708, 600, 66,
							-14864,   -708, 19985,  -56.8,  -0.8, 1.683, 598, 66,
							-14367,   -417, 19784,  -58.9, -10.0, 1.683, 594, 67,
							-13787,    -42, 19583,  -62.0, -21.2, 1.667, 590, 67,
							-12959,    417, 19521,  -67.2, -38.7, 1.642, 585, 68,
							-12048,    875, 19313,  -73.4, -49.2, 1.600, 577, 68,
							-11219,   1292, 19125,  -77.1, -50.0, 1.567, 573, 69,
							-10308,   1708, 18896,  -79.7, -50.0, 1.525, 565, 70,
							 -9604,   2000, 18792,  -82.3, -50.0, 1.500, 556, 71,
							 -8734,   2292, 18625,  -84.4, -50.0, 1.479, 558, 71,
							 -8154,   2458, 18500,  -85.9, -49.6, 1.463, 554, 72,
							 -7492,   2667, 18375,  -88.0, -49.6, 1.450, 552, 72,
							 -6746,   2875, 18229,  -90.6, -49.2, 1.429, 554, 73,
							 -6332,   2958, 18146,  -91.7, -49.6, 1.425, 552, 73,
							 -5586,   3125, 17979,  -93.7, -49.6, 1.396, 548, 74,
							 -5048,   3167, 17854,  -95.3, -49.2, 1.375, 544, 74,
							 -4178,   3292, 17646,  -95.8, -48.7, 1.338, 533, 75,
							 -3474,   3333, 17479,  -95.8, -49.2, 1.308, 527, 75,
							 -2811,   3375, 17313,  -96.9, -50.8, 1.283, 519, 75,
							 -1983,   3333, 17104,  -99.0, -48.7, 1.250, 519, 75,
							 -1652,   3333, 17021, -100.0, -48.7, 1.250, 517, 75,
							 -1196,   3292, 16896, -101.0, -48.7, 1.229, 515, 75,
							  -741,   3250, 16771, -102.1, -48.7, 1.204, 508, 75,
							  -409,   3208, 16688, -103.1, -48.7, 1.188, 502, 75,
								-36,   3167, 16563, -104.2, -48.7, 1.183, 502, 75,
								295,   3083, 16479, -104.7, -49.2, 1.183, 508, 75,
								626,   3000, 16375, -105.7, -50.0, 1.179, 508, 75,
							  1082,   2875, 16229, -105.7, -50.0, 1.163, 506, 75,
							  1413,   2792, 16104, -104.2, -49.6, 1.150, 500, 75,
							  1786,   2667, 15979, -102.6, -49.6, 1.125, 494, 75,
							  2159,   2500, 15854, -101.0, -49.6, 1.096, 485, 75,
							  2449,   2375, 15771, -102.1, -48.7, 1.079, 475, 75,
							  2656,   2292, 15708, -102.1, -47.9, 1.058, 467, 75,
							  2946,   2167, 15604, -102.1, -47.9, 1.038, 463, 75,
							  3194,   2042, 15521, -102.6, -47.9, 1.029, 458, 75,
							  3526,   1833, 15417, -103.6, -48.7, 1.025, 458, 75,
							  3774,   1708, 15313, -103.6, -49.2, 1.013, 458, 75,
							  4105,   1500, 15188, -104.2, -49.6, 1.000, 456, 75,
							  4395,   1292, 15063, -104.7, -49.6, 1.000, 460, 75,
							  4644,   1083, 14979, -104.7, -49.2, 0.996, 460, 75,
							  4934,    875, 14833, -105.2, -48.3, 0.979, 456, 75,
							  5265,    583, 14667, -105.2, -48.7, 0.963, 448, 75,
							  5514,    375, 14542, -105.2, -48.7, 0.958, 452, 75,
							  5845,      0, 14375, -105.7, -47.9, 0.946, 452, 75,
							  6052,   -250, 14271, -106.2, -48.3, 0.929, 448, 75,
							  6425,   -708, 14042, -105.2, -51.2, 0.904, 438, 75,
							  6715,  -1167, 13979, -100.0, -47.5, 0.904, 444, 75,
							  6963,  -1667, 13833,  -97.4, -42.1, 0.900, 450, 75,
							  7212,  -2167, 13563,  -94.8, -24.6, 0.896, 450, 75,
							  7295,  -2375, 13500,  -93.7, -18.3, 0.892, 450, 75,
							  7419,  -2708, 13438,  -92.2, -10.0, 0.888, 450, 73,
							  7543,  -3083, 13313,  -90.6,  -7.9, 0.883, 452, 71,
							  7667,  -3375, 13167,  -88.5,  -5.4, 0.875, 452, 70,
							  7833,  -3792, 13063,  -85.9,  -1.7, 0.871, 452, 68,
							  7999,  -4208, 12917,  -82.8,  -5.8, 0.867, 454, 67,
							  8164,  -4792, 12771,  -77.6,  -4.6, 0.863, 458, 66,
							  8289,  -5167, 12646,  -76.0,  -3.7, 0.854, 456, 66,
							  8413,  -5625, 12563,  -72.4,  -3.7, 0.850, 456, 65,
							  8496,  -5833, 12521,  -70.3,  -3.7, 0.846, 456, 63,
							  8661,  -6167, 12396,  -66.1,  -4.2, 0.833, 454, 62,
							  8703,  -6375, 12354,  -64.6,  -4.2, 0.829, 454, 60,
							  8910,  -7042, 12208,  -60.4,  -4.6, 0.817, 450, 59,
							  9076,  -7500, 12083,  -55.2,  -5.4, 0.808, 454, 58,
							  9241,  -8042, 12000,  -51.6,  -6.2, 0.813, 454, 58,
							  9365,  -8375, 11938,  -47.9,  -1.2, 0.804, 452, 57,

							  9448,  -8667, 11917,  -47.4,   4.6, 0.804, 456, 56,
							  9573,  -9083, 11854,  -47.9,  17.1, 0.804, 458, 52,
							  9614,  -9208, 11813,  -49.5,  22.9, 0.804, 460, 45,
							  9697,  -9417, 11771,  -50.5,  30.8, 0.804, 460, 38,
							  9821,  -9792, 11708,  -52.1,  42.1, 0.800, 460, 31,
							  9904, -10000, 11667,  -52.1,  47.1, 0.796, 456, 25,
							 10028, -10208, 11604,  -52.1,  47.5, 0.788, 452, 19,
							 10111, -10375, 11542,  -52.1,  47.1, 0.783, 450, 14,
							 10194, -10542, 11521,  -51.6,  47.5, 0.775, 448, 11,
							 10360, -10792, 11438,  -51.6,  48.3, 0.758, 440,  9,
							 10442, -10917, 11396,  -51.6,  47.9, 0.754, 440,  6,
							 10525, -11000, 11375,  -52.1,  47.5, 0.746, 435,  4,
							 10649, -11167, 11333,  -52.6,  47.5, 0.742, 433,  2,
							 10732, -11292, 11292,  -52.6,  47.9, 0.738, 431,  1,
							 10898, -11500, 11250,  -53.6,  47.5, 0.733, 433,  0,
							 11064, -11667, 11208,  -55.2,  46.7, 0.733, 433,  0,
							 11146, -11708, 11167,  -56.2,  47.5, 0.738, 433,  1,
							 11229, -11833, 11125,  -56.8,  47.5, 0.733, 435,  2,
							 11312, -11917, 11125,  -57.3,  47.5, 0.733, 435,  1,
							 11643, -12167, 11042,  -59.9,  47.1, 0.733, 438,  3,
							 11892, -12333, 11042,  -62.0,  47.5, 0.733, 438,  3,
							 12140, -12500, 10938,  -63.5,  47.9, 0.742, 448,  5,
							 12223, -12625, 10896,  -64.1,  47.5, 0.742, 448,  8,
							 12389, -12708, 10854,  -65.1,  47.1, 0.742, 448, 10,
							 12555, -12792, 10813,  -66.1,  47.1, 0.733, 450, 12,
							 12720, -12875, 10750,  -67.7,  47.5, 0.742, 452, 14,
							 12969, -13000, 10688,  -69.3,  47.5, 0.742, 452, 18,
							 13135, -13083, 10646,  -69.8,  47.5, 0.733, 452, 19,
							 13383, -13208, 10563,  -70.8,  47.1, 0.729, 454, 20,
							 13590, -13292, 10500,  -71.4,  47.1, 0.725, 452, 20,
							 13880, -13375, 10417,  -72.4,  47.9, 0.717, 448, 20,
							 14087, -13458, 10375,  -72.9,  47.5, 0.708, 446, 18,
							 14211, -13500, 10313,  -72.9,  47.1, 0.717, 450, 17,
							 14460, -13542, 10250,  -73.4,  46.7, 0.717, 454, 16,
							 14626, -13583, 10208,  -73.4,  46.7, 0.721, 460, 19,
							 14791, -13625, 10167,  -74.0,  46.7, 0.729, 465, 23,
							 14957, -13625, 10125,  -74.0,  46.7, 0.738, 473, 27,
							 15123, -13625, 10063,  -74.0,  46.7, 0.738, 475, 31,
							 15247, -13625, 10021,  -74.0,  46.7, 0.738, 479, 34,
							 15413, -13625,  9979,  -75.0,  46.7, 0.742, 481, 39,
							 15578, -13625,  9958,  -74.5,  47.1, 0.742, 483, 43,
							 15785, -13667,  9896,  -74.5,  47.1, 0.746, 488, 47,
							 15951, -13708,  9833,  -74.0,  46.7, 0.746, 490, 50,
							 16241, -13625,  9771,  -74.0,  47.1, 0.750, 496, 54,
							 16448, -13583,  9708,  -73.4,  47.1, 0.750, 500, 57,
							 16655, -13542,  9646,  -72.9,  47.1, 0.750, 502, 59,
							 16821, -13500,  9604,  -72.4,  46.7, 0.750, 502, 60,
							 17069, -13417,  9521,  -71.9,  46.7, 0.754, 504, 60,
							 17235, -13375,  9458,  -70.8,  46.7, 0.750, 506, 59,
							 17442, -13333,  9396,  -69.8,  46.7, 0.750, 510, 60,
							 17649, -13208,  9333,  -68.2,  46.7, 0.750, 510, 62,
							 17815, -13125,  9250,  -67.2,  46.7, 0.746, 513, 62,
							 18022, -13042,  9188,  -66.1,  46.7, 0.746, 513, 62,
							 18105, -12958,  9167,  -66.1,  46.3, 0.746, 513, 63,
							 18229, -12917,  9104,  -65.1,  45.8, 0.742, 513, 62,
							 18395, -12750,  9042,  -64.1,  46.3, 0.738, 513, 63,
							 18685, -12583,  8917,  -61.5,  46.3, 0.729, 510, 60,
							 18809, -12417,  8854,  -60.9,  46.3, 0.725, 508, 58,
							 18933, -12333,  8771,  -58.9,  46.3, 0.721, 504, 57,
							 19016, -12208,  8750,  -57.3,  45.4, 0.717, 502, 55,
							 19140, -12083,  8646,  -55.2,  37.9, 0.713, 500, 53,
							 19223, -11958,  8646,  -53.1,  29.6, 0.708, 502, 50,
							 19264, -11875,  8604,  -51.6,  25.8, 0.700, 502, 48,
							 19430, -11583,  8542,  -49.0,   9.6, 0.700, 500, 47,
							 19596, -11292,  8438,  -42.2,  -0.8, 0.700, 500, 48,
							 19761, -11000,  8375,  -40.6,   3.8, 0.692, 500, 50,
							 19886, -10708,  8313,  -40.1,  11.3, 0.688, 498, 49,
							 20051, -10417,  8250,  -38.0,  20.8, 0.688, 496, 50,
							 20176, -10125,  8167,  -37.5,  23.3, 0.683, 498, 48,
							 20300,  -9875,  8104,  -35.4,  24.2, 0.675, 496, 46,
							 20341,  -9667,  8063,  -34.9,  23.3, 0.671, 496, 44,
							 20507,  -9167,  7958,  -33.3,  20.8, 0.667, 494, 44,
							 20548,  -8958,  7917,  -33.9,  20.4, 0.663, 492, 41,
							 20714,  -8208,  7771,  -33.3,  19.2, 0.646, 490, 40,
							 
							 20797,  -7208,  7667,  -33.9,  18.3, 0.638, 483, 37,
							 20880,  -6542,  7500,  -34.9,  15.0, 0.629, 483, 35,
							 20880,  -6042,  7454,  -35.9,   6.7, 0.625, 483, 34,

							 20880,  -5667,  7324,  -37.0,  -2.1, 0.617, 483, 26,
							 20880,  -5208,  7283,  -36.5,  -1.2, 0.613, 483, 23,
							 20838,  -4875,  7262,  -35.9,  -0.4, 0.608, 485, 26,
							 20838,  -4750,  7158,  -35.4,   2.5, 0.608, 488, 33,
							 20714,  -4500,  6930,  -35.9,  17.9, 0.604, 483, 34,
							 20673,  -4250,  6834,  -36.5,  20.8, 0.596, 481, 38,
							 20590,  -4125,  6771,  -35.9,  19.6, 0.596, 479, 33,
							 20424,  -3625,  6646,  -35.9,  12.9, 0.592, 479, 34,
							 20341,  -3542,  6583,  -35.4,  12.1, 0.592, 481, 35,
							 20217,  -3208,  6500,  -36.5,  12.1, 0.592, 483, 36,
							 20134,  -3083,  6438,  -37.0,  13.3, 0.588, 483, 41,
							 20093,  -3000,  6417,  -37.0,  13.8, 0.588, 483, 42,
							 19927,  -2708,  6313,  -35.9,  15.4, 0.583, 485, 39,
							 19803,  -2583,  6250,  -36.5,  13.8, 0.575, 479, 38,
							 19720,  -2417,  6208,  -36.5,  12.5, 0.575, 475, 34,
							 19637,  -2375,  6167,  -36.5,  12.9, 0.575, 477, 28,
							 19596,  -2292,  6146,  -35.9,  12.9, 0.575, 479, 23,
							 19554,  -2208,  6104,  -35.9,  12.5, 0.571, 479, 20,
							 19513,  -2167,  6104,  -37.0,  12.9, 0.575, 481, 20,
							 19389,  -2000,  6042,  -35.9,  13.3, 0.571, 479, 22,
							 19347,  -2000,  6021,  -37.0,  15.0, 0.571, 481, 28,
							 19223,  -1833,  5958,  -37.5,  13.8, 0.571, 481, 30,
							 19140,  -1708,  5958,  -37.5,  13.3, 0.571, 483, 33,
							 19016,  -1667,  5875,  -37.5,  12.9, 0.571, 483, 35,
							 18933,  -1542,  5854,  -37.5,  12.9, 0.571, 488, 39,
							 18809,  -1417,  5813,  -37.5,  12.9, 0.563, 483, 42,
							 18726,  -1333,  5771,  -38.0,  13.3, 0.563, 483, 37,
							 18602,  -1208,  5729,  -38.0,  13.8, 0.563, 481, 30,
							 18519,  -1208,  5688,  -37.5,  13.3, 0.558, 479, 23,
							 18436,  -1167,  5625,  -37.5,  13.3, 0.554, 479, 13,
							 18312,  -1042,  5646,  -37.0,  13.3, 0.558, 477, 12,
							 18188,   -958,  5646,  -36.5,  12.9, 0.554, 477, 10,
							 18146,   -917,  5563,  -36.5,  12.1, 0.554, 479,  7,
							 18022,   -833,  5500,  -35.9,  10.8, 0.554, 481, 10,
							 17898,   -750,  5458,  -35.9,  10.8, 0.554, 485, 15,
							 17815,   -750,  5438,  -36.5,  12.5, 0.554, 483, 21,
							 17691,   -708,  5417,  -37.5,  13.8, 0.554, 485, 27,
							 17608,   -625,  5375,  -38.0,  14.2, 0.554, 483, 30,
							 17442,   -542,  5313,  -39.1,  13.8, 0.554, 485, 27,
							 17359,   -500,  5292,  -40.1,  14.2, 0.554, 488, 30,
							 17235,   -458,  5271,  -41.1,  14.6, 0.554, 490, 33,
							 17111,   -417,  5208,  -42.2,  16.3, 0.550, 490, 40,
							 16986,   -375,  5167,  -42.7,  16.3, 0.546, 492, 45,
							 16862,   -333,  5125,  -43.2,  15.4, 0.546, 492, 50,
							 16738,   -292,  5083,  -43.2,  14.6, 0.550, 494, 55,
							 16696,   -250,  5063,  -43.2,  13.3, 0.533, 494, 60,
							 16489,   -208,  5021,  -42.7,   0.0, 0.550, 492, 65,
							 16365,   -167,  5000,  -42.2,  -4.6, 0.542, 490, 59,
							 16241,   -125,  4958,  -42.2,  -0.8, 0.533, 488, 54,
							 16158,    -83,  4917,  -41.7,   6.7, 0.533, 488, 47,
							 16075,    -42,  4896,  -42.2,  12.9, 0.525, 485, 43,
							 16034,      0,  4875,  -42.2,  18.3, 0.525, 483, 40,
							 15910,      0,  4833,  -43.2,  28.3, 0.525, 481, 33,
							 15785,      0,  4750,  -43.2,  30.4, 0.521, 477, 28,
							 15661,      0,  4688,  -43.2,  31.7, 0.521, 477, 22,
							 15537,      0,  4625,  -42.2,  30.8, 0.521, 475, 17,
							 15413,      0,  4583,  -42.2,  27.1, 0.517, 475, 10,
							 15371,      0,  4563,  -42.2,  24.6, 0.517, 477,  6,
							 15247,      0,  4542,  -41.1,  18.8, 0.517, 479,  2,
							 15205,      0,  4521,  -41.7,  16.3, 0.521, 481,  1,
							 14957,      0,  4438,  -41.1,   5.4, 0.525, 485,  0,
							 14791,      0,  4375,  -41.7,   2.5, 0.525, 490,  0,
							 14626,      0,  4313,  -42.2,  -2.9, 0.521, 492,  0,
							 14418,      0,  4250,  -44.3,  -0.8, 0.521, 496,  0,
							 14211,      0,  4188,  -44.3,  -1.7, 0.529, 496,  0,

							 13963,      0,  4146,  -54.7,  -3.3, 0.538, 506,  0,
							 13797,      0,  4063,  -65.1,  -3.7, 0.538, 510,  0,
							 13632,      0,  3979,  -73.4,  -4.2, 0.542, 521,  0,
							 13466,      0,  3833,  -79.2,  -2.9, 0.550, 529,  1,
							 13383,      0,  3792,  -80.7,  -2.5, 0.550, 533,  3,
							 13300,      0,  3750,  -80.7,  -1.7, 0.558, 538,  6,
							 13259,      0,  3708,  -79.2,  -2.1, 0.563, 542,  9,
							 13135,      0,  3625,  -77.1,  -0.4, 0.567, 548, 13,
							 13052,      0,  3563,  -74.5,  -0.8, 0.567, 554, 16,
							 12969,      0,  3521,  -72.4,   0.0, 0.567, 558, 20,
							 12927,      0,  3500,  -70.8,   0.0, 0.571, 560, 23,
							 12803,      0,  3458,  -69.8,   0.4, 0.575, 565, 26,
							 12762,      0,  3417,  -68.2,   0.8, 0.575, 569, 28,
							 12638,      0,  3375,  -66.7,   0.8, 0.579, 573, 33,
							 12555,      0,  3354,  -64.6,   0.8, 0.579, 575, 37,
							 12430,      0,  3292,  -61.5,   1.3, 0.583, 579, 41,
							 12306,      0,  3229,  -59.4,   0.8, 0.583, 581, 46,
							 12223,      0,  3188,  -57.8,   0.8, 0.583, 583, 51,
							 12099,      0,  3167,  -54.7,   0.8, 0.579, 583, 56,
							 11975,      0,  3104,  -53.1,   0.8, 0.579, 583, 61,
							 11809,      0,  3063,  -52.1,   0.0, 0.575, 579, 67,
							 11685,      0,  3021,  -50.5,  -0.4, 0.571, 577, 71,
							 11602,      0,  3000,  -50.0,  -1.7, 0.567, 575, 74,
							 11519,      0,  2958,  -49.0,  -2.1, 0.563, 571, 78,
							 11395,      0,  2896,  -48.4,  -2.9, 0.554, 569, 82,
							 11271,      0,  2875,  -47.4,  -2.9, 0.550, 565, 86,
							 11146,      0,  2833,  -46.9,  -2.9, 0.546, 560, 87,
							 10939,      0,  2750,  -46.9,  -2.9, 0.538, 554, 87,
							 10815,      0,  2708,  -46.9,  -2.9, 0.533, 548, 87,
							 10649,      0,  2667,  -46.4,  -2.5, 0.529, 542, 86,
							 10567,      0,  2646,  -47.4,  -1.2, 0.525, 542, 83,
							 10525,      0,  2625,  -47.9,  -1.7, 0.521, 540, 80,
							 10442,      0,  2604,  -47.9,  -1.7, 0.517, 538, 75,
							 10318,      0,  2542,  -47.9,  -2.5, 0.517, 538, 71,
							 10235,      0,  2500,  -48.4,  -2.9, 0.513, 531, 68,
							 10152,      0,  2458,  -47.9,  -2.9, 0.513, 533, 66,
							  9945,      0,  2396,  -47.4,  -2.5, 0.508, 540, 65,
							  9738,      0,  2333,  -46.9,  -0.4, 0.504, 535, 64,
							  9573,      0,  2250,  -46.9,   0.0, 0.508, 533, 66,
							  9407,      0,  2208,  -46.9,   0.0, 0.500, 531, 63,
							  9241,      0,  2167,  -47.4,   0.0, 0.500, 531, 61,
							  9076,      0,  2083,  -46.9,  -1.2, 0.496, 529, 59,
							  8910,      0,  2021,  -46.4,  -2.9, 0.488, 529, 58,
							  8868,      0,  2000,  -46.4,  -2.1, 0.492, 529, 55,
							  8744,      0,  1979,  -46.4,  -2.1, 0.492, 529, 55,
							  8579,      0,  1896,  -45.8,  -2.9, 0.492, 527, 56,
							  8454,      0,  1854,  -45.8,  -2.1, 0.488, 531, 58,
							  8413,      0,  1833,  -45.8,  -2.5, 0.488, 529, 60,
							  8371,      0,  1813,  -45.8,  -2.5, 0.488, 529, 62,
							  8247,      0,  1771,  -44.8,  -2.1, 0.483, 529, 63,
							  8123,      0,  1750,  -44.3,  -0.4, 0.483, 527, 60,
							  7999,      0,  1688,  -44.3,  -0.4, 0.479, 523, 58,
							  7916,      0,  1667,  -43.7,  -0.4, 0.479, 527, 52,
							  7792,      0,  1625,  -44.8,  -0.8, 0.479, 529, 52,
							  7709,      0,  1583,  -43.7,  -0.4, 0.479, 529, 55,
							  7460,      0,  1500,  -43.2,   1.7, 0.479, 525, 55,
							  7336,      0,  1458,  -42.7,   0.8, 0.479, 529, 57,
							  7253,      0,  1417,  -42.7,  -0.4, 0.479, 525, 59,
							  7087,      0,  1375,  -42.2,  -0.8, 0.475, 529, 60,
							  6963,      0,  1333,  -42.7,   0.0, 0.471, 525, 62,
							  6839,      0,  1292,  -42.2,   0.0, 0.471, 527, 62,
							  6756,      0,  1271,  -42.7,  -0.4, 0.463, 525, 60,
							  6632,      0,  1229,  -42.7,  -0.8, 0.463, 527, 58,
							  6549,      0,  1188,  -42.2,  -0.4, 0.467, 523, 56,
							  6508,      0,  1167,  -42.7,  -0.4, 0.467, 525, 54,
							  6508,      0,  1167,  -42.2,  -0.4, 0.467, 523, 53,
							  6383,      0,  1125,  -42.2,  -0.4, 0.467, 527, 54,
							  6301,      0,  1104,  -42.7,  -0.8, 0.467, 523, 57,
							  6259,      0,  1083,  -42.2,  -0.4, 0.463, 525, 59,
							  6135,      0,  1042,  -42.7,  -0.4, 0.458, 523, 62,
							  6011,      0,  1000,  -42.7,  -0.4, 0.454, 527, 59,
							  5886,      0,   938,  -42.7,  -0.8, 0.458, 523, 57,
							  5845,      0,   917,  -42.7,  -0.8, 0.454, 523, 55,
							  5762,      0,   896,  -42.7,  -1.2, 0.454, 521, 54,
							  5679,      0,   875,  -42.7,  -2.1, 0.454, 521, 52,
							  5638,      0,   854,  -43.2,  -2.5, 0.450, 519, 49,
							  5555,      0,   833,  -42.7,  -2.9, 0.450, 517, 45,
							  5472,      0,   792,  -42.2,  -2.1, 0.450, 519, 43,
							  5431,      0,   771,  -42.2,  -2.5, 0.450, 523, 41,
							  5348,      0,   750,  -42.2,  -2.5, 0.446, 525, 40,
							  5141,      0,   667,  -42.2,  -1.2, 0.446, 529, 41,
							  5099,      0,   646,  -41.7,  -1.7, 0.446, 529, 44,
							  5058,      0,   625,  -41.1,  -1.7, 0.446, 529, 51,
							  5017,      0,   604,  -41.1,  -1.2, 0.446, 527, 54,
							  4934,      0,   583,  -41.1,  -0.8, 0.446, 525, 58,
							  4809,      0,   542,  -41.1,  -0.4, 0.446, 521, 59,
							  4685,      0,   521,  -40.6,  -1.7, 0.446, 519, 56,
							  4644,      0,   500,  -40.6,  -2.1, 0.442, 523, 53,

							  4561,      0,   458,  -40.6,  -3.7, 0.446, 515, 49, //~~1.1547;
							  4478,      0,   438,  -41.7,  -2.9, 0.442, 521, 44,
							  4395,      0,   396,  -43.2,  -2.1, 0.442, 519, 42,
							  4395,      0,   375,  -43.7,  -2.5, 0.438, 517, 40,
							  4230,      0,   313,  -42.7,  -3.7, 0.433, 513, 40,
							  4147,      0,   292,  -40.6,  -3.7, 0.429, 510, 36,
							  4023,      0,   229,  -36.5,  -3.3, 0.425, 508, 34,
							  3940,      0,   208,  -31.8,   0.4, 0.421, 506, 38,
							  3815,      0,   188,  -28.6,   1.3, 0.417, 502, 35,
							  3733,      0,   167,  -26.0,   1.3, 0.413, 498, 33,
							  3691,      0,   146,  -25.0,   0.4, 0.408, 496, 38,
							  3567,      0,   125,  -22.9,  -0.8, 0.404, 485, 38,
							  3484,      0,   104,  -19.3,  -1.2, 0.404, 479, 35,
							  3401,      0,   104,  -16.1,  -0.4, 0.396, 473, 31,
							  3360,      0,    83,  -14.6,  -0.8, 0.392, 471, 28,
							  3318,      0,    83,  -13.5,  -1.2, 0.392, 467, 26,
							  3153,      0,    63,   -9.4,  -2.1, 0.379, 458, 25,
							  3070,      0,    63,   -8.9,  -2.5, 0.375, 448, 24,
							  3028,      0,    63,   -7.8,  -1.7, 0.371, 444, 22,
							  2987,      0,    63,   -6.8,  -1.7, 0.367, 438, 19,
							  2946,      0,    63,   -6.8,  -2.1, 0.367, 435, 16,
							  2904,      0,    63,   -5.2,  -2.5, 0.363, 433, 14,
							  2821,      0,    42,   -5.2,  -3.3, 0.363, 429, 13,
							  2739,      0,    42,   -5.2,  -2.5, 0.363, 425, 15,
							  2697,      0,    42,   -5.2,  -0.4, 0.350, 421, 17,
							  2573,      0,    42,   -4.7,   0.4, 0.346, 417, 24,
							  2449,      0,    42,   -4.7,  -1.7, 0.333, 404, 32,
							  2407,      0,    42,   -4.2,  -2.1, 0.333, 402, 37,
							  2283,      0,    42,   -4.2,  -2.9, 0.321, 385, 42,
							  2200,      0,    42,   -4.2,  -2.5, 0.317, 373, 50,
							  2159,      0,    42,   -4.2,  -2.5, 0.308, 369, 56,
							  2117,      0,     5,   -4.2,  -2.5, 0.304, 367, 63,
							  
							  1952,      0,     4,   -3.0,  -1.7, 0.296, 360, 64,
							  1910,      0,     3,   -2.0,  -0.8, 0.296, 352, 65,
							  1662,      0,     2,   -1.0,  -2.1, 0.267, 317, 65,
							  1537,    -10,     1,   -0.5,  -2.9, 0.254, 308, 65,
							  1413,   -9.4,     0,   -0.3,   0.4, 0.246, 304, 65,
							  
							  1372,   -9.4,     0,      0,   0.4, 0.242, 300, 58,
							  1330,      0,     0,      0,   0.0, 0.233, 294, 53,
							  1248,      0,     0,      0,   0.0, 0.233, 288, 47,
							  1206,      0,     0,      0,   0.0, 0.221, 285, 42,
							  1123,      0,     0,      0,   0.0, 0.221, 281, 36,
							  1040,      0,     0,      0,   0.4, 0.213, 273, 31,
							  1040,      0,     0,      0,   0.4, 0.217, 271, 28,
								999,      0,     0,      0,   0.8, 0.217, 269, 25,
								958,      0,     0,      0,   1.3, 0.217, 267, 20,
								916,      0,     0,      0,   2.1, 0.217, 265, 16,
								916,      0,     0,      0,   2.1, 0.217, 263, 10,
								875,      0,     0,      0,   2.1, 0.217, 260,  5,
								792,      0,     0,      0,   2.1, 0.213, 256,  2,
								750,      0,     0,      0,   1.7, 0.213, 254,  1,
								543,      0,     0,      0,   0.8, 0.200, 250,  0,
								
								419,      0,     0,      0,   0.0, 0.196, 217,  0,
								295,      0,     0,      0,   0.4, 0.171, 188,  0,
								171,      0,     0,      0,   0.0, 0.142, 165,  0,
								  5,      0,     0,      0,   0.0, 0.129, 125,  0,
							  -119,      0,     0,      0,   0.0, 0.017,  46,  0,
							  -180,      5,     0,      0,   0.0, 0.008,   4,  0,
						];
						//for(var cV,Vi = 0; cV = gTable[Vi], Vi < gTable.Length; Vi++)
						//{
							//switch(Vi % 8)
							//{
								//case 0 : case 1 : case 2 : case 6 : case 7 :  cV = (Round(cV));                          break;
								//case 3 : case 4 :                             cV = (Round(cV * 10) / 10).ToFixed(1);     break;
								//case 5 :                                      cV = (Round(cV * 1000) / 1000).ToFixed(3); break;
							//}
							//gTable[Vi] = cV;
						//}
						//gTable = gTable.ToString().Replace(/.*?,/g,"\t$&");
						//gTable = gTable.ToString().Replace(/.*?,.*?,.*?,.*?,.*?,.*?,.*?,.*?,/g,"$&\r\n");
						

						return oTable;
					}
				 },
				Fixed    : 
				 {
					get : function()
					{
						return localStorage["PathFixes"] ? JSON.parse(localStorage["PathFixes"]) : this.Original;
					}
				 },
			 },
			Series : 
			 {
				Original : 
				 {
					get once()
					{
						return UVS.Data.GetSeriesFromTable(UVS.Data[DefaultFlight].Table.Original);
					}
				 },
				Fixed    : 
				 {
					///get : function()
					get once()
					{
						return UVS.Data.GetSeriesFromTable(UVS.Data[DefaultFlight].Table.Fixed);
					},
				 }
			 },
			//Series : 
			
			SyncD2S : function()
			{
				
			},
			SyncS2D : function()
			{
				
			},
		 },
		
		GetSeriesFromTable : function(iTable)
		 {
			//~~ smoothing position, vspeed and the bank angle data;
			var _AvgPP = [], _AvgVV = [], _AvgBB = [];
			{
				for(var Pi = 0; Pi < iTable.Length; Pi += 8)
				{
					_AvgPP.Add(new Vector3(iTable[Pi + 1], iTable[Pi],iTable[Pi + 2])); //~~ reordered coordinates;
					_AvgVV.Add(iTable[Pi + 3]);
					_AvgBB.Add(iTable[Pi + 4]);
				}
				
				if(0)
				{

					Position : for(var cI = 0; cI <  0; cI++){var cP = _AvgPP[0], pP = cP.Clone(), nP = cP.Clone();  for(var Pi = 0; Pi < _AvgPP.Length; Pi ++) {pP = cP; cP = nP; nP = _AvgPP[Pi + 1] || nP;   _AvgPP[Pi] = pP.Add(cP).Add(nP).MultiplyScalar(1 / 3);}}
					VSpd     : for(var cI = 0; cI <  1; cI++){var cV = _AvgVV[0], pV = cV,         nV = cV;          for(var Pi = 0; Pi < _AvgPP.Length; Pi ++) {pV = cV; cV = nV; nV = _AvgVV[Pi + 1] || nV;   _AvgVV[Pi] = (pV + cV + nV) / 3;}}
					//Bank     : for(var cI = 0; cI < 5; cI++){var cB = _AvgBB[0], pB = cB,         nB = cB;          for(var Pi = 0; Pi < _AvgPP.Length; Pi ++) {pB = cB; cB = nB; nB = _AvgBB[Pi + 1] || nB;   _AvgBB[Pi] = (pB + cB + nB) / 3;}}


						//for(var cI = 0; cI < 20; cI++) for(var Pi = 0; Pi < _AvgPP.Length; Pi ++) {}
					//{
						//pP = cP; cP = nP; nP = _AvgPP[Pi + 1] || nP;
						//pV = cV; cV = nV; nV = _AvgVV[Pi + 1] || nV;
						//pB = cB; cB = nB; nB = _AvgBB[Pi + 1] || nB;


						//_AvgPP[Pi] = pP.Add(cP).Add(nP).MultiplyScalar(1 / 3);
						//_AvgVV[Pi] = (pV + cV + nV) / 3;
						//_AvgBB[Pi] = (pB + cB + nB) / 3;
					//}
				
				}
				
				
				//debugger;
			}
			
			//~~ source series input;

			//debugger;
			var _SrcData = new TimeSeries.Set();
			{
				for(var cVal,pVal, cPos,Pi = 0; Pi < iTable.Length; Pi += 8, pVal = cVal)
				{
					cPos = _AvgPP[Pi / 8];
					var cMSpd = iTable[Pi + 5];

					cVal = {};
					{
					

						//cVal.Time = pVal.Time.
						
						
						//cVal.VSpd = iTable[Pi + 3];
						//cVal.Bank = iTable[Pi + 4];
						cVal.VSpd = _AvgVV[Pi / 8];
						cVal.Bank = _AvgBB[Pi / 8];
						
						cVal.MSpd = cMSpd;
						cVal.IAS  = iTable[Pi + 6];
						cVal.SpdB = iTable[Pi + 7];


						cVal.Position = cPos;
						{
							//pVal.
							if(Pi == 0)
							{
								cVal.BwdV  = new Vector3;
								cVal.FwdV  = new Vector3;

								cVal.TimeD = 0;
								cVal.TimeV = 0;
							}
							else
							{
								
								pVal.FwdV = cPos.Subtract(pVal.Position);



								//if(Pi == 1)
								//{
								//	pVal.TimeD = 0;///cVal.FwdV.Z / cVal.VSpd;
								//	pVal.TimeV = 0;//cVal.TimeV + cVal.TimeD;
								//}

								cVal.BwdV  = pVal.FwdV.Inverse();

								//cVal.BwdV = pVal.FwdV;.pVal.Position.Subtract(cPos);
								//pVal.FwdV  = cPos.Subtract(pVal.Position);

								cVal.TimeD = pVal.FwdV.Z / cVal.VSpd;
								cVal.TimeV = pVal.TimeV + cVal.TimeD;
							}
						}

						cVal.Velocity = cVal.BwdV.Inverse().MultiplyScalar(1 / (cVal.TimeD || 1));
						cVal.Vel      = undefined; //~~ disabled for approach diagram;//cVal.Velocity.Length;

						if(Pi == 8)
						{
							pVal.Velocity = cVal.Velocity;
							pVal.Vel      = cVal.Vel;
						}

						//cVal.Acceleration = cVal.BwdV.Inverse().MultiplyScalar(1 / (cVal.TimeD || 1));
						cVal.Acc          = pVal ? cVal.Velocity.Length - pVal.Velocity.Length : 0;

					};
				
					_SrcData.CreateEntry(Pi / 8, cVal);
				}
				//for(var cE,Ei = 0
			}
			//$.gTable = _SrcData;









			return _SrcData;









	
			//~~ output regular series;
			var oSeries = new TimeSeries.Set(), _Step = 0.1;
			{
				var _FstV = _SrcData.Entries[0].Value;
				var _SndV = _SrcData.Entries[1].Value;
				{
					
					var cEntry, pEntry = {Value : _FstV};
					//var _DoUseZ = true;
					{
						for(var cPos = _SndV.Position.Set(0,0,null), _DoUseZ = true, _DoUseY = false; _DoUseZ || _DoUseY; _DoUseZ = cPos.Z >= 5000, _DoUseY = false && (!_DoUseZ && cPos.Y > -180))
						{
							if(_DoUseZ)
							{
								cPos = cPos.Set(0,0,cPos.Z + (pEntry.Value.VSpd * _Step));
							}
							else
							{
								if(cPos.Z != 0) //~~ switching to Y axis: f(z) -> f(y);
								{
									cPos = pEntry.Value.Position.Set(0,null,0);
								}
								
								cPos = cPos.Set(0, cPos.Y - (pEntry.Value.MSpd * 250 * _Step), 0);
							}

							
							cEntry = GetNearestEntry(cPos, _SrcData, false);
							{
								if(cEntry.Value.Position.Z > pEntry.Value.Position.Z)
								{
									GetNearestEntry(cPos, _SrcData, false, true);
								}

								cEntry.Value.Velocity = cEntry.Value.Position.Subtract(pEntry.Value.Position).MultiplyScalar(1 / _Step);
								cEntry.Value.Vel      = cEntry.Value.Velocity.Length;

								var _XXX = cEntry.Value.Vel;

								//if(_XXX > 1000) debugger;

								//if(cEntry.Time < pEntry.Time)
								//{
									////debugger;
									//DataX.GetNearestEntry(cPos, _SrcData, false, true);
								//}

								//if(cPos.Z < 18000) debugger;
							}
							oSeries.Add(cEntry); 

							pEntry = cEntry;
						}
					}
				}
				
				
				for(var cE,Ei = 0; cE = oSeries.Entries[Ei]; Ei++)
				{
					if(!cE.Value.Velocity) debugger;
				}

				//~~ smooth velocity;
				if(0) for(var cI = 0; cI < 100; cI++)
				{
					//debugger;
					var cE = oSeries.Entries[0], pE = cE, nE = cE;
				
					for(var Ei = 0; Ei < oSeries.Entries.Length; Ei ++)
					{
						pE = cE;
						cE = nE;
						nE = oSeries.Entries[Ei + 1] || nE;
						
						cE.Value.Vel = (pE.Value.Vel + cE.Value.Vel + nE.Value.Vel) / 3;
					}
				}
			}
			return oSeries;
		 },
		//LastComputedEntry  : undefined, 
		//SkippedRequests    : 0,
		
		GetNearestEntry  : function(iPos, iSrcSeries, iDoOpt, iDoDebug, oEntry$obj)
		 {
			var iFlightData = this[DefaultFlight];

			//if(iDoDebug) debugger;
			//debugger;
			if(iDoOpt == undefined) iDoOpt = true;

			if(iDoOpt)
			{
				var self = GetNearestEntry; 

				if(self.SkipRRc == undefined || self.SkipRRc >= 10) self.SkipRRc = 0;
				else
				{
					self.SkipRRc++;
					return self.Last;
				}
			}
			if(iDoOpt && !iPos) iPos = gSIM.Vehicle.Position;
			
			//if(iDoOpt && iAlt_Pos == undefined)  iAlt_Pos = gSIM.Vehicle.Position;
			//if( typeof(iAlt_Pos) == "object") debugger;

			///if(!iSrcTable) iSrcTable = this[DefaultFlight].Table.Fixed;
 
			if(!iSrcSeries) iSrcSeries = this[DefaultFlight].Series.Fixed;
			
			//if(iPos.X == 0 && iPos.Y != 0 && iPos.Z == 0)
			//{
				//debugger;
			//}
			var _Stack = [], _TimeStack = [];
			var _Time1, _Time2, _Val1, _Val2, _Err1 = 1e99, _Err2 = 1e99; for(var _EE = iSrcSeries.Entries, cEntry,Ei = 0; cEntry = _EE[Ei], Ei < (330 || _EE.Length); Ei++) //~~ HERE;
			{
				
				//var cErr = iDoOpt ? cEntry.Value.Position.Z - iAlt_Pos : cEntry.Value.Position.DistanceTo(iAlt_Pos);
				var cErr, cPos = cEntry.Value.Position;
				{
					if(iPos.Length != 0 && iPos.Length == Abs(iPos.Y) && cPos.Z > 5000) continue;


					if     (iPos.Length == 0) cErr = 0;
					else if(iPos.Length != Max(Abs(iPos.X),Abs(iPos.Y),Abs(iPos.Z))) cErr = cPos.DistanceTo(iPos);
					
					//else if(iPos.X != 0) cErr = cPos.X - iPos.X;
					else if(iPos.Y != 0) cErr = Abs(cPos.Y - iPos.Y);
					else if(iPos.Z != 0) cErr = Abs(cPos.Z - iPos.Z);

					else throw "WTF";
				}
				//if(_Err1 == undefined)
				if(_Stack.Length == 0 || cErr < _Stack[0].Err)
				{
					_Stack.unshift({Err : cErr, Time : Ei, Val : cEntry.Value});
					_TimeStack.unshift(cEntry.Time);
				}
				//if(_Val1 == undefined || (cErr < _Err1 && cErr != _Err2))                 {_Err1  = cErr; _Time1 = Ei; _Val1  = cEntry.Value;}
				//if(_Val2 == undefined || (cErr < _Err2 && cErr != _Err1)){_Err2  = cErr; _Time2 = Ei; _Val2  = cEntry.Value;}

				//if(cErr < _Err1)
				//{
					//_Err2  = _Err1;  _Time2 = _Time1;  _Val2  = _Val1;
					//_Err1  = cErr;   _Time1 = Ei;      _Val1  = cEntry.Value;
				//}
			}
			//if(iDoDebug) debugger;
			//if(_Err1

			var _S1 = _Stack[0], _S2 = _Stack[1];
			{
				if(_S1){ _Err1  = _S1.Err;  _Time1 = _S1.Time;  _Val1  = _S1.Val;}
				if(_S2){ _Err2  = _S2.Err;  _Time2 = _S2.Time;  _Val2  = _S2.Val;}
			}
			
			
			var _Val2W = (_Err1 / (_Err1 + _Err2)) || 0;
			
			//if
			//if(_Val2W < 0 || _Val2W > 1) debugger;

			oEntry =  GetNearestEntry.Last = new TimeSeries.Entry();
			{
				if(_Val1 && _Val2)
				{
					//if(Abs(_Time1 - _Time2) > 1)
					//{
						////console.info(_TimeStack);
						//debugger;
					//}

					
					oEntry.Time  = Mix(_Time1, _Time2, _Val2W);
					oEntry.Value =
					{
						Position : Vector3.Mix(_Val1.Position, _Val2.Position, _Val2W),
						Velocity : Vector3.Mix(_Val1.Velocity, _Val2.Velocity, _Val2W),
						Vel      :    Math.Mix(_Val1.Vel,      _Val2.Vel,      _Val2W),
						Acc      :    Math.Mix(_Val1.Acc,      _Val2.Acc,      _Val2W),

						VSpd     :    Math.Mix(_Val1.VSpd, _Val2.VSpd, _Val2W),
						Bank     :    Math.Mix(_Val1.Bank, _Val2.Bank, _Val2W),
						MSpd     :    Math.Mix(_Val1.MSpd, _Val2.MSpd, _Val2W),
						IAS      :    Math.Mix(_Val1.IAS,  _Val2.IAS,  _Val2W),
						SpdB     :    Math.Mix(_Val1.SpdB, _Val2.SpdB, _Val2W),

						BA       : [_Time1, _Time2]
					}
					
					//if($.gAlgoCns)
					//{
						//gAlgoCns.Clear();
						//gAlgoCns.WriteLine(["Time1", _Time1]);
						//gAlgoCns.WriteLine(["Time2", _Time2]);
						//gAlgoCns.WriteLine(["Div",   Abs(_Time1 - _Time2)]);
					//}
				}
				else if(_Val1 == undefined ^ _Val2 == undefined)
				{
					//debugger;
					oEntry.Time  = _Val1 ? _Time1 : _Time2;
					oEntry.Value = _Val1 || _Val2;
				}
				else throw "WTF";
			}

			var _V = oEntry.Value; if(isNaN(_V.IAS) || isNaN(_V.MSpd) || isNaN(_V.VSpd) || isNaN(_V.SpdB) || isNaN(_V.Position.Z)) debugger;

			//throw "WW";
			return oEntry;
		 },
		//GetNearestEntry  : function(iPos, iSrcTable$arr, iDoOpt, iDoDebug, oEntry$obj)
		 //{
			//var iFlightData = this["1K1"];

			////if(iDoDebug) debugger;
			////debugger;
			//if(iDoOpt == undefined) iDoOpt = true;

			//if(iDoOpt)
			//{
				//var self = GetNearestEntry; 

				//if(self.SkipRRc == undefined || self.SkipRRc >= 10) self.SkipRRc = 0;
				//else
				//{
					//self.SkipRRc++;
					//return self.Last;
				//}
			//}
			//if(iDoOpt && !iPos) iPos = gSIM.Vehicle.Position;
			
			////if(iDoOpt && iAlt_Pos == undefined)  iAlt_Pos = gSIM.Vehicle.Position;
			////if( typeof(iAlt_Pos) == "object") debugger;

			//if(!iSrcData) iSrcData = gApp.ApproachDiagram.VymData;
			
			////if(iPos.X == 0 && iPos.Y != 0 && iPos.Z == 0)
			////{
				////debugger;
			////}
			//var _Stack = [], _TimeStack = [];
			//var _Time1, _Time2, _Val1, _Val2, _Err1 = 1e99, _Err2 = 1e99; for(var _EE = iSrcData.Entries, cEntry,Ei = 0; cEntry = _EE[Ei], Ei < _EE.Length; Ei++)
			//{
				
				////var cErr = iDoOpt ? cEntry.Value.Position.Z - iAlt_Pos : cEntry.Value.Position.DistanceTo(iAlt_Pos);
				//var cErr, cPos = cEntry.Value.Position;
				//{
					//if(iPos.Length != 0 && iPos.Length == Abs(iPos.Y) && cPos.Z > 5000) continue;


					//if     (iPos.Length == 0) cErr = 0;
					//else if(iPos.Length != Max(Abs(iPos.X),Abs(iPos.Y),Abs(iPos.Z))) cErr = cPos.DistanceTo(iPos);
					
					////else if(iPos.X != 0) cErr = cPos.X - iPos.X;
					//else if(iPos.Y != 0) cErr = Abs(cPos.Y - iPos.Y);
					//else if(iPos.Z != 0) cErr = Abs(cPos.Z - iPos.Z);

					//else throw "WTF";
				//}
				////if(_Err1 == undefined)
				//if(_Stack.Length == 0 || cErr < _Stack[0].Err)
				//{
					//_Stack.unshift({Err : cErr, Time : Ei, Val : cEntry.Value});
					//_TimeStack.unshift(cEntry.Time);
				//}
				////if(_Val1 == undefined || (cErr < _Err1 && cErr != _Err2))                 {_Err1  = cErr; _Time1 = Ei; _Val1  = cEntry.Value;}
				////if(_Val2 == undefined || (cErr < _Err2 && cErr != _Err1)){_Err2  = cErr; _Time2 = Ei; _Val2  = cEntry.Value;}

				////if(cErr < _Err1)
				////{
					////_Err2  = _Err1;  _Time2 = _Time1;  _Val2  = _Val1;
					////_Err1  = cErr;   _Time1 = Ei;      _Val1  = cEntry.Value;
				////}
			//}
			////if(iDoDebug) debugger;
			////if(_Err1

			//var _S1 = _Stack[0], _S2 = _Stack[1];
			//{
				//if(_S1){ _Err1  = _S1.Err;  _Time1 = _S1.Time;  _Val1  = _S1.Val;}
				//if(_S2){ _Err2  = _S2.Err;  _Time2 = _S2.Time;  _Val2  = _S2.Val;}
			//}
			
			
			//var _Val2W = (_Err1 / (_Err1 + _Err2)) || 0;
			
			////if
			////if(_Val2W < 0 || _Val2W > 1) debugger;

			//oEntry =  GetNearestEntry.Last = new TimeSeries.Entry();
			//{
				//if(_Val1 && _Val2)
				//{
					////if(Abs(_Time1 - _Time2) > 1)
					////{
						//////console.info(_TimeStack);
						////debugger;
					////}

					
					//oEntry.Time  = Mix(_Time1, _Time2, _Val2W);
					//oEntry.Value =
					//{
						//Position : Vector3.Mix(_Val1.Position, _Val2.Position, _Val2W),
						//Velocity : Vector3.Mix(_Val1.Velocity, _Val2.Velocity, _Val2W),
						//Vel      :    Math.Mix(_Val1.Vel,      _Val2.Vel,      _Val2W),

						////Velocity : iDoOpt ? Vector3.Mix(_Val1.Velocity, _Val2.Velocity, _Val2W) : undefined,
						////Vel      : iDoOpt ?    Math.Mix(_Val1.Vel,      _Val2.Vel,      _Val2W) : undefined,


						////cV.Vel  = cV.Velocity.Length;
						//VSpd     : Math.Mix(_Val1.VSpd, _Val2.VSpd, _Val2W),
						//Bank     : Math.Mix(_Val1.Bank, _Val2.Bank, _Val2W),
						//MSpd     : Math.Mix(_Val1.MSpd, _Val2.MSpd, _Val2W),
						//IAS      : Math.Mix(_Val1.IAS,  _Val2.IAS,  _Val2W),
						//SpdB     : Math.Mix(_Val1.SpdB, _Val2.SpdB, _Val2W),

						//BA : [_Time1, _Time2]
					//}
					
					////if($.gAlgoCns)
					////{
						////gAlgoCns.Clear();
						////gAlgoCns.WriteLine(["Time1", _Time1]);
						////gAlgoCns.WriteLine(["Time2", _Time2]);
						////gAlgoCns.WriteLine(["Div",   Abs(_Time1 - _Time2)]);
					////}
				//}
				//else if(_Val1 == undefined ^ _Val2 == undefined)
				//{
					////debugger;
					//oEntry.Time  = _Val1 ? _Time1 : _Time2;
					//oEntry.Value = _Val1 || _Val2;
				//}
				//else throw "WTF";
			//}

			//var _V = oEntry.Value; if(isNaN(_V.IAS) || isNaN(_V.MSpd) || isNaN(_V.VSpd) || isNaN(_V.SpdB) || isNaN(_V.Position.Z)) debugger;


			//return oEntry;
		 //},
		//GetNearestEntries  : function(iAlt_Pos$any, iSrcData$arr, oEE$obj)
		 //{
			//oEE = {};
			//{
				//var _UpVal, _LoVal, _UpErr, _LoErr; for(var cVal,Vi = 0; cVal = iSrcData[Vi], Vi < iSrcData.Length; Vi++)
				//{
					//var cErr = typeof(iAlt_Pos) == "number" ? cVal.Position.Z - iAlt_Pos : cVal.Position.DistanceTo(iAlt_Pos);

					//if(cErr > 0)
					//{
						//if(_UpVal == undefined || cErr <= _UpErr)
						//{
							//_UpVal = cVal;
							//_UpErr = Abs(cErr);
						//}
					//}
					//else if(cErr < 0)
					//{
						//if(_LoVal == undefined || Abs(cErr) <= _LoErr)
						//{
							//_LoVal = cVal;
							//_LoErr = Abs(cErr);
						//}
					//}
				//}

				//oEE.UpV = _UpVal;
				//oEE.LoV = _LoVal;

				//oEE.UpE = _UpErr;
				//oEE.LoE = _LoErr;
				
				//oEE.UpW = _LoErr / (_UpErr + _LoErr);
				//oEE.LoW = 1 - oEE.UpW;
			//}
			//return oEE;
		 //},
	 }
});