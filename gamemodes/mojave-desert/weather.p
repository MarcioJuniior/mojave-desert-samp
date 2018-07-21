#if defined _weather_included
  #endinput
#endif
#define _weather_included

#include <YSI-4.0.2\YSI\y_hooks>

static 
    Float: currentTemperature;

static const Float: temperatureReferences[12][] = {
    {  7.0, 16.0},
    {  8.0, 17.0},
    {  9.0, 20.0},
    { 12.0, 24.0},
    { 17.0, 29.0},
    { 22.0, 35.0},
    { 26.0, 38.0},
    { 24.0, 36.0},
    { 21.0, 33.0},
    { 16.0, 27.0},
    { 10.0, 20.0},
    {  7.0, 16.0}
};

Float: GetCurrentTemperature() {
    return currentTemperature;
}

static UpdateCurrentTemperature(minute, hour, month) {
    static
        Float: minReferenceTemperature, 
        Float: maxReferenceTemperature, 
        Float: newTemperature;

    minReferenceTemperature = temperatureReferences[month - 1][0];
    maxReferenceTemperature = temperatureReferences[month - 1][1];

    newTemperature = minReferenceTemperature + maxReferenceTemperature * 
        floatsin(
            floatmul(7.5, (hour + floatdiv(minute, 60.0))), 
            degrees
        );

    SetCurrentTemperature(newTemperature);
}

static SetCurrentTemperature(Float: temperature) {
    currentTemperature = temperature;
}

hook OnGameModeInit() {
    new second, minute, hour, day, month, year;

    gettime(hour, minute, second);
    getdate(year, month, day);

    UpdateCurrentTemperature(minute, hour, month);

    return 1;
}

hook OnMinuteUpdate() {
    static second, minute, hour, day, month, year;

    gettime(hour, minute, second);
    getdate(year, month, day);

    UpdateCurrentTemperature(minute, hour, month);

    return 1;
}