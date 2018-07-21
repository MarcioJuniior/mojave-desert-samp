#include <a_samp>

// Plugins dependencies
#define STREAMER_ENABLE_TAGS
#include <streamer-2.9.3/streamer>

// Libs
#include <YSI-4.0.2\YSI\y_iterate>
#include <YSI-4.0.2\YSI\y_commands>
#include <easyDialog>
#include <progressbar2>

// Utils
#include "mojave-desert/clock.p"
#include "mojave-desert/messages.p"

// Modules
#include "mojave-desert/border-control.p"
#include "mojave-desert/weather.p"
#include "mojave-desert/factions.p"
#include "mojave-desert/physical-needs.p"

main() {
  print("----------------------------------");
  print("--    Mojave Desert Roleplay    --");
  print("----------------------------------");
}

public OnGameModeInit() {
  DisableInteriorEnterExits();
  EnableStuntBonusForAll(false);
  ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
  SetNameTagDrawDistance(5.0);

  return 1;
}

public OnPlayerSpawn(playerid) {

  return 1;
}

public OnPlayerRequestClass(playerid) {
  CreateVehicle(411, 0, 600, 20, -5, 0, 0, 0, 0);
  SetSpawnInfo(playerid, 0, 98, 0, 600, 20, 0, 0, 0, 0, 0, 0, 0);
  SpawnPlayer(playerid);

  return 1;
}

public e_COMMAND_ERRORS: OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS: success) {
    switch (success) {
        case COMMAND_UNDEFINED: {
            SendErrorMessage(playerid, "Comando inexistente.");
        }
    }

    return COMMAND_OK;
}

YCMD:gmx(playerid, params[], help) {
    SendRconCommand("gmx");
    return 1;
}