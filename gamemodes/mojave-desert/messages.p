#if defined _messages_included
  #endinput
#endif
#define _messages_included

#define COLOR_ERROR 0xFF683BFF

#define SendServerMessage(%0,%1) \
    SendClientMessageEx(%0, 0x1E90FFFF, "[ATENÇÃO]: {FFFFFF}"%1)

#define SendSyntaxMessage(%0,%1) \
    SendClientMessageEx(%0, 0x1E90FFFF, "[MODO DE USO]: {FFFFFF}"%1)

#define SendErrorMessage(%0,%1) \
    SendClientMessageEx(%0, COLOR_ERROR, "[ERRO]: {FFFFFF}"%1)

#define SendAdminAction(%0,%1) \
    SendClientMessageEx(%0, 0x1E90FFFF, "[ADMIN]: {FFFFFF}"%1)


stock SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
    static
        args,
        str[144];

    /*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
    */
    if ((args = numargs()) == 3)
    {
        SendClientMessage(playerid, color, text);
    }
    else
    {
        while (--args >= 3)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit PUSH.S 8
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessage(playerid, color, str);

        #emit RETN
    }
    return 1;
}

stock SendClientMessageToAllEx(color, const text[], {Float, _}:...)
{
    static
        args,
        str[144];

    /*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
    */
    if ((args = numargs()) == 2)
    {
        SendClientMessageToAll(color, text);
    }
    else
    {
        while (--args >= 2)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit LOAD.S.pri 8
        #emit ADD.C 4
        #emit PUSH.pri
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessageToAll(color, str);

        #emit RETN
    }
    return 1;
}