var originalOffsets:Array<Float>;
var offsetX:Float;
var offsetY:Float;

function onCreate() {
    originalOffsets = ClientPrefs.data.comboOffset.copy();
    for (i in 0...4) {
        ClientPrefs.data.comboOffset[i] = 0;
    }

    return;
}

function onCreatePost() {
    offsetX = -boyfriend.width - 100;
    offsetY = -boyfriend.height + 100;

    setVar('comboOffsetX', offsetX); // example setVar("comboOffsetX", 0);
    setVar('comboOffsetY', offsetY); // example setVar("comboOffsetY", 0);
    return;
}

function onUpdate() {
    comboGroup.cameras = [camGame];
    
    comboGroup.x = boyfriend.x + getVar('comboOffsetX');
    comboGroup.y = boyfriend.y + getVar('comboOffsetY');
    return;
}