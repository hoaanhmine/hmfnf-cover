-- Script xử lý SetCameraBop kiểu V-Slice
-- Value 1: Rate (Tần suất - bao nhiêu beat gật 1 lần)
-- Value 2: Intensity (Cường độ - độ mạnh của cú zoom)

local currentBopRate = 4 -- Mặc định gật mỗi 4 beat
local currentBopIntensity = 1.0 -- Mặc định cường độ là 1

function onCreatePost()
    -- Tắt tính năng tự động gật của game để Script này tự quản lý hoàn toàn
    -- Điều này giúp tránh bị gật chồng chéo (double bop)
    setProperty('camZooming', false)
end

function onEvent(name, value1, value2)
    if name == "SetCameraBop" then
        -- Xử lý Value 1: Rate
        local newRate = tonumber(value1)
        if newRate ~= nil then
            currentBopRate = newRate
        end

        -- Xử lý Value 2: Intensity
        local newIntensity = tonumber(value2)
        if newIntensity ~= nil then
            currentBopIntensity = newIntensity
        end
        
        -- Debug (có thể xóa nếu không cần)
        -- debugPrint('Bop Update: Rate=' .. currentBopRate .. ', Intensity=' .. currentBopIntensity)
    end
end

function onBeatHit()
    -- Logic gật camera
    -- Chỉ gật nếu Cường độ > 0 và Tần suất > 0
    if currentBopIntensity > 0 and currentBopRate > 0 then
        -- Kiểm tra xem beat hiện tại có chia hết cho Rate không
        if curBeat % currentBopRate == 0 then
            -- Tính độ mạnh dựa trên cường độ
            -- 0.015 và 0.03 là thông số chuẩn của FNF
            local gameZoomAmt = 0.015 * currentBopIntensity
            local hudZoomAmt = 0.03 * currentBopIntensity
            
            -- Thực hiện lệnh gật (Add Camera Zoom)
            triggerEvent('Add Camera Zoom', gameZoomAmt, hudZoomAmt)
        end
    end
end