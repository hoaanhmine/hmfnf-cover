-- === BIẾN CẤU HÌNH (Dễ dàng tùy chỉnh độ "cháy" tại đây) ===
-- Vị trí gốc (Sẽ được tự động lưu)
local originalBfX = 0
local originalDadX = 0

-- Các thông số hiệu ứng
local pushDistance = 35  -- Độ xa bị đẩy lùi (pixel). Tăng số này để đẩy xa hơn.
local impactTime = 0.02  -- Thời gian bị đẩy lùi (giây). Càng nhỏ càng tạo cảm giác "giật" mạnh.
local returnTime = 0.12  -- Thời gian quay về vị trí cũ (giây). Giữ nhỏ để nhân vật không bị trượt quá lâu.

-- Kiểu chuyển động khi đẩy lùi (Dùng 'quartOut' cho cảm giác tác động nhanh)
local easeImpact = 'quartOut' 
-- Kiểu chuyển động khi quay về (Dùng 'quadInOut' hoặc 'circOut' cho mượt)
local easeReturn = 'quadInOut'

function onCreatePost()
    -- [GIỮ NGUYÊN CÁC CODE KHÁC TRONG ONCREATEPOST CỦA BẠN]

    -- TỰ ĐỘNG LƯU VỊ TRÍ ĐỨNG GỐC CỦA CẢ 2 NGAY KHI VÀO BÀI
    originalBfX = getProperty('boyfriend.x')
    originalDadX = getProperty('dad.x')
end

-- === HÀM CẬP NHẬT (Để xử lý việc quay về vị trí cũ mượt mà) ===
function onTweenCompleted(tag)
    -- Khi nhân vật bị đẩy lùi xong, lập tức tween họ quay về vị trí gốc
    
    if tag == 'bfImpact' then
        -- Boyfriend quay về
        doTweenX('bfReturn', 'boyfriend', originalBfX, returnTime, easeReturn)
        
    elseif tag == 'dadImpact' then
        -- Dad (Finn) quay về
        doTweenX('dadReturn', 'dad', originalDadX, returnTime, easeReturn)
    end
end

-- === XỬ LÝ VIỆC ĐẨY LÙI KHI TRÚNG NOTE ===

-- 1. Khi FINN (Dad) hát (Đẩy lùi Boyfriend)
function opponentNoteHit(id, dir, type, sus)
    -- Chỉ kích hoạt hiệu ứng trong đoạn solo solo (Beats 1176 - 1340)
    if curBeat >= 1176 and curBeat < 1340 then
        -- Kiểm tra xem note có phải là note dài (sustain) không. 
        -- Chúng ta chỉ muốn đẩy lùi ở note đầu tiên, note dài thì không cần.
        if not sus then
            -- Tùy theo layout mặc định của FNF: Dad bên trái, BF bên phải.
            -- Finn hát => Pibby Finn đánh => Đẩy BF sang bên phải (Tọa độ X tăng)
            local targetX = originalBfX + pushDistance
            
            -- Ép hủy bỏ các tween quay về đang chạy dở để thực hiện cú đẩy mới
            cancelTween('bfReturn') 
            
            -- Thực hiện cú đẩy lùi chớp nhoáng
            doTweenX('bfImpact', 'boyfriend', targetX, impactTime, easeImpact)
        end
    end
end

-- 2. Khi BOYFRIEND hát (Đẩy lùi Finn)
function goodNoteHit(id, dir, type, sus)
    -- Chỉ kích hoạt hiệu ứng trong đoạn solo
    if curBeat >= 1176 and curBeat < 1340 then
        if not sus then
            -- BF hát => BF phản công => Đẩy Finn (Dad) sang bên trái (Tọa độ X giảm)
            local targetX = originalDadX - pushDistance
            
            cancelTween('dadReturn') -- Ép hủy tween quay về cũ
            
            -- Thực hiện cú đẩy lùi
            doTweenX('dadImpact', 'dad', targetX, impactTime, easeImpact)
        end
    end
end