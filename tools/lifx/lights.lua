local M = {}

local KEY = "cb449af73992faeda18008027356520258135f08b7165504fb32d3f111df7214"

-- local function toggleLlight(selector)
-- 	local cmd = string.format(
-- 		'curl -s -X PUT -H "Authorization: Bearer %s" -d "power=toggle" "https://api.lifx.com/v1/lights/%s/toggle"',
-- 		KEY,
-- 		selector
-- 	)
-- 	os.execute(cmd)
-- end

function M.init()
	local cmd = string.format('curl -s -H "Authorization: Bearer %s" "https://api.lifx.com/v1/lights/all"', KEY)
	local handle = io.popen(cmd)
	if handle == nil then
		vim.api.nvim_echo({ { "Error: io.open resulted in nil, please check\nAborting.", "Errormsg" } }, false, {})
	else
		local result = handle:read("*a")
		handle:close()
		vim.api.nvim_echo({ { result, "Errormsg" } }, false, {})
		local devices = {}
		for group, label, id, power in
			result:gmatch('"group":"([^"]+)".-"id":"([^"]+)".-"label":"([^"]+)".-"power":(%w+)')
		do
			table.insert(devices, {
				group = group,
				lable = label,
				id = id,
				power = power,
			})
		end

		for i, device in ipairs(devices) do
			print(
				string.format(
					"Device %d: group: %s, label: %s, id: %s, power: %s",
					i,
					device.group,
					device.label,
					device.id,
					device.power
				)
			)
		end
	end
end

-- vim.api.nvim_create_user_command("LifxDiscover", M.init, {})

return M
