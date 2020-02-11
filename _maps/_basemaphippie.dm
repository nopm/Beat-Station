//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\Mining\tgLavaland.dmm"
		#include "map_files\generic\City_of_Cogs.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\KiloStation\KiloStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\MetaLake\MetaLake.dmm"
		#include "map_files\PubbyStation\PubbyStation.dmm"
		#include "map_files\BoxStation\BoxStation.dmm"
		#include "map_files\HippieStation\hippiestation.dmm"
		#include "map_files\Beat!Box\Beat!Box.dmm"
		#include "map_files\Beat!Delta\Beat!Delta.dmm"
		#include "map_files\Beat!Donut\Beat!Donut.dmm"
		#include "map_files\Beat!Kilo\Beat!Kilo.dmm"
		#include "map_files\Beat!Meta\Beat!Meta.dmm"
		#include "map_files\Beat!Pubby\Beat!Pubby.dmm"
		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
