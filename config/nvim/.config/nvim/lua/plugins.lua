local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'preservim/nerdtree'
  use 'jiangmiao/auto-pairs'

  -- LaTeX
  use 'lervag/vimtex'
  use 'vim-latex/vim-latex'

  -- Colorschemes
  use 'morhetz/gruvbox'
end)

