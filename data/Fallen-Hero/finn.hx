var x_position:Int = 2250;
var y_position:Int = 1020;

game.initLuaShader('NewGlitch2');

var jake;
function onCreatePost(){
	//debugPrint(Sys.systemName());
    jake = new Character(x_position, y_position, 'hoacamkiem');
    setVar('jake',jake);
	jake.visible = true;
    jake.alpha = 1.0;
    addBehindDad(jake);
	return;
}

function onSongStart(){
	game.callOnLuas('addCharacterGlitch', ['jake']);
}

var extraCharGlitchIntensity:Float = 1000.0;

function opponentNoteHit(type){
    if (type.noteType == 'Second Char Sing' || type.noteType == 'Both Char Sing' || type.noteType == 'Second Char Glitch'){
        jake.playAnim(game.singAnimations[type.noteData], true);
        jake.holdTimer = 0;
    }

	//new FlxTimer().start(0.1, ()->{ debugPrint('done'); });

	if (type.noteType == 'Second Char Glitch'){
		game.callOnLuas('glitchCharacters', ['jake', true, type.isSustainNote]);
		/*var jakeGlitch = game.createRuntimeShader('NewGlitch2');
		jake.shader = jakeGlitch;

		if (type.isSustainNote) {
        	extraCharGlitchIntensity = -0.5; 
		}else{
        	extraCharGlitchIntensity = FlxG.random.float(-0.6,-0.4);
    	}


        jakeGlitch.setFloat('binaryIntensity', extraCharGlitchIntensity);

        if (FlxG.random.int(1,2) == 1){
            jakeGlitch.setFloat('negativity', 2.0);
		}else{
            jakeGlitch.setFloat('negativity',-10.0);
        }

		new FlxTimer().start(0.12,function(tmr:FlxTimer){
		   jakeGlitch.setFloat('binaryIntensity', 1000.0);
	   });

	   new FlxTimer().start(0.1,function(tmr:FlxTimer){
		   jakeGlitch.setFloat('negativity', 0.0);
	   });*/

	}
}

    