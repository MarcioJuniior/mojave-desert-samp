#if defined _urban_zones_included
  #endinput
#endif
#define _urban_zones_included

#include <YSI-4.0.2\YSI\y_hooks>

enum E_URBAN_ZONES {
    DynamicArea: urbanAreaId,
    Float: urbanMinX,
    Float: urbanMinY,
    Float: urbanMaxX,
    Float: urbanMaxY
}

static const Float: urbanZones[][E_URBAN_ZONES] = {
    { DynamicArea: INVALID_STREAMER_ID, -1648.0, 2501.0, -1356.0, 2740.0 }, // El Quebrados
    { DynamicArea: INVALID_STREAMER_ID, -923.0, 1393.0, -612.0, 1642.0 },   // Las Barrancas
    { DynamicArea: INVALID_STREAMER_ID, -422.0, 836.0, 195.0, 1243.0 },     // Fort Carson
    { DynamicArea: INVALID_STREAMER_ID, -383.0, 2587.0, -113.0, 2826.0 }    // Las Payasdas
};

static CreateUrbanZoneAreas() {
    for (new i = 0; i < sizeof(urbanZones); i++)
        urbanZones[i][urbanAreaId] = CreateDynamicRectangle(urbanZones[i][urbanMinX], urbanZones[i][urbanMinY], urbanZones[i][urbanMaxX], urbanZones[i][urbanMaxY]);
}

bool: IsPlayerInAnyUrbanZone(playerid) {
    for (new i = 0; i < sizeof(urbanZones); i++)
        if (IsPlayerInDynamicArea(playerid, urbanZones[i][urbanAreaId], true))
            return true;

    return false;
}

Float: ClosestUrbanZoneDistance(playerid) {
    new 
        Float: currentDistance,
        Float: dummyVar,
        Float: lesser = 99999.0,
        Float: playerZ;

    GetPlayerPos(playerid, dummyVar, dummyVar, playerZ);

    for (new i = 0; i < sizeof(urbanZones); i++) {
        new 
            Float: x, 
            Float: y;

        x = floatdiv(urbanZones[i][urbanMinX] + urbanZones[i][urbanMaxX], 2.0);
        y = floatdiv(urbanZones[i][urbanMinY] + urbanZones[i][urbanMaxY], 2.0);

        currentDistance = GetPlayerDistanceFromPoint(playerid, x, y, playerZ);

        if (currentDistance < lesser)
            lesser = currentDistance;
    }


    return lesser;
}

hook OnGameModeInit() {
    CreateUrbanZoneAreas();
}