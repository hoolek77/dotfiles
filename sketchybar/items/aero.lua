local colors = require("colors")
local sbar = require("sketchybar")
local app_icons = require("helpers.app_icons")

local LIST_MONITORS = "aerospace list-monitors | awk '{print $1}'"
local LIST_WORKSPACES = "aerospace list-workspaces --monitor %s --empty no"
local LIST_EMPTY_WORKSPACES = "aerospace list-workspaces --monitor %s --empty"
local LIST_FOCUSED_WORKSPACE = "aerospace list-workspaces --focused"

local spaces = {}

local function getIconForApp(appName)
	return app_icons[appName]
end

local function addSpace(spaceId, monitorId, focused)
	if not spaces[spaceId] then
		print("space_" .. spaceId)
		local space = sbar.add("space", "space_" .. spaceId, {
			icon = {
				string = spaceId,
				highlight_color = colors.red,
				padding_left = 10,
				padding_right = 10,
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
				border_width = 1,
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

	local LIST_APPS = "aerospace list-windows --workspace %s | awk -F'|' '{gsub(/^ *| *$/, \"\", $2); print $2}'"

	local icon_strip = " "

	sbar.exec(LIST_APPS:format(spaceId), function(appsOutput)
		for app in appsOutput:gmatch("[^\r\n]+") do
			icon_strip = icon_strip .. " " .. getIconForApp(app)
		end

		if icon_strip == " " then
			icon_strip = " —"
		end

		space:set({ label = { string = icon_strip } })
	end)
end

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

				sbar.exec(LIST_EMPTY_WORKSPACES:format(monitorId), function(emptyWorkspacesOutput)
					for workspaceId in emptyWorkspacesOutput:gmatch("[^\r\n]+") do
						if spaces[workspaceId] then
							sbar.remove("space_" .. workspaceId)
							spaces[workspaceId] = nil
						end
					end
				end)
			end)
		end
	end)
end

drawSpaces()

local spaceCreator = sbar.add("item", "space_creator", {
	icon = {
		string = "􀆊",
		font = "$FONT:Heavy:16.0",
		color = colors.white,
		drawing = "off",
	},
})

function tprint(tbl, indent)
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
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

spaceCreator:subscribe("aerospace_workspace_change", function(env)
	print(tprint(env))
	drawSpaces()
end)
