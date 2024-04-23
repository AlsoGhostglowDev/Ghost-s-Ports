local intensity = {0, 0}
local intensityMax = {0.0083, 0.008}

setVar('noShake', false)

local sustain = true
local hittingNote = false

function opponentNoteHit(_, _, t, s)
    if t == 'Shaking Note' then
        sustain = s
        hittingNote = true
        runTimer('nothitnote', stepCrochet/1000)

        for _, v in ipairs(intensity) do
            intensity[_] = v + intensityMax[_] / 8, intensityMax[_]
            if v > intensityMax[_] then intensity[_] = intensityMax[_] end
        end
    end
end

function onUpdatePost(elapsed)
    if not hittingNote then
        for _, v in ipairs(intensity) do
            if v > 0 then
                intensity[_] = v - intensityMax[_] / (64 / (elapsed*100)), intensityMax[_]
            end
            if v < 0 then intensity[_] = 0 end
        end 
    end

    if not getVar('noShake') then
        cameraShake("camGame", sustain and (mustHitSection and intensity[1]/1.5 or intensity[1]) or (hittingNote and (mustHitSection and intensityMax[1]/1.5 or intensityMax[1]) or 0), 0.2)
        cameraShake("camHUD",  sustain and (mustHitSection and intensity[2]/1.5 or intensity[2]) or (hittingNote and (mustHitSection and intensityMax[2]/1.5 or intensityMax[2]) or 0), 0.2)
    end
end

function onTimerCompleted(t)
    if t == 'nothitnote' then
        hittingNote = false
    end
end