A silly thing I'm playing with.  Not something the general public should look at unless you want a laugh at the horrible coder.

# Things

I hope you have a USB Xbox 360 controller or use QWERTY.  Keyboard controls are WASD, which is a stretch for Colemak users and I don't even know where Dvorak puts those.

## backend

A weird thing I did whereby I try to hide anything platform-dependent in the 'backend' module, which has per-platform implementations.  Currently the only implementation is 'backendjs', which is for HTML5 browsers.

## Entity system

I also wanted to play with entity systems, and it's looking a bit convoluted so far.  Components are in the 'components' subdir and Systems in 'systems'.  Entities are just lists of components.  This probably would be much too slow for a real game but how many entities am I really going to have?

Entities are also divided into one set of 'actors' that move around the maze, and one set of 'map elements' like dots and walls.

## next steps

Next big problem is how to do collision detection in an entity system.  To do it 'right' we really should account for cases where the player has moved a long distance in a single frame and might have skipped over a dot, but unless we incorporate the collision detection into the player movement system, we'll have to communicate the player's movement to the collision system somehow.  Maybe the MovesInMaze component or the (not yet existing) Collides component should have fields for recording the previous position?

Could probably fake it by looking at the player's facing direction and position and inferring whether they've crossed a dot this frame, assuming the player never moves more than half a square in one frame.  We might enforce that anyway by capping the dt for each frame at .6 or something, ie. if frame rate drops below 10fps the action slows down.
