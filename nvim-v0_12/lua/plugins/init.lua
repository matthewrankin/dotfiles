-- Auto-require all plugin files in this directory
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
  if file:match("%.lua$") and file ~= "init.lua" then
    local module = "plugins." .. file:gsub("%.lua$", "")
    require(module)
  end
end
