function onStepHit()
    if curStep == 120 then
        doTweenZoom('zoomin', 'camGame', 0.8, crochet/500, 'expoIn')
    end
    if curStep == 128 then
        cameraFlash('camGame', 'FFFFFF', 1)
        setVar('camSpeed', 2)
        --doTweenZoom('zoomin', 'camGame', 0.5, 1, 'expoOut')
    end
end