#include <a_samp>			// Main include
#include <zcmd>				// For test with cmds
#include <streamer>			// Objects for lines
#include <colandreas>		// Collision detector
#include <ca_debug>			// Our include


// Vars for this example
new Float:castart[3], Float:caend[3];

// Example declaration for ColAndreas debug line
new myLine;

// Start cords for test
CMD:start(playerid, arg[])
{
	GetPlayerPos(playerid, castart[0], castart[1], castart[2]);
	return 1;
}

// From start to end without collision
CMD:end(playerid, arg[])
{
	GetPlayerPos(playerid, caend[0], caend[1], caend[2]);

	new Float:unused;
	CA_RayCastLine(castart[0], castart[1], castart[2], caend[0], caend[1], caend[2], unused, unused, unused);

	myLine = CA_DebugDrawLine(
		castart[0], castart[1], castart[2], 			// start
		caend[0], caend[1], caend[2], 					// end
		false, 											// stop when CA find collision ?
		0xFF31B50D 										// color (default 0xFFFF0000 [red]) ARGB
	);
	return 1;
}

// Show where collision is
CMD:end2(playerid, arg[])
{
	GetPlayerPos(playerid, caend[0], caend[1], caend[2]);

	new Float:unused;
	CA_RayCastLine(castart[0], castart[1], castart[2], caend[0], caend[1], caend[2], unused, unused, unused);

	myLine = CA_DebugDrawLine(
		castart[0], castart[1], castart[2], 			// start
		caend[0], caend[1], caend[2], 					// end
		true 											// stop when CA find collision ?
														// no color? default red
	);
	return 1;
}

// Remove last line
CMD:remove(playerid, arg[])
{
	CA_DestroyDebugDrawLine(myLine);
	return 1;
}

// Remove all created lines
CMD:removeall(playerid, arg[])
{
	for (new i = 0; i < MAX_RAYCAST_DEBUG; i++)
	{
		if (IsValidDebugDrawLine(i))
			CA_DestroyDebugDrawLine(i);
	}
	return 1;
}