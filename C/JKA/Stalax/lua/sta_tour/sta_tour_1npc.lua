-- Here's the useLuke function, called inside the luaUse key of the entity NPC_Luke
-- that function will be called everytime a player uses Luke with the USE button.
function useLuke (luke, player)
	if player:GetValue("lukeInterval") == nil or player:GetValue("lukeInterval") == 0 then
		-- "lukeInterval" is the number of milliseconds to wait before telling the player to print the message.
		-- We have to get the current server's time and add 100 msec to make the game send it at each 100 msec.
		-- It's safier than sending at each milliseconds because the server can lag a lot.
		player:SetValue("lukeInterval", game.Time() + 100)
		
		-- We set "lukeDialog" to the first dialog, called "hello".
		player:SetString("lukeDialog", "hello")
	end
end

-- Registering the frame event to the lukeCheckFrame function.
game.RegisterEvent("frame", "lukeCheckFrame")

-- Registering the chat event to the lukeChat function.
game.RegisterEvent("chat", "lukeChat")

-- Function called each frame.
-- It checks if every players have the value "lukeInterval" bigger than 0,
-- to see if they are chatting with Luke.
function lukeCheckFrame (ms)
	-- Getting every players into a table.
	players = game.Players()

	-- Checking each player, "a" is the number, 1, 2, 3,... 32.
	-- t is the player's entity handle.
	for a, t in ipairs(players) do
		-- We grab the entity from the selected player.
		player = t
		
		-- We get it's "lukeInterval" value.
		interval = player:GetValue("lukeInterval")
		
		-- "ms" is defined into the "lukeCheckFrame" function. It's the server's current time
		-- in milliseconds. And the value stored inside "lukeInterval" was the addition of the server's time with
		-- 100 millisecs in it, and if interval < ms, that means 100 milliseconds have elapsed.
		-- If interval is set to 0 or nil, then the player is not chatting with Luke, then we skip it.
		if interval < ms and interval > 1 and interval ~= nil then
		
			-- Then we add 100 milliseconds to the player's interval.
			player:SetValue("lukeInterval", game.Time() + 100)
			
			-- Getting the "lukeDialog" string, to see which dialog we have to print.
			dialog = player:GetString("lukeDialog")

			-- "hello" is the very first dialog.
			if dialog == "hello" then
				-- Hello, Padawan,
				-- What do you want ?
				--
				-- 1 Can you open the door ?
				-- 2 Ummm nothing.
				player:CenterPrint("Hello, ", player:GetClientName(), "^7\nWhat do you want ?\n\n^51 ^3Can you open the door ?\n^52 ^3Ummm nothing.")
			-- "opendoor1" is the dialog when the player chooses "1 Can you open the door ?".
			elseif dialog == "opendoor1" then
				-- Are you sure ?
				--
				-- 1 Yes.
				-- 2 No.
				player:CenterPrint("Are you sure ?\n\n^51 ^3Yes.\n^52 ^3No.")
			end

		end
	end
end

-- Function called everytime someone speaks.
function lukeChat(player, target, mode, text)
	-- If the "lukeInterval" value is set to 0, then the player is not talking with Luke.
	-- Skip that then.
	if player:GetValue("lukeInterval") > 1 then

		-- Getting the current dialog.
		dialog = player:GetString("lukeDialog")

		-- The first dialog, we have the choices :
		-- 1 Can you open the door ?
		-- 2 Ummm nothing.
		--
		-- text is the text message sent by the player, let's analyze it.
		if dialog == "hello" then

			-- If the player has chosen "Can you open the door ?"
			if text == "1" then
				-- Set the lukeDialog variable to "opendoor1", the next dialog.
				player:SetString("lukeDialog", "opendoor1")
				player:Chat(player:GetClientName(),"^7 -> ^5Can you open the door ?")
			elseif text == "2" then
				-- He has nothing to say, set lukeInterval to 0 in order to end the conversation immediately.
				player:SetValue("lukeInterval", 0)
				player:Chat(player:GetClientName(),"^7 -> ^5Ummm nothing.")
				player:CenterPrint("Alright, see you later!")
			else
				-- He said anything else, set lukeInterval to 0 in order to end the conversation immediately.
				player:SetValue("lukeInterval", 0)
				player:Chat(player:GetClientName(),"^7 -> ^5", text)
				player:CenterPrint("Err, I didn't understand.")
			end

		-- If the player confirms that he wants to open the door.
		elseif dialog == "opendoor1" then

			-- If he said yes by typing "1".
			if text == "1" then
				-- End the dialog by setting "lukeInterval" to 0.
				player:SetValue("lukeInterval", 0)
				player:Chat(player:GetClientName(),"^7 -> ^5Yes.")
				player:CenterPrint("OK.")
				door = entity.Pick("npcDoor")
				door:Use()
			elseif text == "2" then
				-- End the dialog by setting "lukeInterval" to 0.
				player:SetValue("lukeInterval", 0)
				player:Chat(player:GetClientName(),"^7 -> ^5No.")
				player:CenterPrint("Alright then.")
			else
				-- End the dialog by setting "lukeInterval" to 0.
				player:SetValue("lukeInterval", 0)
				player:Chat(player:GetClientName(),"^7 -> ^5", text)
				player:CenterPrint("Err, I didn't understand.")
			end

		end

		-- Important, must return 1 if he was chatting with Luke, so the message will not be sent
		-- and not visible to other players ingame.
		return 1
	end
end