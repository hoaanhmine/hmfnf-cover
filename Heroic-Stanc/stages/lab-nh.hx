import objects.BGSprite;

var noHeroIntro:BGSprite;

function onCreatePost()
{
    noHeroIntro = new BGSprite('noherocutscenefirst', -200, -400, 1.2, 1.2, ['play'], false);
    noHeroIntro.animation.addByPrefix('finnJumpscareMomento', 'play', 24, false);
    noHeroIntro.antialiasing = ClientPrefs.data.antialiasing;
    noHeroIntro.animation.play('finnJumpscareMomento');
    noHeroIntro.scale.set(1.05,1.05);
    noHeroIntro.cameras = [camOther];
    noHeroIntro.visible = false;
    add(noHeroIntro);

    camHUD.alpha = 0;
    camGame.alpha = 0;
}

function onStepHit()
{
    if (curStep == 1)
    {
        noHeroIntro.visible = true;
        noHeroIntro.animation.play('finnJumpscareMomento');
    }

    if (curStep == 32)
    {
        noHeroIntro.visible = false;
        camHUD.alpha = 1;
        camGame.alpha = 1;
        game.camGame.flash(FlxColor.WHITE,1);

    }

}