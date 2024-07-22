local actions      = require('telescope.actions')
local action_set   = require('telescope.actions.set')
local action_state = require('telescope.actions.state')
local finders      = require('telescope.finders')
local pickers      = require('telescope.pickers')
local conf         = require('telescope.config').values

local function set_bg(image_path)
  -- TODO: maybe store
  vim.loop.spawn("kitty", {
    args = vim.split("@ --to unix:/tmp/kitty set-background-image " .. image_path, " "),
    stdio = { nil, nil, nil },
  })
end

local function get_images()
  local path = "~/Pictures/nvim"
  local imageResults = vim.fn.system("find " .. path .. " -name \"*.png\"")
  return vim.split(imageResults, '\n')
end

local function get_image_name(image_path)
  local parts = vim.split(image_path, "/")
  return parts[#parts]
end

local function pick_bg()
  local picker = pickers.new(require("telescope.themes").get_dropdown({}), {
    prompt_title    = 'Pick a background ;)',
    finder          = finders.new_table({
      results = get_images(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = get_image_name(entry),
          ordinal = get_image_name(entry),
        }
      end
    }),
    sorter          = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr)
      action_set.shift_selection:enhance({
        post = function()
          local selection = action_state.get_selected_entry()
          set_bg(selection.value)
        end,
      })

      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        set_bg(selection.value)
        actions.close(prompt_bufnr)
      end)


      return true
    end
  })
  picker:find()
end

vim.api.nvim_create_user_command('Background', pick_bg, {})
