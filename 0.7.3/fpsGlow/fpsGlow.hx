// took the inital code from vortex5694 on Pysch Discord. -fp

// All the glow animations were added to the default skins instead of being seperate
// images and moved to mods/images/noteSkins, so that's cool.

import objects.Note; 

function onCreatePost(){
    for (note in game.unspawnNotes){
        // note.frames.addAtlas(Paths.getAtlas("NOTE_glow")); // would be nessecary if seperate image, but built in now.
        note.animation.addByPrefix("glow", Note.colArray[note.noteData % Note.colArray.length] + " glow", 24, true);
    }
}

function onUpdate(elapsed:Float){
    for (note in game.notes){
        if (note.canBeHit && !note.isSustainNote){
            note.animation.play("glow");
        }
    }
}