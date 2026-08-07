 


function onUpdatePost(elapsed)
    -- Đảm bảo camera bị khóa cứng vị trí trong mọi frame
    setProperty('isCameraOnForcedPos', true)
    cameraSetTarget('dad')
end

function onCreatePost()
    -- Ẩn 4 khung viền mũi tên (receptors) của đối thủ
    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'visible', false)
        setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
    end
end

function onSpawnNote(id, noteData, noteType, isSustainNote)
    -- Ẩn toàn bộ các nốt nhạc chạy xuống của đối thủ
    if not getPropertyFromGroup('notes', id, 'mustPress') then
        setPropertyFromGroup('notes', id, 'visible', false)
        setPropertyFromGroup('notes', id, 'alpha', 0)
    end
end