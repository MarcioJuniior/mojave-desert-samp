#if defined _dehydration_included
  #endinput
#endif
#define _dehydration_included

#include <YSI-4.0.2\YSI\y_hooks>

#include "mojave-desert/physical-needs/urban-zones.p"

#define COLOR_DEHYDRATION (0xDADBBDFF)

#define BASE_DEHYDRATION (0.75)
#define DEHYDRATION_UPDATE_INTERVAL (120000)
#define MINIMUM_TEMPERATURE_DEHYDRATION (25.0)

enum E_DEHYDRATION_DATA {
    PlayerBar: dehydrationProgressBar,
    Float: dehydrationLevel
};

static PlayerDehydration[MAX_PLAYERS][E_DEHYDRATION_DATA];

static CreatePlayerDehydrationBar(playerid) {
    PlayerDehydration[playerid][dehydrationProgressBar] = CreatePlayerProgressBar(playerid, 580, 200, 42.0, 1.7, COLOR_DEHYDRATION);
}

static ShowPlayerDehydrationBar(playerid) {
    ShowPlayerProgressBar(playerid, PlayerDehydration[playerid][dehydrationProgressBar]);
}

static SetPlayerDehydration(playerid, Float: amount) {
    PlayerDehydration[playerid][dehydrationLevel] = amount;
    SetPlayerProgressBarValue(playerid, PlayerDehydration[playerid][dehydrationProgressBar], amount);
}

static Float: DehydrationDelta(playerid) {
    static 
        Float: currentTemperature,
        Float: dehydration,
        Float: distance,
        Float: distanceBonus,
        Float: temperatureBonus,
        Float: urbanZoneDebuf;

    currentTemperature = GetCurrentTemperature();
    distance = ClosestUrbanZoneDistance(playerid);

    urbanZoneDebuf = IsPlayerInAnyUrbanZone(playerid) ? 0.3 : 1.0;
    distanceBonus = IsPlayerInAnyUrbanZone(playerid) ? 1.0 : 1.0 + floatdiv(distance, 1000.0);
    temperatureBonus = 
        currentTemperature >= MINIMUM_TEMPERATURE_DEHYDRATION 
            ? floatdiv(floatpower((currentTemperature - MINIMUM_TEMPERATURE_DEHYDRATION), 3), 1000)
            : 1.0;

    dehydration = BASE_DEHYDRATION * urbanZoneDebuf * distanceBonus * temperatureBonus;

    return dehydration;
}

hook OnPlayerConnect(playerid) {
    CreatePlayerDehydrationBar(playerid);

    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {
    PlayerDehydration[playerid][dehydrationProgressBar] = PlayerBar: 0;
    PlayerDehydration[playerid][dehydrationLevel] = 0;

    return 1;
}

hook OnPlayerSpawn(playerid) {
    KillTimer(GetPVarInt(playerid, "DehydrationTimer"));
    new timerId = SetTimerEx("OnDehydrationTick", DEHYDRATION_UPDATE_INTERVAL, true, "d", playerid);
    SetPVarInt(playerid, "DehydrationTimer", timerId);

    SetPlayerDehydration(playerid, PlayerDehydration[playerid][dehydrationLevel]);
    ShowPlayerDehydrationBar(playerid);

    return 1;
}

forward OnDehydrationTick(playerid);
public OnDehydrationTick(playerid) {
    SetPlayerDehydration(playerid, PlayerDehydration[playerid][dehydrationLevel] + DehydrationDelta(playerid));

    return 1;
}