return function()
  local function on_attach(client, b)
    -- vim.api.nvim_buf_set_keymap(
    --   b, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true}
    -- )
    -- vim.api.nvim_buf_set_keymap(
    --   b, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true}
    -- )
    -- vim.api.nvim_buf_set_option(b, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

  require("lean").setup {
    abbreviations = {
      compe = true;
    };
    mappings = false;
    infoview = {
      width = 50;
    };
    lsp = {
      on_attach = on_attach
    }
  }
end
