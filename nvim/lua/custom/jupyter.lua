-- agregar esto a tu init.lua o a un archivo de configuración
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.ju.py',
  callback = function()
    local path = vim.api.nvim_buf_get_name(0)
    -- jobstart para no bloquear el editor
    vim.fn.jobstart({ 'jupytext', '--sync', path }, { detach = true })
  end,
})

return {}
