-- [[ CẤU HÌNH TÊN ẢNH ]]
local bgImageName = 'stages/space/galaxy_planet' -- Thay tên ảnh của bạn vào đây (không cần .png)

-- [[ CẤU HÌNH ĐỘ ẢO ]]
local moveSpeed = 0.5      -- Tốc độ trôi (Thấp = Trôi chậm chill chill)
local moveRange = 50       -- Khoảng cách trôi (Pixel)
local rotationSpeed = 0.6  -- Tốc độ nghiêng
local rotationRange = 2    -- Góc nghiêng tối đa (Độ)
local zoomSpeed = 0.4      -- Tốc độ Zoom ra vào
local baseZoom = 1.2       -- Độ to mặc định (Phải lớn hơn 1 để không bị hở viền đen)

-- Biến hệ thống
local time = 0
local screenCenterX = 1280 / 2
local screenCenterY = 720 / 2

function onCreate()
    -- 1. Tạo hình nền
    -- Đặt ở vị trí -500, -500 để lát nữa chỉnh lại tâm cho dễ
    makeLuaSprite('spaceBG', bgImageName, 0, 0)
    
    -- 2. Cài đặt hình ảnh
    -- ScrollFactor = 0 để nó dính chặt vào màn hình (hoặc số nhỏ để tạo độ sâu)
    setScrollFactor('spaceBG', 0.1, 0.1) 
    
    -- Phóng to ảnh lên (Bắt buộc phải to hơn màn hình để khi lắc không bị hở đen)
    scaleObject('spaceBG', baseZoom, baseZoom)
    
    -- Đặt tâm ảnh vào giữa màn hình
    screenCenter('spaceBG')
    
    -- Đưa ra đằng sau cùng (sau nhân vật)
    addLuaSprite('spaceBG', false)
end

function onUpdate(elapsed)
    -- Cộng dồn thời gian
    time = time + elapsed
    
    -- [[ HIỆU ỨNG 1: TRÔI DẬP DỀNH (Move) ]]
    -- Dùng Sin cho X và Cos cho Y để tạo chuyển động hình Elip/Tròn
    local moveX = math.sin(time * moveSpeed) * moveRange
    local moveY = math.cos(time * moveSpeed * 0.8) * moveRange -- *0.8 để nhịp X và Y lệch nhau xíu cho tự nhiên
    
    -- Cập nhật vị trí (Lấy vị trí giữa màn hình + độ lệch)
    -- Ta cần tính lại offset vì scaleObject làm thay đổi kích thước thực
    setProperty('spaceBG.x', (screenCenterX - getProperty('spaceBG.width')/2) + moveX)
    setProperty('spaceBG.y', (screenCenterY - getProperty('spaceBG.height')/2) + moveY)


    -- [[ HIỆU ỨNG 2: NGHIÊNG NHẸ (Tilt) ]]
    -- Nghiêng qua lại chậm rãi
    local tilt = math.sin(time * rotationSpeed) * rotationRange
    setProperty('spaceBG.angle', tilt)


    -- [[ HIỆU ỨNG 3: THỞ (Zoom) ]]
    -- Zoom vào ra nhẹ nhàng
    local zoom = baseZoom + math.sin(time * zoomSpeed) * 0.05 -- Chỉ zoom thêm 0.05 thôi
    setProperty('spaceBG.scale.x', zoom)
    setProperty('spaceBG.scale.y', zoom)
end