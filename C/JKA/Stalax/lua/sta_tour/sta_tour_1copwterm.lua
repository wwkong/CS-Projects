--
-- This is a comment, it will be ignored by the Lua parser !
--

-- This function is called when the map is loaded.
-- How ? Simply by setting the key "luaSpawn" to "tour_SpawnConPwd".
-- The entity is a target_position, and it will be transformed into a nice password terminal.
function tour_SpawnConPwd (ent)

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

	-- The tour_ConPwdUse function will be called each time a player uses this entity.
	ent:SetUseFunction("tour_ConPwdUse")

	-- And link it, so we can see it, use it,...
	ent:Link()

end

-- This function is called when a player uses this terminal.
-- How ? Because in the tour_SpawnConPwd function, you can see the line :
-- ent:SetUseFunction("tour_ConPwdUse"), so that function will be called each time
-- a player uses it, ent is the terminal handle, and user is the player who used it.

function tour_ConPwdUse (ent, user)
	-- If your name is Padawan, you will see :
	--
	-- Hello Padawan,
	-- Please read the sign
	-- next to the door !
	--
	-- Just use \n to have a new line.

	user:CenterPrint("Hello ", user:GetClientName(), "^7\nPlease read the sign\nnext to the door !")

end

-- I create a new command, "/input", and I bind it to the tour_ConPwdInput function.
game.RegisterCommand("input", "tour_ConPwdInput")

function tour_ConPwdInput (ent, args)
	-- Oh, a player has just typed /input, lets see...
	-- ent is the player's handle, args is the number of the arguments he typed after /input.
	-- If he types "/input hello", args will be set to 1.
	-- If he types "/input hello world", args will be set to 2,...
	
	-- First, the player has to get near the terminal.
	-- We have to check if he is really close to the terminal and looking at it.
	-- The distance between the player and the terminal must be 32, if you put something bigger,
	-- he would be able to interact in longer distances.
	term = ent:AimEntity(32)
	
	-- In Lua, nil means NULL. If term = nothing, then we print the error and leave.
	if term == nil then
		ent:Print("^1Please get near the terminal and try again.")
		return
	end
	
	-- Now we have found an entity, we must check it's targetname, to be sure that the
	-- player isn't near the door, for example.
	-- ~= means "is not".
	if term:GetKey("targetname") ~= "conpwdterminal" then
		-- It wasn't the RIGHT entity, then we leave.
		ent:Print("^1Please get near the terminal and try again.")
		return
	end
	
	-- Lets see if he only typed /input without any arguments.
	if args == 0 then

		-- Ok, let's print the syntax then !
		ent:Print("Syntax: /input <password>")

		-- And leave the script immediately, stop here !
		return

	end
	
	-- Ok, he has typed something after /input. Lets see what he typed !
	pwd = game.Argument(1)
	
	-- Now we compare the string, if he typed "goodpwd", we open the door.
	-- If he didn't, we print an error and tell him nicely to read the sign.
	if pwd == "goodpwd" then
		ent:Print("^2Access granted!")
		-- Now we get the door, it's targetname is conPwdDoor...
		door = entity.Pick("conPwdDoor")
		door:Use()
		-- And that's it !
	else
		ent:Print("^1Access denied! Please read the sign!")
	end
end