local plugin = {name = "lightbulb"}
Plugins[plugin.name] = plugin

function plugin.settings()
	vim.cmd [[autocmd CursorHold * lua Plugins.lightbulb.run()]]
end

function plugin.run()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local x = 5
  require("nvim-lightbulb").update_lightbulb {
    sign = {
      enabled = false
    },
    float = {
      enabled = true,
      text = "💡",
      win_opts = {
        winblend = 100,
        offset_x = -cursor[2] - 3,
        anchor = "SW",
      }
    }
  }
end

return function()
  Plugins.lightbulb.settings()
end

