if not _G.WolfHUD then
	_G.WolfHUD = {}
	WolfHUD.mod_path = ModPath
	WolfHUD.save_path = SavePath .. "WolfHUD.txt"
	WolfHUD.DEBUG_MODE = false
	WolfHUD.version = ""
	WolfHUD.menu_ids = { 
		"wolfhud_options_menu", 
		"wolfhud_teampanels_options_menu", 
		"wolfhud_chat_options_menu", 
		"wolfhud_killcounter_options_menu", 
		"wolfhud_drivinghud_options_menu", 
		"wolfhud_infopanels_options_menu", 
		"wolfhud_infopanels_adv_options_menu", 
		"wolfhud_dmgindicator_options_menu", 
		"wolfhud_enemyhealthbar_options_menu", 
		"wolfhud_press2hold_options_menu", 
		"wolfhud_lasers_options_menu" 
	}
	
	if not WolfHUD.color_table then
		WolfHUD.color_table = {
			{ color = Color('FFFFFF'), name = "white" },		--1:  White
			{ color = Color('F2F250'), name = "light_yellow" },	--2:  Light_Yellow
			{ color = Color('F2C24E'), name = "light_orange" },	--3:  Light_Orange
			{ color = Color('E55858'), name = "light_red" },	--4:  Light_Red
			{ color = Color('CC55CC'), name = "light_purple" },	--5:  Light_Purple
			{ color = Color('00FF00'), name = "light_green" },	--6:  Light_Green
			{ color = Color('00FFFF'), name = "light_blue" },	--7:  Light_Blue
			{ color = Color('FFFF00'), name = "yellow" },		--8:  Yellow
			{ color = Color('FFA500'), name = "orange" },		--9:  Orange
			{ color = Color('FF0000'), name = "red" },			--10: Red
			{ color = Color('800080'), name = "purple" },		--11: Purple
			{ color = Color('008000'), name = "green" },		--12: Green
			{ color = Color('0000FF'), name = "blue" },			--13: Blue
			{ color = Color('808080'), name = "gray" },			--14: Gray
			{ color = Color('000000'), name = "black" },		--15: Black
			{ color = Color('000000'), name = "rainbow" },		--16: Rainbow (only available in laser colors)
		}
	end
	
	WolfHUD.hook_files = WolfHUD.hook_files or {
		["lib/setups/gamesetup"] = { "GameInfoManager.lua" },
		["lib/managers/menumanager"] = { "MenuTweaks.lua" },
		["lib/managers/menumanagerdialogs"] = { "MenuTweaks.lua" },
		["lib/managers/chatmanager"] = { "MenuTweaks.lua" },
		["lib/managers/localizationmanager"] = { "AdvAssault.lua" },
		["lib/managers/hudmanager"] = { "EnemyHealthbar.lua", "TabStats.lua" },
		["lib/managers/hudmanagerpd2"] = { "CustomHUD.lua", "HUDChat.lua", "HUDList.lua", "KillCounter.lua", "DownCounter.lua", "DrivingHUD.lua", "DamageIndicator.lua", "Interaction.lua", "BurstFire.lua", "AdvAssault.lua" },
		["lib/managers/playermanager"] = { "HUDList.lua" },
		["lib/managers/trademanager"] = { "DownCounter.lua" },
		["lib/managers/hud/huddriving"] = { "DrivingHUD.lua" },
		["lib/managers/hud/hudteammate"] = { "CustomHUD.lua", "KillCounter.lua", "DownCounter.lua", "Scripts.lua", "BurstFire.lua" },
		["lib/managers/hud/hudtemp"] = { "CustomHUD.lua" },
		["lib/managers/hud/hudassaultcorner"] = { "HUDList.lua", "AdvAssault.lua" },
		["lib/managers/hud/hudobjectives"] = { "EnhancedObjective.lua" },
		["lib/managers/hud/hudheisttimer"] = { "EnhancedObjective.lua" },
		["lib/managers/hud/hudchat"] = { "HUDChat.lua" },
		["lib/managers/hud/hudstatsscreen"] = { "TabStats.lua" },
		["lib/managers/hud/hudinteraction"] = { "Interaction.lua" },
		["lib/managers/hud/hudsuspicion"] = { "NumbericSuspicion.lua" },
		["lib/managers/hud/hudhitdirection"] = { "DamageIndicator.lua" },
		["lib/managers/enemymanager"] = { "GameInfoManager.lua", "KillCounter.lua" },
		["lib/managers/group_ai_states/groupaistatebase"] = { "GameInfoManager.lua", "PacifiedCivs.lua" },
		["lib/managers/missionassetsmanager"] = { "MenuTweaks.lua" },
		["lib/managers/menu/blackmarketgui"] = { "MenuTweaks.lua" },
		["lib/managers/menu/stageendscreengui"] = { "MenuTweaks.lua" },
		["lib/managers/menu/lootdropscreengui"] = { "MenuTweaks.lua" },
		["lib/managers/menu/renderers/menunodeskillswitchgui"] = { "MenuTweaks.lua" },
		["lib/managers/objectinteractionmanager"] = { "GameInfoManager.lua", "HUDList.lua", "Interaction.lua" },
		["lib/network/handlers/unitnetworkhandler"] = { "DownCounter.lua", "GameInfoManager.lua" },
--		["lib/units/unitbase"] = { "HUDList.lua" },
		["lib/units/props/timergui"] = { "GameInfoManager.lua" },
		["lib/units/props/digitalgui"] = { "GameInfoManager.lua" },
		["lib/units/props/securitylockgui"] = { "GameInfoManager.lua" },
		["lib/units/enemies/cop/copdamage"] = { "GameInfoManager.lua", "KillCounter.lua", "TabStats.lua" },
		["lib/units/equipment/ammo_bag/ammobagbase"] = { "GameInfoManager.lua" },
		["lib/units/equipment/bodybags_bag/bodybagsbagbase"] = { "GameInfoManager.lua" },
		["lib/units/equipment/doctor_bag/doctorbagbase"] = { "DownCounter.lua", "GameInfoManager.lua" },
		["lib/units/equipment/ecm_jammer/ecmjammerbase"] = { "GameInfoManager.lua" },
		["lib/units/equipment/grenade_crate/grenadecratebase"] = { "GameInfoManager.lua" },
		["lib/units/equipment/sentry_gun/sentrygunbase"] = { "GameInfoManager.lua", "KillCounter.lua" },
		["lib/units/equipment/sentry_gun/sentrygundamage"] = { "GameInfoManager.lua" },
		["lib/units/interactions/interactionext"] = { "Interaction.lua" },
		["lib/units/weapons/akimboweaponbase"] = { "BurstFire.lua" },
		["lib/units/weapons/sentrygunweapon"] = { "GameInfoManager.lua" },
		["lib/units/weapons/weaponlaser"] = { "WeaponLasers.lua" },
		["lib/units/weapons/weaponflashlight"] = { "WeaponLasers.lua" },
		["lib/units/weapons/raycastweaponbase"] = { "Scripts.lua", "WeaponLasers.lua" },
		["lib/units/weapons/newraycastweaponbase"] = { "WeaponLasers.lua", "BurstFire.lua" },
--		["lib/units/props/missiondoor"] = { "HUDList.lua" },
		["lib/units/props/securitycamera"] = { "GameInfoManager.lua" },
		["lib/units/beings/player/playerdamage"] = { "HUDList.lua", "DamageIndicator.lua" },
		["lib/units/beings/player/playermovement"] = { "HUDList.lua" },
		["lib/units/beings/player/huskplayermovement"] = { "DownCounter.lua" },
		["lib/units/beings/player/states/playercivilian"] = { "Interaction.lua" },
		["lib/units/beings/player/states/playerstandard"] = { "HUDList.lua", "EnemyHealthbar.lua", "Interaction.lua", "BurstFire.lua" },
		["lib/units/beings/player/states/playerbleedout"] = { "DownCounter.lua" },
		["lib/units/vehicles/vehicledamage"] = { "DamageIndicator.lua" },
		["lib/states/ingamedriving"] = { "DrivingHUD.lua" },
		["lib/states/ingamewaitingforplayers"] = { "MenuTweaks.lua" },
		["lib/tweak_data/guitweakdata"] = { "MenuTweaks.lua" },	
		["lib/tweak_data/timespeedeffecttweakdata"] = { "Scripts.lua" },
		["core/lib/managers/menu/items/coremenuitemslider"] = { "MenuTweaks.lua" },
	}
	
	
	function WolfHUD:Reset()
		WolfHUD.settings = 
		{
		  --CustomHUD
			use_customhud 					= true,
			PLAYER_PANEL_SCALE 				= 0.85,		--Size of local Player HUD Panel
			TEAMMATE_PANEL_SCALE 			= 0.75,		--Size of Teammates/AI's HUD Panels
			colorize_healthbars				= 2,		--Colorize mode: 1 = none, 2 = by peer id, 3 = by health amount
			show_downcounter 				= true,	
			use_realammo					= true,
		  --HUDChat
			CHAT_WAIT_TIME					= 10,		--Time before chat fades out
			LINE_HEIGHT						= 15,		--Chat font Size
			MAX_OUTPUT_LINES				= 8,		--Chat Output lines
		  --KillCounter
			use_killcounter 				= true,
			SHOW_SPECIAL_KILLS 				= true,		--KillCounter shows special kills
			SHOW_HEADSHOT_KILLS 			= true,		--KillCounter shows headshot kills
			SHOW_AI_KILLS 					= true,		--Show KillCounter for Bots
			max_corpses 					= 100,		--Maximum number of laying around corpses
		  --Enemy Healthbar
			show_enemy_healthbar 			= true,		--Show healthbars
			show_civilian_healthbar 		= false,	--Show Healthbars for Civilians and TeamAI
			show_car_healthbar				= true,		--Show Healthbar for vehicles
			show_healthbar_pointer 			= false,	--Show pointer near the Healthbar, pointing at Healthbar owner
		  --Dynamic Damage Indicator
			show_dmg_indicator				= true,
			dmg_ind_size					= 150,
			dmg_ind_time					= 2,
			dmg_shield_color				= "white",
			dmg_health_color				= "red",
			dmg_crit_color					= "purple",
			dmg_vehicle_color				= "yellow",
			dmg_friendlyfire_color			= "orange",
		  --Driving HUD
			use_drivinghud					= true,		--Show DrivingHUD Panel
			show_vehicle 					= true,		--Show Vehicle and Teammate Mask Images
			speed_in_mph 					= false,	--Display Speed in mph
		  --Scripts
			skip_blackscreen 				= true,		--Skip the blackscreen on mission start
			stat_screen_delay 				= 5,		--Skip the experience screen after X seconds
			loot_screen_delay 				= 3,		--Skip the loot screen after X seconds
			spam_filter						= true,		--Filter PocoHud and NGBTO Chat Spam messages.
		  --HUDList
			show_timers 					= true,     --Drills, time locks, hacking etc.
			show_equipment 					= true,  	--Deployables (ammo, doc bags, body bags)
			show_sentries 					= true,   	--Deployable sentries
				hide_empty_sentries 		= true, 	--Hide sentries with no ammo if player lacks the skill to refill them
			show_ecms 						= true,		--Active ECMs
			show_ecm_retrigger 				= true,  	--Countdown for players own ECM feedback retrigger delay
			show_minions 					= true,  	--Converted enemies, type and health
			show_pagers 					= true,  	--Show currently active pagers
			show_tape_loop 					= true,  	--Show active tape loop duration
			remove_answered_pager_contour 	= true,  	--Removes the interaction contour on answered pagers

			show_enemies 					= true,		--Currently spawned enemies
				aggregate_enemies 			= false,  	--Don't split enemies on type; use a single entry for all
			show_turrets 					= true,    	--Show active SWAT turrets
			show_civilians 					= true,  	--Currently spawned, untied civs
			show_hostages 					= true,   	--Currently tied civilian and dominated cops
			show_minion_count 				= true,     --Current number of jokered enemies
			show_pager_count 				= true,		--Show number of triggered pagers (only counts pagers triggered while you were present)
			show_loot 						= true,     --Show spawned and active loot bags/piles (may not be shown if certain mission parameters has not been met)
				aggregate_loot 				= false, 	--Don't split loot on type; use a single entry for all
				separate_bagged_loot 		= true,     --Show bagged loot as a separate value
			show_special_pickups 			= true,    	--Show number of special equipment/items

			show_buffs 						= 1,     --Active effects (buffs/debuffs). Also see HUDList.BuffItemBase.IGNORED_BUFFS table to ignore specific buffs that you don't want listed, or enable some of those not shown by default
			
			use_hudlist 					= true,
			hud_box_color 					= "white",		--Left and Right List font color
			hud_box_bg_color 				= "black",		--Left and Right List BG color
			civilian_color 					= "white", 		--EnemyCounter Civillian and Hostage icon color
			thug_color 						= "white",		--EnemyCounter Thug and Mobster icon color
			enemy_color 					= "white",			--EnemyCounter Cop and Specials icon color
		  --Press2Hold
			use_press2hold 					= true,
			LOCK_MODE 						= 2,			--Lock interaction, if MIN_TIMER_DURATION is longer then total interaction time, or current interaction time
			MIN_TIMER_DURATION 				= 5, 			--Min interaction duration (in seconds) for the toggle behavior to activate
			EQUIPMENT_PRESS_INTERRUPT 		= true, 		--Use the equipment key ('G') to toggle off active interactions
			SHOW_LOCK_INDICATOR				= true,
			SHOW_CIRCLE						= true,
			SHOW_TIME_REMAINING 			= true,			--Show remaining Time in the Interaction-Circle
			GRADIENT_COLOR 					= "light_green",--Color, which the timer reaches on completition
			SHOW_RELOAD						= true,
			SUPRESS_NADES_STEALTH			= true,
			HOLD2PICK						= true,
		  --Laser-Colors
			laser_remember_state			= true,
			laser_autoon					= true,
			use_weaponlasers 				= true,
		    laser_light 					= 10,			--Multiplier for laser dot
			laser_glow 						= 5,			--Divider for laser beam
			laser_player 					= "light_blue",	--Player laser color id
			laser_player_alpha 				= 0.3,			--Player laser alpha
			laser_teammates 				= "light_blue",	--Teammates laser color id
			laser_teammates_alpha 			= 0.15,			--Teammates laser alpha
			laser_sniper 					= "red",		--Sniper laser color id
			laser_sniper_alpha 				= 0.5,			--Sniper laser alpha
			laser_turret_active 			= "red",		--Active turret laser color id
			laser_turret_reloading 			= "yellow",		--Reloading turret laser color id
			laser_turret_jammed 			= "green",		--Jammed turret laser color id
			laser_turret_alpha 				= 0.15,			--Turret laser alpha
			flashlight_angle 				= 100,			--Flashlight angle
			flashlight_range 				= 20,			--Flashlight range (in m)
			
			show_advanced_assault			= true,
			replace_weapon_names 			= true,
			enable_burstmode				= true,
			use_federal_inventory 			= true
		}
	end
	
	function WolfHUD:print_log(text)
		if self.DEBUG_MODE then
			log("[WolfHUD] " .. text)
		end
	end
	
	function WolfHUD:Load()
		local corrupt = false
		local file = io.open(self.save_path, "r")
		if file then
			for k, v in pairs(json.decode(file:read("*all"))) do
				if type(v) == type(self.settings[k]) then
					self.settings[k] = v
				else
					corrupt = true
					self:print_log("Error loading setting: " .. tostring(k) .. " (Wrong type)")
				end
			end
			file:close()
		end
		if corrupt then 
			self:Save()
		end
	end

	function WolfHUD:Save()
		local file = io.open(self.save_path, "w+")
		if file then
			file:write(json.encode(self.settings))
			file:close()
		end
	end
	
	function WolfHUD:createOverrides()
		local updates = {}
		for k, v in pairs(LuaModManager.Mods) do
			local info = v.definition
			if info["name"] == "WolfHUD" then
				self.version = info["version"]
				updates = info["updates"]
			end
		end
		for k, v in pairs(updates) do
			if type(v["revision"]) == "string" and not io.file_is_readable( v["revision"] ) then
				if v["identifier"] ~= "fed_inv" or WolfHUD.settings.use_federal_inventory then
					self:print_log("Creating Dummy for: " .. v["display_name"])
					if not file.DirectoryExists("./" .. v["install_dir"] .. v["install_folder"]) then
						os.execute('cmd /c mkdir "./' .. v["install_dir"] .. v["install_folder"] .. '"')
					end
					local file = io.open(v["revision"], "w+")
					if file then
						file:write("0")
						file:close()
					end
				end
			end
		end
	end
	
	function WolfHUD:getSetting(id, val_type)
		local value = self.settings[id]
		if value ~= nil and (not val_type or val_type == "color" and type(value) == "string" or type(value) == val_type) then
			local value = self.settings[id]
			if val_type == "color" then
				--return self.color_table[value].color
				for __, data in ipairs(self.color_table) do
					if data.name == value then
						return data.color
					end
				end
				return Color.white
			else
				return value
			end
		else
			self:print_log("Requested setting doesn't exists!  (id='" .. id .. "', type='" .. val_type .. "') ")
			if val_type == "number" then -- Try to prevent crash by giving default value
				return 1
			elseif val_type == "boolean" then 
				return false
			elseif val_type == "string" then 
				return ""
			elseif val_type == "color" then
				return Color.white
			end
		end
	end
	
	function WolfHUD:getColorID(name)
		if type(name) == "string" then
			for i, data in ipairs(WolfHUD.color_table) do
				if name == data.name then
					return i
				end
			end
		end
	end
	
	WolfHUD:Reset()
	WolfHUD:Load()
	
	WolfHUD:createOverrides()
end

if RequiredScript then
	local requiredScript = RequiredScript:lower()
	if WolfHUD.hook_files[requiredScript] then
		for __, file in ipairs(WolfHUD.hook_files[requiredScript]) do
			dofile( WolfHUD.mod_path .. "lua/" .. file )
		end
	end
end

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_WolfHUD", function(loc)
	if _G.PD2KR then
		loc:load_localization_file(WolfHUD.mod_path .. "loc/korean.txt")
	else
		for _, filename in pairs(file.GetFiles(WolfHUD.mod_path .. "loc/")) do
			local str = filename:match('^(.*).txt$')
			if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
				loc:load_localization_file(WolfHUD.mod_path .. "loc/" .. filename)
				break
			end
		end
	end
	loc:load_localization_file(WolfHUD.mod_path .. "loc/english.txt", false)
	
	if WolfHUD:getSetting("replace_weapon_names", "boolean") then
		loc:load_localization_file(WolfHUD.mod_path .. "loc/RealWeaponNames.txt")
	end
	
	if WolfHUD:getSetting("skip_blackscreen", "boolean") then
		loc:add_localized_strings({
			["hud_skip_blackscreen"] = ""
		})
	end
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_WolfHUD", function(menu_manager)
	
	-- Define Callback methods here
	MenuCallbackHandler.WolfHUD_Save = function(self, item)
		WolfHUD:Save()
	end
	
	MenuCallbackHandler.WolfHUD_Reset = function(self, item)
		local menu_title = managers.localization:text("wolfhud_reset_options_title")
		local menu_message = managers.localization:text("wolfhud_reset_options_confirm")
		local menu_options = {
			[1] = {
				text = managers.localization:text("dialog_yes"),
				callback = function(self, item)
					WolfHUD:Reset()
					for __, menu_id in ipairs(WolfHUD.menu_ids) do
						local menu = MenuHelper:GetMenu(menu_id)
						for __, menu_item in ipairs(menu._items) do
							local item_id = menu_item:parameters().name
							local value = WolfHUD:getSetting(tostring(item_id))
							if value ~= nil and menu_item.set_value then
								if menu_item._type == "toggle" then
									value = (value and "on" or "off")
								end
								menu_item:set_value(value)
								for __, clbk in pairs( menu_item:parameters().callback ) do
									clbk(menu_item)
								end
							end
						end
					end
					managers.viewport:resolution_changed()
				end,
			},
			[2] = {
				text = managers.localization:text("dialog_no"),
				is_cancel_button = true,
			},
		}
		QuickMenu:new( menu_title, menu_message, menu_options, true )
	end
	
	MenuCallbackHandler.clbk_change_setting = function(self, item)
		local value
		if item._type == "toggle" then
			value = (item:value() == "on")
		else
			value = item:value()
		end
		local name = item:parameters().name
		if name then
			WolfHUD.settings[name] = value
		end
	end
	
	MenuCallbackHandler.clbk_change_color_setting = function(self, item)
		local value = item:value()
		local name = item:parameters().name
		if name and type(value) == "number" then
			WolfHUD.settings[name] = WolfHUD.color_table[value].name
		end
	end
	
	MenuCallbackHandler.clbk_change_hudlist_setting = function(self, item)
		self:clbk_change_setting(item)
		local name = item:parameters().name
		if HUDManager then HUDManager:change_list_setting(tostring(name), WolfHUD:getSetting(name)) end
	end
	
	WolfHUD:Load()
	local settings = clone(WolfHUD.settings)
	for k, v in pairs(settings) do
		if type(v) == "string" then
			settings[k] = WolfHUD:getColorID(v) or v
		end
	end
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/options.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/gadgets.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/interaction.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/hud_enemy_healthbar.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/hud_damage_indicator.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/hud_info.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/hud_info_adv.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/hud_teampanels.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/hud_chat.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/hud_killcounter.json", WolfHUD, settings)
	MenuHelper:LoadFromJsonFile(WolfHUD.mod_path .. "menu/hud_drivinghud.json", WolfHUD, settings)
end)