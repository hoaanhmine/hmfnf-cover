function opponentNoteHit(id, direction, noteType, isSustainNote)
    -- Chỉ rút máu nếu máu > 10% (để tránh chết oan)
    if getHealth() > 0.2 then
        -- Trừ 0.02 máu (2%) mỗi nốt nhạc
        -- Thay đổi số 0.02 để tăng giảm độ khó
        addHealth(-0.02) 
    end
end
-- === HÀM XỬ LÝ ZOOM CAMERA THEO NHÂN VẬT ===
-- Cấu hình mức độ Zoom
local zoomAmount = 0.5 -- Số càng lớn thì zoom càng gần (0.1, 0.2, 0.3...)
local baseZoom = 0

function onCreatePost()
    -- Lưu lại mức zoom gốc của màn chơi (Stage) để dùng sau này
    baseZoom = getProperty('defaultCamZoom')
end

function onMoveCamera(focus)
    -- Khi camera chuyển sang Dad (Đối thủ)
    if focus == 'dad' then
        -- Zoom vào gần hơn (Zoom gốc + Lượng zoom thêm)
        setProperty('defaultCamZoom', baseZoom + zoomAmount)
        
    -- Khi camera chuyển sang Boyfriend (Bạn) hoặc GF
    elseif focus == 'boyfriend' then
        -- Trả về mức zoom bình thường
        setProperty('defaultCamZoom', baseZoom)
    end
end