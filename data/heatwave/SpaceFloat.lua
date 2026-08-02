
-- === CẤU HÌNH ĐỘ MẠNH ===
local floatSpeed = 1.5      -- Tốc độ dập dềnh (Càng cao càng nhanh)
local floatAmplitude = 50   -- Biên độ lên xuống (Càng cao trôi càng xa)
local rotateAmount = 4      -- Độ nghiêng lắc lư (Độ)

-- Biến lưu vị trí gốc (Để không bị trôi mất tích)
local dadY = 0
local bfY = 0
local dadX = 0
local bfX = 0

-- Biến đếm thời gian riêng
local floatTime = 0

function onCreatePost()
    -- Lấy vị trí gốc của nhân vật sau khi game đã load xong
    dadY = getProperty('dad.y')
    bfY = getProperty('boyfriend.y')
    
    -- Lấy cả X nếu muốn hiệu ứng trôi ngang nhẹ (tùy chọn)
    dadX = getProperty('dad.x')
    bfX = getProperty('boyfriend.x')
end

function onUpdate(elapsed)
    -- Cộng dồn thời gian (dùng elapsed để mượt trên mọi khung hình)
    floatTime = floatTime + elapsed * floatSpeed

    -- [[ 1. XỬ LÝ DAD TRÔI ]]
    -- Dùng math.sin cho trục Y (Lên xuống)
    local dadFloatY = math.sin(floatTime) * floatAmplitude
    -- Dùng math.cos cho góc nghiêng (Lắc lư)
    local dadRotate = math.cos(floatTime * 0.8) * rotateAmount
    
    setProperty('dad.y', dadY + dadFloatY)
    setProperty('dad.angle', dadRotate)


    -- [[ 2. XỬ LÝ BF TRÔI ]]
    -- Cộng thêm số (ví dụ + 2.0) vào floatTime để BF trôi lệch pha với Dad
    -- (Tránh việc cả 2 cùng lên cùng xuống như robot)
    local bfFloatY = math.sin(floatTime + 2.0) * floatAmplitude
    local bfRotate = math.cos((floatTime + 2.0) * 0.8) * rotateAmount

    setProperty('boyfriend.y', bfY + bfFloatY)
    setProperty('boyfriend.angle', bfRotate)
    -- Thêm vào cuối hàm onUpdate(elapsed)
    -- Cứ mỗi 0.1 giây tạo 1 cái bóng
    if floatTime % 0.2 < 0.05 then
        createGhost('dad')
        createGhost('boyfriend')
    end
end