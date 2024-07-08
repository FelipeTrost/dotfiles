local color_themes = {
  { "tiagovla/tokyodark.nvim",    "tokyodark",    { "dark" } },
  { "rebelot/kanagawa.nvim",      "kanagawa",     { "dark", "light" } },
  { "catppuccin/nvim",            "catppuccin",   { "dark", "light" } },
  { "ellisonleao/gruvbox.nvim",   "gruvbox",      { "dark", "light" } },
  { "kepano/flexoki-neovim",      "flexoki-dark", { "dark" } },
  { "bluz71/vim-nightfly-colors", "nightfly",     { "dark" } },
  { "rose-pine/neovim",           "rose-pine",    { "dark", "light" } },
  { "Mofiqul/dracula.nvim",       "dracula",      { "dark" } },
  { "NLKNguyen/papercolor-theme", "PaperColor",   { "dark", "light" } },
  { "jacoborus/tender.vim",       "tender",       { "dark" } },
  { "bluz71/vim-moonfly-colors",  "moonfly",      { "dark" } },
  { "Mofiqul/vscode.nvim",        "vscode",       { "dark" } },
  { "Scysta/pink-panic.nvim",     "pink-panic",   { "light" } },
  { "ray-x/aurora",               "aurora",       { "dark" } },
}

local picker_results = {}
for _, scheme in ipairs(color_themes) do
  if #scheme[3] == 1 then
    table.insert(picker_results, {
      name = scheme[2],
      scheme = scheme[2],
      background = scheme[3][1]
    })
  else
    for _, background in ipairs(scheme[3]) do
      table.insert(picker_results, {
        name = scheme[2] .. " " .. background,
        scheme = scheme[2],
        background = background
      })
    end
  end
end
local lazy_sources = {}
for _, scheme in ipairs(color_themes) do
  table.insert(lazy_sources, scheme[1])
end

return {
  color_themes[1][1],
  dependencies = lazy_sources,
  config = function()
    local Path         = require('plenary.path')
    local actions      = require('telescope.actions')
    local action_set   = require('telescope.actions.set')
    local action_state = require('telescope.actions.state')
    local finders      = require('telescope.finders')
    local pickers      = require('telescope.pickers')
    local conf         = require('telescope.config').values

    local config_path  = vim.fn.stdpath("data")
    local theme_config = string.format("%s/theme.json", config_path)

    local function read_config(local_config)
      return vim.json.decode(Path:new(local_config):read())
    end

    local hex = function(n)
      return string.format("\\#%06x", n)
    end

    local function set_theme(theme)
      vim.cmd.colorscheme(theme.scheme)
      vim.opt.background = theme.background

      Path:new(theme_config):write(vim.fn.json_encode(theme), 'w')

      if theme.background == "dark" and os.getenv("TERM") == "xterm-kitty" then
        local hlcolors = vim.api.nvim_get_hl(0, { name = "Normal" })
        local bg_dec = hlcolors.bg or 0
        local bg = hex(bg_dec)

        vim.cmd("silent ! kitty @ --to unix:/tmp/kitty set-colors background='" .. bg .. "'")
        vim.cmd("highlight Normal guibg=none")
      end
    end

    local ok, selected_theme = pcall(read_config, theme_config)
    if not ok then
      selected_theme = picker_results[1]
    end

    set_theme(selected_theme)

    local function pick_theme()
      local picker = pickers.new(require("telescope.themes").get_dropdown({}), {
        prompt_title    = 'Pick a theme :)',
        finder          = finders.new_table({
          results = picker_results,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.name,
              ordinal = entry.name,
            }
          end
        }),
        sorter          = conf.generic_sorter(),
        attach_mappings = function(prompt_bufnr)
          action_set.shift_selection:enhance({
            post = function()
              local selection = action_state.get_selected_entry()
              set_theme(selection.value)
            end,
          })

          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            set_theme(selection.value)
            actions.close(prompt_bufnr)
          end)


          return true
        end
      })
      picker:find()
    end

    vim.api.nvim_create_user_command('PickTheme', pick_theme, {})
  end,
}
