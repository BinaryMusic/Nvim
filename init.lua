-- Load core configurations
require "core"

-- Load custom initialization if it exists
local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]
if custom_init_path then
  dofile(custom_init_path)
end

-- Load custom key mappings
require("core.utils").load_mappings()

-- Set up Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

-- Load default configurations from cache
dofile(vim.g.base46_cache .. "defaults")

-- Prepend Lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load plugin configurations
require "plugins"

-- Optionally, set up additional configurations or autocommands here
-- For example:
 local function get_current_dir()
    local dir = vim.fn.getcwd()  -- Get the current working directory
    return dir
end

local function run_git_auto_push()
    local current_dir = get_current_dir()
    local command = string.format('bash ~/.config/nvim/git-auto-push.sh "%s"', current_dir)
    os.execute(command)  -- Execute the shell script with the current directory as argument
end

-- Create an autocommand to run the script on file save
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = run_git_auto_push,
})

