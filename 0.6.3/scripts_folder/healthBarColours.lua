local dadColour = "XXXXXX";

function onCreatePost()
    if dadName == "pyro" or dadName == "Zackery" then
        dadColour = "00FFFF"
    elseif dadName == "pico" or dadName == "nqa" then
        dadColour = "FF0000"
    elseif dadName == "Ash" then
        dadColour = "00FF00"
    else
        dadColour = "AAAAAA"
    end
    letsStretchOurLegs();
end
function onSectionHit()
    letsStretchOurLegs();
end
function letsStretchOurLegs()
    if mustHitSection == true then
        setTextColor('botplayTxt', "0000FF");
        setTextColor('scoreTxt', "0000FF");
    elseif gfSection == true then
        setTextColor('botplayTxt', "AA00AA");
        setTextColor('scoreTxt', "FF00FF");
    else
        setTextColor('botplayTxt', dadColour);
        setTextColor('scoreTxt', dadColour);
    end

end
