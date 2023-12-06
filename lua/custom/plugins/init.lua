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
  { 'hashivim/vim-terraform',
    config = function ()
      vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
      vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
      vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
      vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
      vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
      vim.cmd([[let g:terraform_fmt_on_save=1]])
      vim.cmd([[let g:terraform_align=1]])
      vim.keymap.set("n", "<leader>ti", ":!terraform init<CR>", opts)
      vim.keymap.set("n", "<leader>tv", ":!terraform validate<CR>", opts)
      vim.keymap.set("n", "<leader>tp", ":!terraform plan<CR>", opts)
      vim.keymap.set("n", "<leader>taa", ":!terraform apply -auto-approve<CR>", opts)
    end,
  },
  { 'preservim/nerdtree',
    config = function ()
      vim.cmd([[let g:NERDTreeMinimalMenu=1]])
      vim.cmd("let g:NERDTreeIgnore=['\\.pyc$', '\\.pyo$', '\\.rbc$', '\\.rbo$', '\\.class$', '\\.o$', '\\~$']")
      vim.keymap.set("n", "<leader>n", ":NERDTreeToggle<CR>:NERDTreeMirror<CR>")

      vim.cmd([[
      " If the parameter is a directory, cd into it
      function! NERDTreeCdIfDirectory(directory)
        let explicitDirectory = isdirectory(a:directory)
        let directory = explicitDirectory || empty(a:directory)

        if explicitDirectory
          exe "cd " . fnameescape(a:directory)
        endif

        " Allows reading from stdin
        " ex: git diff | mvim -R -
        if strlen(a:directory) == 0
          return
        endif

        if directory
          NERDTree
          wincmd p
          bd
        endif

        if explicitDirectory
          wincmd p
        endif
      endfunction
      ]])

      vim.cmd([[
      " NERDTree utility function
      function NERDTreeUpdate(...)
        let stay = 0

        if(exists("a:1"))
          let stay = a:1
        end

        if exists("t:NERDTreeBufName")
          let nr = bufwinnr(t:NERDTreeBufName)
          if nr != -1
            exe nr . "wincmd w"
            exe substitute(mapcheck("R"), "<CR>", "", "")
            if !stay
              wincmd p
            end
          endif
        endif
      endfunction
      ]])

      vim.cmd([[augroup AuNERDTreeCmd]])
      vim.cmd([[autocmd AuNERDTreeCmd VimEnter * call NERDTreeCdIfDirectory(expand("<amatch>"))]])
      vim.cmd([[autocmd AuNERDTreeCmd FocusGained * call NERDTreeUpdate()]])

      -- -- open NERDTree upon opening vim
      -- vim.cmd([[
      --   autocmd vimenter * NERDTree
      -- ]])
      -- -- start cursor out of NERDTree
      -- vim.cmd([[
      --   autocmd VimEnter * wincmd p
      -- ]])

      -- open a NERDTree automatically when vim starts up if no files were specified
      vim.cmd([[autocmd StdinReadPre * let s:std_in=1]])
      vim.cmd([[autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && exists(":NERDTree") | NERDTree | endif]])

      -- shutdown vim if only window is a NERDTree window
      vim.cmd([[autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif]])
    end
  },
}
