luaDebugMode = true

-- edit this
setVar('followenabled', true)
setVar('duet', false)
setVar('camSpeed', 1.5)

local offset = 30

local function getCamPos(char)
    local _char = char

    if char == 'girlfriend' then char = 'gf' end
    if char == 'bf' then char = 'boyfriend' end

    if char == 'gf' then _char = 'girlfriend' end
    if char == 'dad' then _char = 'opponent' end

    return {
        x = (getMidpointX(char) + (char == 'boyfriend' and -100 or (char == 'dad' and 150 or 0))) + getProperty(char ..".cameraPosition[0]") + getProperty(_char .."CameraOffset[0]") - (screenWidth/2),
        y = (getMidpointY(char) - ((char == 'boyfriend' or char == 'dad') and 100 or 0)) + getProperty(char ..".cameraPosition[1]") + getProperty(_char .."CameraOffset[1]") - (screenHeight/2)
    }
end

local function getCenterPos()
    return {
        x = (((getProperty('dad.x') + getProperty('dad.offset.x')) + getProperty('dad.width')/2) + ((getProperty('boyfriend.x') + getProperty('boyfriend.offset.x')) + getProperty('boyfriend.width')/2)) / 2,
        y = ((((getProperty('dad.y') + getProperty('dad.offset.y')) + getProperty('dad.height')/2) + ((getProperty('boyfriend.y') + getProperty('boyfriend.offset.y')) + getProperty('boyfriend.height')/2)) / 2) - 100
    }
end

local camOffsetX = 0
local camOffsetY = 0
local initialCamSpeed = 1

function onCreatePost() 
    setProperty('isCameraOnForcedPos', true)
    initialCamSpeed = getProperty('cameraSpeed')
end

local function follow(char, direction, sustain)
    if getVar('followenabled') then
        camOffsetX, camOffsetY = 0, 0

        if (direction == 0 or direction == 3) then camOffsetX = (direction == 0) and -offset or offset end
        if (direction == 1 or direction == 2) then camOffsetY = (direction == 1) and offset or -offset end

        setProperty('camFollow.x', (getVar('duet') and getCenterPos().x or (getCamPos(char).x + screenWidth / 2)) + camOffsetX)
        setProperty('camFollow.y', (getVar('duet') and getCenterPos().y or (getCamPos(char).y + screenHeight / 2)) + camOffsetY)
        setProperty('cameraSpeed', getVar('camSpeed'))

        runTimer('resetPos', stepCrochet/500)
    end
end

function onTimerCompleted(t) if t == 'resetPos' then 
    camOffsetX, camOffsetY = 0, 0
    setProperty('cameraSpeed', initialCamSpeed) 
end end

function goodNoteHit(id, d, _, s) if mustHitSection then follow((gfSection and 'gf' or 'boyfriend'), d, s) end end
function opponentNoteHit(id, d, _, s) if not mustHitSection then follow((gfSection and 'gf' or 'dad'), d, s) end end