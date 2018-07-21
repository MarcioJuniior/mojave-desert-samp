#if defined _border_control_included
    #endinput
#endif
#define _border_control_included

#include <YSI-4.0.2\YSI\y_hooks>

#define PK_TIME_WHEN_OUT_OF_BOUNDARIES 45000

static const Float: worldLimits[] = {
    -3000.00, 3000.00,    // Bayside
     3000.00, 3000.00,    // Top-right Las Venturas
     3000.00,    370.00,    // Palomino
     -700.00,    370.00     // San Fierro Airport
};

static DynamicArea: worldBoundariesArea;

hook OnGameModeInit() {
    worldBoundariesArea = CreateDynamicPolygon(worldLimits);
}

stock bool:IsPlayerWithinWorldBoundaries(playerid) {
    return IsPlayerInDynamicArea(playerid, worldBoundariesArea);
}

hook OnPlayerEnterDynamicArea(playerid, DynamicArea: areaid) {
    if (areaid == worldBoundariesArea) {
        KillTimer(GetPVarInt(playerid, "outOfBoundariesTimer"));
        DeletePVar(playerid, "outOfBoundariesTimer");
    }
}

hook OnPlayerLeaveDynamicArea(playerid, DynamicArea: areaid) {
    if (areaid == worldBoundariesArea) {
        new timerId = SetTimerEx("OnLongStayedOutOfBoundaries", PK_TIME_WHEN_OUT_OF_BOUNDARIES, 0, "d", playerid);
        SetPVarInt(playerid, "outOfBoundariesTimer", timerId);

        SendClientMessage(playerid, 0xFF0000FF, "Você está deixando a área de Roleplay. Você possui 45 segundos para retornar à região de Mojave Desert.");
    }
}

forward OnLongStayedOutOfBoundaries(playerid);
public OnLongStayedOutOfBoundaries(playerid) {
    SetPlayerHealth(playerid, 0.00);
    return 1;
}