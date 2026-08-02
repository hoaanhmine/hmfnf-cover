import flixel.FlxText;

var camZoomLock:Bool = false;

var weirdzoom:Bool = true;

var lyric:FlxAnimate;
var blackScreen:FlxSprite;
var fogGrp:Array<FlxSprite> = [];

var offsetX:Float = 0;
var offsetY:Float = 0;
var animOffsetValue:Float = 20.0;

function onCreatePost(){
    comboGroup.visible = false;
}

function onSongStart(){
    
}
function onSpawnNote(dunceNote){
	if(dunceNote.mustPress != true){
        FlxTween.num(0.5, 1.6, 1.8, {ease: FlxEase.quartIn, onUpdate:(t) -> {
                dunceNote.multSpeed = t.value;
            }
        });
    }
}
//quartTween,quintTween,cubeTween is good

function onUpdate(elapsed){
    
}

function onEvent(eventName, value1, value2){
    if (eventName == '') {
        if (value1 == 'hurt') {
            if (game.health > 0.5) {
                game.health -= 0.05;
            }
        }
    }

    
}


