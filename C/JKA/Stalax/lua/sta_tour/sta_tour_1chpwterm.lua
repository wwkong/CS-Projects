--
-- This is a comment, it will be ignored by the Lua parser !
--

-- This function is called when the map is loaded.
-- How ? Simply by setting the key "luaSpawn" to "tour_SpawnChPwd".
-- The entity is a target_position, and it will be transformed into a nice password terminal.
function tour_SpawnChPwd (ent)

	-- Set the real origin to it's spawning origin.
	ent:SetOrigin(ent:GetOrigin())
	ent:SetPosition(ent:GetOrigin())

	-- Set it's model.
	ent:SetModel("models/map_objects/factory/f_con2.md3")

	-- Find automatically the right bounding boxes and set them.
	ent:AutoBox()

	-- Add the SVF_PLAYER_USABLE SvFlag, so the players can use it.
	ent:AddSvflag(SVF_PLAYER_USABLE)

	-- Make it solid.
	ent:SetContents(CONTENTS_SOLID)
	ent:SetClipmask(MASK_SOLID)

	-- The tour_ChPwdUse function will be called each time a player uses this entity.
	ent:SetUseFunction("tour_ChPwdUse")

	-- And link it, so we can see it, use it,...
	ent:Link()

end

-- This function is called when a player uses this terminal.
-- How ? Because in the tour_SpawnChPwd function, you can see the line :
-- ent:SetUseFunction("tour_ChPwdUse"), so that function will be called each time
-- a player uses it, ent is the terminal handle, and user is the player who used it.

function tour_ChPwdUse (ent, user)
	-- If your name is Padawan, you will see :
	--
	-- Hello Padawan,
	-- Please say the password.
	--
	-- Just use \n to have a new line.

	user:CenterPrint("Hello ", user:GetClientName(), "^7\nPlease say the password now.")

	-- Set a custom variable into the player's handle. It will be called "passwording",
	-- we set it to 1 to tell the game that the next player's message will be the password.
	user:SetValue("passwording", 1)
end

-- We register the "chat" event, and bind it to the "tourChat" function.
-- It will be called everytime a player tries to say something ingame.
game.RegisterEvent("chat", "tourChat")

function tourChat (ent, target, mode, text)
	-- First, we have to check if the custom variable "passwording" is set to 1.
	-- To see if the player has used the terminal before chatting.
	if ent:GetValue("passwording") == 1 then
	
		-- For some security, we check if the player is really close to the terminal
		-- and looking at the terminal.
		term = ent:AimEntity(32)
		if term == nil or term:GetKey("targetname") ~= "chpwdterminal" then
			ent:CenterPrint("^1You are too far from the terminal.")
			ent:SetValue("passwording", 0)
			return 1
		end
		
		-- We do "return 1" to tell the game to cancel the message. It's like a "mute" feature.
		
		-- The message typed by the player is stored into the "text" variable, created
		-- by the function, as you can see in "function tourChat (ent, target, mode, >>text<<)"
		if text == "goodpwd" then
		
			-- If the player typed the right password...
			ent:Chat("[^6Password Terminal^7]: ^2Access Granted!")
			
			-- We find the door having the targetname "chPwdDoor" and use it.
			door = entity.Pick("chPwdDoor")
			door:Use()
		else
			-- Or we show an error in the chatbox, like if the password terminal could talk. :-P
			ent:Chat("[^6Password Terminal^7]: ^1Access Denied, please read the sign!")
		end
		
		-- And we really MUST set the "passwording" custom variable to 0, so the player will have
		-- to use the terminal again in order to type the password again.
		ent:SetValue("passwording", 0)
		
		-- And be sure to return the 1 value to delete the chat message. So the others can't see what
		-- the player has typed.
		return 1
	end
end