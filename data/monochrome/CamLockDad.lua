    -- File: scripts/CamLockDad.lua
function onMoveCamera(focus)
    -- Khi game cố gắng chuyển góc máy sang boyfriend, ép nó quay lại dad
    if focus == 'boyfriend' then
        cameraSetTarget('dad')
    end
end

function onUpdatePost(elapsed)
    -- Đảm bảo camera bị khóa cứng vị trí trong mọi frame
    setProperty('isCameraOnForcedPos', true)
    cameraSetTarget('dad')
end