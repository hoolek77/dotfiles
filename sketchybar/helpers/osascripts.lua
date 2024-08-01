local function build_disconnect_script(configuration)
	local disconnect_script = [[ osascript -e 'tell application "Tunnelblick" to disconnect "]]
		.. configuration
		.. [["']]

	return disconnect_script
end

local function build_connect_script(configuration)
	local connect_script = [[ osascript -e 'tell application "Tunnelblick" to connect "]] .. configuration .. [["']]

	return connect_script
end

local function build_get_current_configuration_state_script(configuration)
	local get_configuration_state_script = [[
          osascript -e 'tell application "Tunnelblick" to get state of first configuration where name = "]] .. configuration .. [["'
        ]]

	return get_configuration_state_script
end

local get_configuration_state_script = [[
  osascript -e 'tell application "Tunnelblick" to get state of first configurations'
]]

local get_configuration_names_script = [[
  osascript -e 'tell application "Tunnelblick" to get name of configurations'
]]

return {
	build_disconnect_script = build_disconnect_script,
	build_connect_script = build_connect_script,
	build_get_current_configuration_state_script = build_get_current_configuration_state_script,
	get_configuration_state_script = get_configuration_state_script,
	get_configuration_names_script = get_configuration_names_script,
}
