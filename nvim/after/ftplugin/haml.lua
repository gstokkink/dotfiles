local opt = vim.opt

-- Do not continue comments after 'o' or 'O'
opt.formatoptions = opt.formatoptions:remove('o')
