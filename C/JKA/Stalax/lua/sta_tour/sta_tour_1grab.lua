function spawnCrate (ent)

	-- Set the real origin to it's spawning origin.
	ent:SetOrigin(ent:GetOrigin())
	ent:SetPosition(ent:GetOrigin())

	-- Set it's model.
	ent:SetModel("models/map_objects/hoth/crate_snow.md3")

	-- Find automatically the right bounding boxes and set them.
	ent:AutoBox()

	-- Add the SVF_PLAYER_USABLE SvFlag, so the players can use it.
	ent:AddSvflag(SVF_PLAYER_USABLE)

	-- Make it solid.
	ent:SetContents(CONTENTS_SOLID)
	ent:SetClipmask(MASK_SOLID)

	-- The tour_ConPwdUse function will be called each time a player uses this entity.
	ent:SetUseFunction("useCrate")

	-- Here we store the player's number who is using the crate.
	-- We put -1 because the first player is always 0 and we don't want to make any confusion.
	ent:SetValue("grabbedBy", -1)
	
	-- And link it, so we can see it, use it,...
	ent:Link()

end

-- Function called everytime a player uses the crate.
function useCrate (ent, player)
	-- Getting the player's number who is using that crate.
	using = ent:GetValue("grabbedBy")
	
	-- If the "grabbedBy" value is not set or is equal to -1...
	if using == nil or using == -1 then
		-- Put that crate in the player's hands.
		ent:SetValue("grabbedBy", player:GetNumber())
		player:CenterPrint("You are grabbing the crate.")
	elseif using == player:GetNumber() then
		-- If the same player is already using it, then I think he wants to drop it.
		ent:SetValue("grabbedBy", -1)
		player:CenterPrint("You've just dropped the crate.")
	else
		-- If the "grabbedBy" value is not set to -1 or to it's number then...
		player:CenterPrint("That crate is used by someone else.")
	end
end

-- The Think function of the crate.
-- Called each frame, the argument is the entity's handle of the crate.
function thinkCrate (ent)
	-- If the "grabbedBy" variable is not set to -1, then it's used by a player.
	if ent:GetValue("grabbedBy") > -1 then
		-- Get the player from the number stored into the "grabbedBy" variable.
		player = entity.FromNumber( ent:GetValue("grabbedBy") )
		if player then
			-- We get the origin that the player is looking at, with a distance of 80 units.
			org = player:AimOrigin(80)
			-- We set the crate's origin to the result, and we update the crate by linking it.
			ent:SetOrigin(org)
			ent:SetPosition(org)
			ent:Link()
		end
	end
end

-- The Think function of the trigger placed on the button.
-- Called each frame, the argument is the entity's handle of the trigger.
function objectTrgThink (ent)
	-- We get the door and the crate from their targetname.
	crate = entity.Pick("crateObject")
	door = entity.Pick("crateDoor")
	-- Getting the door's state.
	state = door:GetValue("opened")
	
	-- That function is magic, we try to see if the crate's origin is inside the AbsMin and AbsMax of the trigger.
	-- AbsMin and AbsMax are the bounding boxes calculated with the origin of the trigger, it returns 1 if the crate
	-- is really touching the trigger, it returns 0 otherwise.
	if game.PointInBounds(crate:GetPosition(), ent:GetAbsMin(), ent:GetAbsMax()) == 1 then
		-- If the crate is inside the trigger AND the door closed, let's open it !
		if state == nil or state == 0 then
			door:SetValue("opened", 1)
			door:Use()
		end
	else
		-- If the crate is outside the trigger AND the door opened, then we have to close it.
		if state == 1 then
			door:SetValue("opened", 0)
			door:Use()
		end
	end
end