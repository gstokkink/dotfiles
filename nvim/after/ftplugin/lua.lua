local opt = vim.opt_local

-- Do not continue comments after 'o' or 'O'
opt.formatoptions = opt.formatoptions:remove('o')
