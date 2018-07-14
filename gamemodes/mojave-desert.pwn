#include <a_samp>

// Plugins dependencies
#define STREAMER_ENABLE_TAGS
#include <streamer-2.9.3/streamer>

// Modules
#include "mojave-desert/border-control/border-control.p"

main() {
  print("----------------------------------");
  print("--    Mojave Desert Roleplay    --");
  print("----------------------------------");
}

public OnPlayerSpawn(playerid) {

  return 1;
}

public OnPlayerRequestClass(playerid) {
  CreateVehicle(411, 0, 600, 20, 0, 0, 0, 0, 0);
  SetSpawnInfo(playerid, 0, 98, 0, 600, 20, 0, 0, 0, 0, 0, 0, 0);
  SpawnPlayer(playerid);

  return 1;
}