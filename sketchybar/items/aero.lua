local colors = require("colors")
local sbar = require("sketchybar")
local app_icons = require("helpers.app_icons")

local LIST_MONITORS = "aerospace list-monitors | awk '{print $1}'"
local LIST_WORKSPACES = "aerospace list-workspaces --monitor %s --empty no"
local LIST_FOCUSED_WORKSPACE = "aerospace list-workspaces --focused"
local LIST_FOCUSED_MONITOR = "aerospace list-monitors --focused --format %{monitor-id}"

local EMPTY_WORKSPACE_ICON = " -"
local NOT_FOUND_APP = ":default:"

local spaces = {}

local function getIconForApp(appName)
	return app_icons[appName] or NOT_FOUND_APP
end

local updateIconStrip = function(spaceId)
	local LIST_APPS = "aerospace list-windows --workspace " .. spaceId .. " --format %{app-name}"
	local LIST_APPS_AND_OUTPUT = "output=$(" .. LIST_APPS .. '); [ -z "$output" ] && echo "EMPTY" || echo "$output"'

	local icon_strip = " "

	sbar.exec(LIST_APPS_AND_OUTPUT, function(appsOutput)
		for app in appsOutput:gmatch("[^\r\n]+") do
			if app == "EMPTY" then
				icon_strip = EMPTY_WORKSPACE_ICON
				break
			end
			icon_strip = icon_strip .. " " .. getIconForApp(app)
		end

		if icon_strip == " " then
			icon_strip = EMPTY_WORKSPACE_ICON
		end

		local workspace = spaces[spaceId]

		if workspace then
			workspace:set({ label = { string = icon_strip } })
		end
	end)
end

local function addSpace(spaceId, monitorId, focused)
	if not spaces[spaceId] then
		local space = sbar.add("space", "space_" .. spaceId, {
			icon = {
				string = spaceId,
				highlight_color = colors.red,
				padding_left = 15,
				padding_right = 8,
			},
			label = {
				font = "sketchybar-app-font:Regular:16.0",
				color = colors.grey,
				highlight_color = colors.white,
				padding_right = 20,
				y_offset = -1,
			},
			padding_left = 2,
			padding_right = 2,
			background = {
				color = colors.bg1,
				border_color = colors.bg2,
				border_width = 2,
			},
			display = monitorId,
		})

		space:subscribe("mouse.clicked", function()
			local CHANGE_WORKSPACE = "aerospace workspace %s"

			sbar.exec(CHANGE_WORKSPACE:format(spaceId))
		end)

		spaces[spaceId] = space
	end

	local space = spaces[spaceId]

	space:set({
		icon = { highlight = focused },
		label = { highlight = focused },
		background = { border_color = focused and colors.white or colors.bg2 },
		display = monitorId,
	})

	updateIconStrip(spaceId)
end

local function removeWorkspace(workspaceId)
	if spaces[workspaceId] then
		sbar.remove("space_" .. workspaceId)
		spaces[workspaceId] = nil
	end
end

local spaceCreator = sbar.add("item", "space_creator", {
	icon = {
		string = "􀆊",
		font = "$FONT:Heavy:16.0",
		color = colors.white,
		drawing = "off",
	},
})

function Tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\r\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\r\n'
		elseif type(v) == "table" then
			toprint = toprint .. Tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

spaceCreator:subscribe("aerospace_focus_change", function(env)
	print("focus", Tprint(env))
end)

spaceCreator:subscribe("aerospace_workspace_change", function(env)
	print("workspace", Tprint(env))
	local prev = env.PREVIOUS_FOCUSED_WORKSPACE
	local new = env.FOCUSED_WORKSPACE

	if prev == new then
		return
	end

	local prevSpace = spaces[prev]
	local newSpace = spaces[new]

	if prevSpace then
		prevSpace:set({
			icon = { highlight = false },
			label = { highlight = false },
			background = { border_color = colors.border },
		})

		local prevSpaceIcon = prevSpace:query().label.value

		if prevSpaceIcon == EMPTY_WORKSPACE_ICON then
			removeWorkspace(prev)
		end
	end

	if newSpace then
		newSpace:set({
			icon = { highlight = true },
			label = { highlight = true },
			background = { border_color = colors.white },
		})

		updateIconStrip(new)
	else
		sbar.exec(LIST_FOCUSED_MONITOR, function(focusedMonitorOutput)
			local focusedMonitor = focusedMonitorOutput:gsub("^%s*(.-)%s*$", "%1")

			addSpace(new, focusedMonitor, true)
		end)
	end
end)

spaceCreator:subscribe("aerospace_workspace_monitor_change", function()
	sbar.exec(LIST_FOCUSED_WORKSPACE, function(focusedWorkspaceOutput)
		local focusedWorkspace = focusedWorkspaceOutput:gsub("^%s*(.-)%s*$", "%1")

		local space = spaces[focusedWorkspace]

		if not space then
			return
		end

		sbar.exec(LIST_FOCUSED_MONITOR, function(focusedMonitorOutput)
			local focusedMonitor = focusedMonitorOutput:gsub("^%s*(.-)%s*$", "%1")

			space:set({ display = focusedMonitor })
		end)
	end)
end)

local function drawSpaces()
	sbar.exec(LIST_MONITORS, function(monitorsOutput)
		for monitorId in monitorsOutput:gmatch("[^\r\n]+") do
			sbar.exec(LIST_FOCUSED_WORKSPACE, function(focusedWorkspaceOutput)
				local focusedWorkspace = focusedWorkspaceOutput:gsub("^%s*(.-)%s*$", "%1")

				sbar.exec(LIST_WORKSPACES:format(monitorId), function(workspacesOutput)
					for workspaceId in workspacesOutput:gmatch("[^\r\n]+") do
						addSpace(workspaceId, monitorId, workspaceId == focusedWorkspace)
					end
				end)
			end)
		end
	end)
end

drawSpaces()
