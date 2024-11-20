import flixel.util.FlxStringUtil;

function onUpdatePost(delta) {
    var curTime:Float = Math.max(0,Conductor.songPosition - ClientPrefs.data.noteOffset);
    var songCalc:Float = (game.songLength - curTime) / game.playbackRate;
    if (ClientPrefs.data.timeBarType == 'Time Elapsed') songCalc = curTime;
    else if (ClientPrefs.data.timeBarType != 'Song Name') {
        var secondsTotal:Int = Math.floor(songCalc/1000);
        if(secondsTotal < 0) secondsTotal = 0;
        game.timeTxt.text = FlxStringUtil.formatTime(secondsTotal,false);
    }
    return;
}