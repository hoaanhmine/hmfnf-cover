function onEvent(n,v1)
if n=='SetHealthIcon' then
if v1=='bf' or v1=='gf' then
callMethod('iconP1.changeIcon',{v1})
else
callMethod('iconP2.changeIcon',{v1})
end
end
end