#if defined _clock_included
  #endinput
#endif
#define _clock_included

#include <YSI-4.0.2\YSI\y_hooks>

static 
    currentHour,
    currentMinute,
    currentDay;

hook OnGameModeInit() {
    SetTimer("OnClockTicks", 10000, true);
}

forward OnClockTicks();
public OnClockTicks() {
    static
        hours, minutes, seconds,
        day,   month,   year;

    gettime(hours, minutes, seconds);
    getdate(year, month, day);

    // Minute Update
    if (minutes != currentMinute) {
        CallRemoteFunction("OnMinuteUpdate", "");
        currentMinute = minutes;
    }

    // Hour Update
    if (hours != currentHour) {
        CallRemoteFunction("OnHourUpdate", "");
        currentHour = hours;
    }

    // Day Update
    if (day != currentDay) {
        CallRemoteFunction("OnDayUpdate", "");
        currentDay = day;
    }

    return 1;
}