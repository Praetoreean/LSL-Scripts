// :CATEGORY:Jewelry
// :NAME:Necklace_Generator
// :AUTHOR:Ariane Brodie
// :CREATED:2010-01-10 05:20:56.000
// :EDITED:2013-09-18 15:38:58
// :ID:552
// :NUM:755
// :REV:1.0
// :WORLD:Second Life
// :DESCRIPTION:
// If you put the link script in, then linked all the chain links together then edit, replace the link script with this chain script.
// :CODE:
//typing /1 gold turns necklace gold
//typing /1 silver turns necklace silver
//typing /1 glow turns on full bright with any color (best at night)
//typing /1 hideneck makes the necklace disappear, but you still wear it.

default
{
    state_entry()
    {
        llListen(1, "", llGetOwner(), "");
    }

    listen(integer channel, string name, key id, string message)
    {
        llMessageLinked(LINK_ALL_OTHERS, 0, message, NULL_KEY);
    }
        
    link_message(integer channel, integer sender, string message, key id)        {

        if (message == "gold")
            llSetPrimitiveParams([
            PRIM_COLOR, ALL_SIDES, <0.9, 0.9, 0.5>, 1.0,
            PRIM_FULLBRIGHT, ALL_SIDES, FALSE]);
            
        if (message == "silver")
            llSetPrimitiveParams([
            PRIM_COLOR, ALL_SIDES, <0.95, 0.95, 0.95>, 1.0,
            PRIM_FULLBRIGHT, ALL_SIDES, FALSE]);
            
        if (message == "glow")
            llSetPrimitiveParams([
            PRIM_FULLBRIGHT, ALL_SIDES, TRUE]);

        if (message == "hideneck")
            llSetPrimitiveParams([
            PRIM_COLOR, ALL_SIDES, <1,1,1>, 0.0,
            PRIM_FULLBRIGHT, ALL_SIDES, FALSE]);
    }
}
