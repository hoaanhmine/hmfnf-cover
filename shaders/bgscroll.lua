function onCreatePost()

   initLuaShader("scroll")

 setSpriteShader('piracy bg',"scroll")
end

function onUpdate()
 setShaderFloat("piracy bg", "iTime", os.clock())
end


-- to set the x or y speed u have to change it within the shader