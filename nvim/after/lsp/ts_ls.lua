local supported_plugins = {
	"typescript-svelte-plugin",
}

local function find_node_modules_dirs(root_dir)
	return vim.fn.systemlist({ "find", root_dir, "-name", "node_modules", "-prune", "-print" })
end

local function discover_plugins(root_dir)
	local plugins = {}
	for _, node_modules_dir in ipairs(find_node_modules_dirs(root_dir)) do
		for _, name in ipairs(supported_plugins) do
			local location = node_modules_dir .. "/" .. name
			if vim.uv.fs_stat(location) then
				table.insert(plugins, { name = name, location = location })
			end
		end
	end
	return plugins
end

return {
	before_init = function(initialize_params, config)
		local plugins = discover_plugins(config.root_dir)
		if #plugins == 0 then
			return
		end
		initialize_params.initializationOptions =
			vim.tbl_deep_extend("force", initialize_params.initializationOptions or {}, {
				plugins = plugins,
			})
	end,
}
