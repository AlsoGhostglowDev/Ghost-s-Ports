function onCreatePost()
    makeLuaSprite('c', '_crunchin/legacy', 0, 190*0.667) 
    scaleObject('c', 0.667, 0.675)
    setObjectCamera('c', 'hud') 
    addLuaSprite('c', true)

    makeLuaSprite('o') makeGraphic('o', 1, 1, '000000') 
    scaleObject('o', screenWidth, screenHeight)
    setObjectCamera('o', 'hud') 
    addLuaSprite('o', true)
end

function onSongStart()
    setProperty('defaultCamZoom', 0.6)
    doTweenZoom('z', 'camGame', 0.5, 3, 'smootherStepInOut')
    doTweenAlpha('y', 'o', 0, 6, 'smootherStepInOut')

    runTimer('c', 2)
end

function onTweenCompleted(t)
    if t == 'z' then setProperty('defaultCamZoom', 0.5) end
    if t == 'y' then removeLuaSprite('o') end
    if t == 'k' then removeLuaSprite('c') end
end

function onTimerCompleted(t)
    if t == 'c' then doTweenY('a', 'c', -8, 3, 'cubeOut') ; runTimer('b', 4) end
    if t == 'b' then doTweenY('k', 'c', 190*0.667, 3, 'cubeIn')end
end

function onStepHit()
    if curStep == 120 then
        doTweenZoom('zoomin', 'camGame', 0.8, crochet/500, 'expoIn')
    end
    if curStep == 128 then
        cameraFlash('camGame', 'FFFFFF', 1)
        setVar('camSpeed', 2)
    end
end