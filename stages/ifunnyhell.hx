import backend.ClientPrefs;
import backend.Conductor;
import backend.CoolUtil;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxTimer;

var ifunny;
var ifuPillar;
var brimstone;
var flycrowave;
var ifure;

var pillars = [];

var platform;

var antialias = true;
var root = '_crunchin/ifunnyhell';

var camBop = 4*4;

function onCreate() {
    Paths.image(root + '/farpillar-light');
    Paths.image(root + '/midpillar-light');
    Paths.image(root + '/closepillar-light');

    antialias = ClientPrefs.data.antialiasing;

    ifunny = new FlxSprite(-500, -700, Paths.image(root + '/abyss'));
    ifunny.antialiasing = antialias;
    setScale(ifunny, 2, 2);

    flycrowave = new FlxSprite().loadGraphic(Paths.image(root + '/flycrowave'));
    flycrowave.angularVelocity = 20;
    setScale(flycrowave, .5, .5);

    ifure = new FlxSprite(500, -300);
    setScale(ifure, 4, 4);
    ifure.frames = Paths.getSparrowAtlas(root + '/FLAMESFLAMESBURNINGFLAMES');
    ifure.animation.addByPrefix('idle', 'FlamesBurn', 24, true);
    ifure.animation.play('idle');
    ifure.alpha = 0.15;

    brimstone = new FlxSprite(-600, -700, Paths.image(root + '/brimstone'));
    setScale(brimstone, 2, 2);

    ifuPillar = new FlxBackdrop(Paths.image(root + '/darkpillar'), 0x10, 0, -30);
    ifuPillar.x += 400;
    ifuPillar.antialiasing = antialias;
    setScale(ifuPillar);

    game.addBehindGF(ifunny);
    game.addBehindGF(ifure);
    game.addBehindGF(brimstone);
    game.addBehindGF(flycrowave);
    game.addBehindGF(ifuPillar);

    for (i in 0...3) {
        var pillar = new FlxSprite(-200, 1500, Paths.image(root + ['/farpillar', '/midpillar', '/closepillar'][i]));
        setScale(pillar, 1, 1.1);
        pillar.scrollFactor.set((1 - (0.05 * i)), 0.8);
        game.addBehindGF(pillar);

        pillars.push(pillar);
    }
}

function onCreatePost() {
    platform = new FlxSprite((game.boyfriend.x + game.boyfriend.offset.x)-100, game.boyfriend.y + game.boyfriend.offset.y + 275).loadGraphic(Paths.image(root + '/legacy_platform'));
    game.addBehindDad(platform);
    
    //game.camGame.zoom = 0.15;
    //game.defaultCamZoom = 0.15;
}

function onStepHit() {
    switch(game.curStep) {
        case 128:
            camBop = 2*4;
            FlxTween.tween(pillars[0], {y: pillars[0].y - 2250}, 10);
            setVar('noShake', true);
            new FlxTimer().start(10, (_)->{setVar('noShake', false);});
            game.camGame.shake(0.0052, 10);
            game.camHUD.shake(0.002, 10);
        case 368: camBop = 4*4;
        case 448: camBop = 2*4;
        case 496: camBop = 4*4;
        case 528: camBop = 2*4;
        case 578: setVar('duet', true);
        case 608:
            setVar('duet', false);
            game.camHUD.flash(0xFFFFFFFF, 1);
            FlxTween.tween(pillars[1], {y: pillars[1].y - 2250}, 10);
            setVar('noShake', true);
            new FlxTimer().start(10, (_)->{setVar('noShake', false);});
            game.camGame.shake(0.0052, 10);
            game.camHUD.shake(0.002, 10);
        case 808: camBop = 4;
        case 856: camBop = 1;
        case 864: camBop = 4;
        case 928:
            camBop = 4*4;
            game.camHUD.flash(0xFFFFFFFF, 1);
            FlxTween.tween(pillars[2], {y: pillars[2].y - 2250}, 10);
            setVar('noShake', true);
            new FlxTimer().start(10, (_)->{setVar('noShake', false);});
            game.camGame.shake(0.0052, 10);
            game.camHUD.shake(0.002, 10);
        case 992: camBop = 2*4;
        case 1040: camBop = 2*4;
        case 1048: game.defaultCamZoom = 0.65; setVar('duet', true);
        case 1056: FlxTween.tween(game.opponentStrums.members[2], {y: ClientPrefs.data.downscroll ? -200 : (FlxG.height + 200)}, 1, {ease: FlxEase.expoOut}); camBop = 4*4;
        case 1060: FlxTween.tween(game.opponentStrums.members[1], {y: ClientPrefs.data.downscroll ? -200 : (FlxG.height + 200)}, 1, {ease: FlxEase.expoOut}); game.gf.visible = false; game.gfGroup.x -= 100; game.gfGroup.y += 210; 
        case 1064: FlxTween.tween(game.opponentStrums.members[0], {y: ClientPrefs.data.downscroll ? -200 : (FlxG.height + 200)}, 1, {ease: FlxEase.expoOut});
        case 1072: FlxTween.tween(game.opponentStrums.members[3], {y: ClientPrefs.data.downscroll ? -200 : (FlxG.height + 200)}, 1, {ease: FlxEase.expoOut});
        case 1104: 
            game.gf.visible = true; game.defaultCamZoom = 0.45;
            game.camHUD.flash(0xFFFFFFFF, 1);
            var i = -1;
            for (pillar in pillars) {
                i++;
                pillar.loadGraphic(Paths.image(root + ['/farpillar-light', '/midpillar-light', '/closepillar-light'][i]));
            }
        case 1232: camBop = 2*4;
        case 1296: camBop = 4;
        case 1424: camBop = 2; setVar('duet', false);
        case 1456: setVar('duet', true);
        case 1552: camBop = 4*4;
        case 1560: FlxTween.tween(game.camGame, {zoom: 1.05}, (Conductor.crochet/500), {ease: FlxEase.expoIn});
        case 1568: camBop = 4; setVar('duet', false); game.camHUD.flash(0xFFFFFFFF, 1);
        case 1664: camBop = 2*4;
        case 1696: camBop = 4*4;
        case 1760: setVar('duet', true);
        case 1792: camBop = 2*4;
        case 1824: setVar('duet', true);
        case 1856: setVar('duet', true);
        case 1888: setVar('duet', false);
        case 1952: camBop = 4;
        case 2032: camBop = 2;
        case 2048: camBop = 4; setVar('duet', true);
        case 2080: camBop = 2; setVar('duet', false); setVar('camSpeed', 3);
        case 2096: camBop = 2*4;
        case 2104: setVar('duet', true);
    }

    if (curStep % camBop == 0) {
        game.camGame.zoom += 0.023;
        game.camHUD.zoom += 0.023;
    }
}

function onBeatHit() {
    if ((game.curBeat % 2 == 0) && game.curStep >= 1104) {
        var i = -1;
        for (pillar in pillars) {
            i++;
            FlxTween.tween(pillar.scale, {x: 1.1, y: 1.2}, Conductor.crochet/2000, {startDelay: (Conductor.crochet/5000)*i, ease: FlxEase.expoIn, onComplete: (_) -> {
                FlxTween.tween(pillar.scale, {x: 1, y: 1.1}, Conductor.crochet/2000, {ease: FlxEase.expoOut});
            }, onUpdate: (_) -> {pillar.centerOffsets();}});
        }
    }
}

var time = 0;
var dumb:FlxTween;
var targPlayback:Float = 1;
var lmao = false;
function onUpdatePost(elapsed) {
    time += elapsed;
    brimstone.alpha = 0.75 + (Math.sin(time) * 0.25);

    flycrowave.x = 1300 + Math.sin(time*0.055) * 1700;
    flycrowave.y = Math.sin(time*0.15) * 250;

    if (lmao) {
        targPlayback = (FlxG.keys.pressed.SPACE) ? 3 : 1;
        if (dumb!=null) dumb.cancel();
        dumb = FlxTween.num(game.playbackRate, targPlayback, 0.05, {ease: FlxEase.cubeInOut}, (num)->{game.playbackRate = CoolUtil.floorDecimal(num, 2);});

        debugPrint(game.playbackRate);
    }

    if (game.curStep >= 1104)
        game.defaultCamZoom = (gfSection || getVar('duet')) ? 0.475 : (mustHitSection ? 0.535 : 0.5);

    return;
}

function setScale(object:FlxObject, ?x:Float, ?y:Float) {
    object.scale.set(x ?? 1, y ?? 1);
    object.updateHitbox();
}