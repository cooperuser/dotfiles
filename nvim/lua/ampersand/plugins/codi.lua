return function()
  vim.g["codi#virtual_text"] = 0
  vim.g["codi#rightsplit"] = 0
  vim.g["codi#autocmd"] = "InsertLeave"

  K.q {"C", "<cmd>Codi!!<CR>"}
end
