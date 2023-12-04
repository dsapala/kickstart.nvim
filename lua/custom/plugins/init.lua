-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'Olical/conjure', },
  { 'guns/vim-sexp' },
  { 'tpope/vim-sexp-mappings-for-regular-people' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim' },
  {
    'lambdalisue/fern.vim',
    config = function ()
      vim.keymap.set('n', '<leader>F', ':Fern .<cr>', {})
    end,
  },
}
