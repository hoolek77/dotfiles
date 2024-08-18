local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local osascripts = require("helpers.osascripts")

local popup_width = 250

local is_connected = false

local vpn_icon = sbar.add("item", "widgets.vpn2", {
	position = "right",
	label = {
		align = "left",
		font = {
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
	},
	update_freq = 5,
})

local vpn_bracket = sbar.add("bracket", "widgets.vpn.bracket", {
	vpn_icon.name,
}, {
	background = { color = colors.bg1 },
	popup = { align = "center" },
})

sbar.add("item", "widgets.vpn.padding", {
	position = "right",
	width = settings.group_paddings,
})

local vpn_current_details = sbar.add("item", popup_width, {
	position = "popup." .. vpn_bracket.name,
	label = {
		string = "Details",
		width = popup_width,
		align = "center",
		font = {
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
	},
})

local function vpn_collapse_details()
	local drawing = vpn_bracket:query().popup.drawing == "on"
	if not drawing then
		return
	end
	vpn_bracket:set({ popup = { drawing = false } })
	sbar.remove("/vpn.device\\.*/")
end

local update_current_details = function()
	if is_connected then
		vpn_current_details:set({ label = { string = "Connected", color = colors.green } })
	else
		vpn_current_details:set({ label = { string = "Disconnected", color = colors.red } })
	end
end

local update_vpn_icon = function()
	if is_connected then
		vpn_icon:set({ icon = icons.vpn.connected, label = "ON" })
	else
		vpn_icon:set({ icon = icons.vpn.disconnected, label = "OFF" })
	end
end

local function vpn_toggle_details()
	local should_draw = vpn_bracket:query().popup.drawing == "off"
	if should_draw then
		vpn_bracket:set({ popup = { drawing = true } })

		update_current_details()

		sbar.exec(osascripts.get_configuration_names_script, function(output)
			local configurations = {}

			for configuration in string.gmatch(output, "[^\r\n]+") do
				table.insert(configurations, configuration)
			end

			local counter = 0

			for _, configuration in ipairs(configurations) do
				sbar.exec(osascripts.build_get_current_configuration_state_script(configuration), function(state)
					local click_script = nil

					local is_configuration_connected = state:match("CONNECTED")

					local vpn_config = sbar.add("item", "vpn.device." .. counter, {
						position = "popup." .. vpn_bracket.name,
						width = popup_width,
						align = "center",
						label = { string = configuration, color = colors.grey },
						click_script = click_script,
					})

					if is_configuration_connected then
						vpn_config:set({ label = { string = configuration, color = colors.white } })
					end

					vpn_config:subscribe("mouse.clicked", function()
						if is_configuration_connected then
							sbar.exec(osascripts.build_disconnect_script(configuration), function()
								is_connected = false

								vpn_config:set({ label = { string = configuration, color = colors.grey } })
							end)
						else
							sbar.exec(osascripts.build_connect_script(configuration), function()
								vpn_collapse_details()
							end)
						end

						update_vpn_icon()
					end)

					counter = counter + 1
				end)
			end
		end)
	else
		vpn_collapse_details()
	end
end

local function update()
	sbar.exec(osascripts.get_configuration_state_script, function(output)
		is_connected = output:match("CONNECTED")

		update_vpn_icon()
	end)
end

vpn_icon:subscribe("routine", update)
vpn_icon:subscribe("forced", update)

vpn_icon:subscribe("mouse.clicked", vpn_toggle_details)
vpn_icon:subscribe("mouse.exited.global", vpn_collapse_details)
