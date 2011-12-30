--
-- This is a comment, it will be ignored by the Lua parser !
--

-- This function is called when the map is loaded.
-- How ? Simply by setting the key "luaSpawn" to "tour_SpawnTp".
-- The entity is a target_position, and it will be transformed into a nice password terminal.
function tour_SpawnTp (ent)

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
	ent:SetUseFunction("tour_TpUse")

	-- And link it, so we can see it, use it,...
	ent:Link()

end

-- This function is called when a player uses this terminal.
-- How ? Because in the tour_SpawnTp function, you can see the line :
-- ent:SetUseFunction("tour_TpUse"), so that function will be called each time
-- a player uses it, ent is the terminal handle, and user is the player who used it.

function tour_TpUse (ent, user)
	-- If your name is Padawan, you will see :
	--
	-- Hello Padawan,
	-- Please say the password.
	--
	-- Just use \n to have a new line.

	user:CenterPrint("Hello ", user:GetClientName(), "^7\nWhere do you want to go ?\n^31 ^7Next Level\n^32 ^7First Level\n^33 ^7Nothing\n\n^5Say a number to continue.")

	-- Set a custom variable into the player's handle. It will be called "teleporting",
	-- we set it to 1 to tell the game that the next player's message will be the password.
	user:SetValue("teleporting", 1)
end

-- We register the "chat" event, and bind it to the "tourTPChat" function.
-- It will be called everytime a player tries to say something ingame.
game.RegisterEvent("chat", "tourTPChat")

function tourTPChat (ent, target, mode, text)
	-- First, we have to check if the custom variable "teleporting" is set to 1.
	-- To see if the player has used the terminal before chatting.
	if ent:GetValue("teleporting") == 1 then
	
		-- For some security, we check if the player is really close to the terminal
		-- and looking at the terminal.
		term = ent:AimEntity(32)
		if term == nil or term:GetKey("targetname") ~= "tpterminal" then
			ent:CenterPrint("^1You are too far from the terminal.")
			ent:SetValue("teleporting", 0)
			return 1
		end
		
		-- We do "return 1" to tell the game to cancel the message. It's like a "mute" feature.
		
		-- The message typed by the player is stored into the "text" variable, created
		-- by the function, as you can see in "function tourTPChat (ent, target, mode, >>text<<)"
		if text == "1" then
		
			-- If the player typed the number 1...
			ent:Chat("[^6Teleporter Terminal^7]: ^5Teleporting you to the next level...")
			
			-- If we know the coordinates (by creating a target_position, moving it to the destination
			-- and seeing them with the Entity Properties window...), why wasting a target_position then ?
			-- Lets copy the coordinates.
			
			-- Now creating the "org" vector, we put the destination's coordinates.
			-- And we put the destination's angles into ang.
			org = vector.Construct(4096,-640,32)
			ang = vector.Construct(0,-90,0)
			
			-- And we teleport the player to those coordinates.
			ent:Teleport(org, ang)
		elseif text == "2" then
		
			-- If the player typed the number 2...
			ent:Chat("[^6Teleporter Terminal^7]: ^5Teleporting you to the first level...")
			
			-- Now creating the "org" vector, we put the destination's coordinates.
			-- And we put the destination's angles into ang.
			org = vector.Construct(-320,0,32)
			ang = vector.Construct(0,0,0)
			
			-- And we teleport the player to those coordinates.
			ent:Teleport(org, ang)
		elseif text == "3" then
			-- If the player typed the number 3...
			ent:Chat("[^6Teleporter Terminal^7]: ^5Alright, see you later!")
		else
			-- If the player typed anything else...
			ent:Chat("[^6Teleporter Terminal^7]: ^5Err, I didn't really understand your choice...")
		end
		
		-- And we really MUST set the "teleporting" custom variable to 0, so the player will have
		-- to use the terminal again in order to type the password again.
		ent:SetValue("teleporting", 0)
		
		-- And be sure to return the 1 value to delete the chat message. So the others can't see what
		-- the player has typed.
		return 1
	end
end