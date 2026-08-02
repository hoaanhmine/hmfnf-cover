function onCreatePost()
    makeLuaText("infoCredit",'Android/Pc Port :NTH208', 1280,0,0)
    setTextSize('infoCredit', 24)
    setTextAlignment('infoCredit', 'right')
    setProperty('infoCredit.y',screenHeight - getProperty('infoCredit.height'))
     --setTextBorder("infoCredit", 1.5, '000000')
     setObjectCamera("infoCredit", 'camOther')
     addLuaText("infoCredit",true)
     
     setTextFont("infoCredit", "Time New Roman.ttf")
     setTextColor("infoCredit","cfa92d")

     makeLuaText("fps", " ", -1, 5, 5)
    setTextSize("fps", 15)
    setObjectCamera("fps", 'other'); 
    setTextColor('fps', 'ffffff')
    addLuaText("fps",true)
    setProperty('fps.alpha',1);
    
    makeLuaText("months", part1, -1, 5, 690)
    setTextSize("months", 11)
    setObjectCamera("months", 'other'); 
    setTextColor('months', 'ffffff')
    addLuaText("months")
    setProperty('months.alpha',0.90);

    makeLuaText("time", Part2, -1, 1, 705)
    setTextSize("time", 13)
    setObjectCamera("time", 'other'); 
    setTextColor('time', 'ffffff')
    addLuaText("time",true)
    setProperty('time.alpha',0.90);
    
    setTextBorder('fps', 0, '000000');
    setTextBorder('time', 0, '000000');
    setTextBorder('months', 0, '000000');
    
    setTextFont('fps','arial.ttf');
    setTextFont('time','arial.ttf');
    setTextFont('months','arial.ttf');
    
     timeTab = os.date('*t')

    yepp = ""
    --part1 = months[timeTab.month] .. '. ' .. timeTab.day .. ' ' .. timeTab.year
    part2 = timeTab.hour .. ':'.. timeTab.min .. ' '.. yepp 

  addHaxeLibrary('Main');
  runHaxeCode([[
    Main.fpsVar.visible = false;
  ]]);
end

function round(x, n)
  n = math.pow(10, n or 0)
  x = x * n
  if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
  return x / n
end


local months = {'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'}
local timeTab = {}

function onCreate()
end
mP = 0
memPeak = 0
function onUpdate()
setObjectOrder('fps',9999);
setObjectOrder('time',9999);
setObjectOrder('months',9999);

    
    local curFps = ""..getPropertyFromClass("Main", "fpsVar.currentFPS")
    local m = round(getPropertyFromClass("openfl.system.System", "totalMemory") / 1000000, 1);
    if mP < m then
    mP = m
    end
    local peakLv = 0
  

    timeTab = os.date('*t')
    yepp = ""
    if timeTab.hour < 12 then yepp = 'A.M' else yepp = 'P.M' end
    --part1 = 'Ngày: '..timeTab.day .. '/' .. months[timeTab.month] .. '/' .. timeTab.year
    part2 = 'Thời gian: '..timeTab.hour .. ':'.. minCheck() .. ' '.. yepp 

    setTextString('time', part2)
    setTextString('months', part1)

   if m> 1024 then
   memory = round(m / 1024,2)
   measure = "GB"
   else
   memory = m
   measure = "MB"
   end
   
   if mP> 1024 then
   memPeak = round(mP / 1024,2)
   measurePeak = "GB"
   else
   memPeak = mP
   measurePeak = "MB"
   end
   
   if getPropertyFromClass("Main", "fpsVar.currentFPS") <=30 then
   setTextColor('fps', 'ff0000')
   else
   setTextColor('fps', 'ffffff')
   end
 
    setTextString("fps","FPS: "..curFps.." • Memory: " .. memory ..""..measure)
end

function round(x, n)
  n = math.pow(10, n or 0)
  x = x * n
  if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
  return x / n
end

function minCheck()
    if string.len(timeTab.min) < 2 then
        if tonumber(timeTab.min) < 10 then 
            return '0'..timeTab.min
        else
            return timeTab.min
        end
    else
        return timeTab.min
    end
end

function mathlerp(from,to,i)
  return from+(to-from)*i
end

function onEndSong() 
addHaxeLibrary('Main');
  runHaxeCode([[
    Main.fpsVar.visible = true;
  ]]);
end

function exitSong() 
addHaxeLibrary('Main');
  runHaxeCode([[
    Main.fpsVar.visible = true;
  ]]);
end

