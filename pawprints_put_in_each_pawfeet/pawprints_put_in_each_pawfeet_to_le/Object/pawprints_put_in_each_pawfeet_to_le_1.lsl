// :CATEGORY:PawPrints
// :NAME:pawprints_put_in_each_pawfeet
// :AUTHOR:Ama Omega
// :CREATED:2010-01-10 05:20:56.000
// :EDITED:2013-09-18 15:38:59
// :ID:617
// :NUM:841
// :REV:1.0
// :WORLD:Second Life
// :DESCRIPTION:
// pawprints (put in each pawfeet to leave prints behind) 1.lsl
// :CODE:

// Particle Script 0.3
// Created by Ama Omega
// 10-10-2003

// Mask Flags - set to TRUE to enable
integer glow = TRUE;            // Make the particles glow
integer bounce = FALSE;          // Make particles bounce on Z plan of object
integer interpColor = TRUE;     // Go from start to end color
integer interpSize = FALSE;      // Go from start to end size
integer wind = FALSE;           // Particles effected by wind
integer followSource = FALSE;    // Particles follow the source
integer followVel = FALSE;       // Particles turn to velocity direction

// Choose a pattern from the following:
// PSYS_SRC_PATTERN_EXPLODE
// PSYS_SRC_PATTERN_DROP
// PSYS_SRC_PATTERN_ANGLE_CONE_EMPTY
// PSYS_SRC_PATTERN_ANGLE_CONE
// PSYS_SRC_PATTERN_ANGLE
integer pattern = PSYS_SRC_PATTERN_DROP;

// Select a target for particles to go towards
// "" for no target, "owner" will follow object owner 
//    and "self" will target this object
//    or put the key of an object for particles to go to
key target = "";

// Particle paramaters
float age = 133;                  // Life of each particle
float maxSpeed = .1;            // Max speed each particle is spit out at
float minSpeed = .1;            // Min speed each particle is spit out at
string texture = "0561aa38-6fde-1fdb-3b78-1bf07dd0a176";                 // Texture used for particles, default used if blank
float startAlpha = 1.0;           // Start alpha (transparency) value
float endAlpha = 0.0;           // End alpha (transparency) value
vector startColor = <0,0,0>;    // Start color of particles <R,G,B>
vector endColor = <0,0,0>;      // End color of particles <R,G,B> (if interpColor == TRUE)
vector startSize = <.4,.2,.7>;     // Start size of particles 
vector endSize = <.4,.4,.7>;       // End size of particles (if interpSize == TRUE)
vector push = <0,0,0.0>;          // Force pushed on particles

// System paramaters
float rate = .5;            // How fast (rate) to emit particles
float radius = .1;          // Radius to emit particles for BURST pattern
integer count = 1;        // How many particles to emit per BURST 
float outerAngle = 1.54;    // Outer angle for all ANGLE patterns
float innerAngle = 1.55;    // Inner angle for all ANGLE patterns
vector omega = <0,0,10>;    // Rotation of ANGLE patterns around the source
float life = 0;             // Life in seconds for the system to make particles

// Script variables
integer flags;

updateParticles()
{
    flags = 0;
    if (target == "owner") target = llGetOwner();
    if (target == "self") target = llGetKey();
    if (glow) flags = flags | PSYS_PART_EMISSIVE_MASK;
    if (bounce) flags = flags | PSYS_PART_BOUNCE_MASK;
    if (interpColor) flags = flags | PSYS_PART_INTERP_COLOR_MASK;
    if (interpSize) flags = flags | PSYS_PART_INTERP_SCALE_MASK;
    if (wind) flags = flags | PSYS_PART_WIND_MASK;
    if (followSource) flags = flags | PSYS_PART_FOLLOW_SRC_MASK;
    if (followVel) flags = flags | PSYS_PART_FOLLOW_VELOCITY_MASK;
    if (target != "") flags = flags | PSYS_PART_TARGET_POS_MASK;

    llParticleSystem([  PSYS_PART_MAX_AGE,age,
                        PSYS_PART_FLAGS,flags,
                        PSYS_PART_START_COLOR, startColor,
                        PSYS_PART_END_COLOR, endColor,
                        PSYS_PART_START_SCALE,startSize,
                        PSYS_PART_END_SCALE,endSize, 
                        PSYS_SRC_PATTERN, pattern,
                        PSYS_SRC_BURST_RATE,rate,
                        PSYS_SRC_ACCEL, push,
                        PSYS_SRC_BURST_PART_COUNT,count,
                        PSYS_SRC_BURST_RADIUS,radius,
                        PSYS_SRC_BURST_SPEED_MIN,minSpeed,
                        PSYS_SRC_BURST_SPEED_MAX,maxSpeed,
                        PSYS_SRC_TARGET_KEY,target,
                        PSYS_SRC_INNERANGLE,innerAngle, 
                        PSYS_SRC_OUTERANGLE,outerAngle,
                        PSYS_SRC_OMEGA, omega,
                        PSYS_SRC_MAX_AGE, life,
                        PSYS_SRC_TEXTURE, texture,
                        PSYS_PART_START_ALPHA, startAlpha,
                        PSYS_PART_END_ALPHA, endAlpha
                            ]);
}

default
{
    state_entry()
    {
        updateParticles();
        llSetTimerEvent(.3);
    }

    timer()
    {
        string anim = llGetAnimation(llGetOwner());
        if ((anim == "Walking") || (anim == "Running") || (anim == "Turning Left") || (anim == "Turning Right") || (anim == "CrouchWalking"))
        {
            updateParticles();
        }
        else
        {
            llParticleSystem([]);
        }
    }
}// END //
