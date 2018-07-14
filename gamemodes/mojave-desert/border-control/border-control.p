#if defined _border_control_included
  #endinput
#endif
#define _border_control_included

#include <YSI-4.0.2\YSI\y_hooks>

static const Float: worldLimits[] = {
  -3000.00, 3000.00,  // Bayside
   3000.00, 3000.00,  // Top-right Las Venturas
   3000.00,  370.00,  // Palomino
   -700.00,  370.00   // San Fierro Airport
};

static DynamicArea: worldBoundariesArea;

hook OnGameModeInit() {
  worldBoundariesArea = CreateDynamicPolygon(worldLimits);
}

stock bool:IsPlayerWithinWorldBoundaries(playerid) {
  return IsPlayerInDynamicArea(playerid, worldBoundariesArea);
}

hook OnPlayerLeaveDynamicArea(playerid, DynamicArea: areaid) {
  if (areaid == worldBoundariesArea) {
    SendClientMessage(playerid, 0xFF0000FF, "Você está deixando a área de Roleplay. Retorne imediatamente para a região de Mojave Desert.");
  }
}