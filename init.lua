local g = vim.g
local opt = vim.opt

opt.fillchars = opt.fillchars + "diff:╱"

vim.o.completeopt = "menu,menuone,noselect"

vim.o.shell = '/opt/homebrew/bin/zsh -s'

g.mapleader = ";"
g.maplocalleader = ";"

vim.lsp.set_log_level('error')

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
    vim.lsp.buf.formatting_seq_sync(nil, 10000)
  end,
})

vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")

-- vim.g.Illuminate_ftblacklist = { 'NvimTree', 'NvimTree_1' }

local enable_providers = {
  "python3_provider",
  "node_provider",
  "ruby_provider",
  -- and so on
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

-- We don't want linting in node_modules
vim.cmd [[
  augroup Format
    autocmd BufRead,BufNewFile */node_modules/* lua vim.diagnostic.disable(0)
    autocmd BufRead,BufNewFile */tmp/* lua vim.diagnostic.disable(0)
    autocmd BufRead,BufNewFile *.astro set ft=astro
    autocmd BufRead,BufNewFile tsconfig.json setlocal filetype=jsonc
    autocmd BufWritePost Caddyfile silent !caddy fmt -overwrite %
    autocmd FileType css,less,scss setlocal iskeyword+=-
    autocmd FileType json set filetype=jsonc
    autocmd VimLeave * CopilotStop
  augroup END
]]

vim.cmd [[
      set exrc
      set secure
      set cmdheight=2
      set shortmess=AsIF
      set pumblend=20
      set nocursorline
      set wildignore+=*/vendor/*
      set wildignore+=*/node_modules/*
      set wildignore+=*/.yarn/*
      set wildignore+=*/.next/*
      set wildignore+=*/.turbo/*
      set wildignore+=*/.venv/*
      set t_ZH=^[[3m
      set t_ZR=^[[23m

      " Disable recording
      map q <Nop>

      let g:loaded_matchit = 1
      let g:far#source="rgnvim"
      let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
      let g:lastplace_ignore_buftype = "quickfix,nofile,help,nvimtree,NvimTree,Telescope,telescope"


      nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

      let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
      if executable(s:clip)
          augroup WSLYank
              autocmd!
              autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
          augroup END
      endif
      if has('wsl')
    let g:clipboard = {
          \   'name': 'wslclipboard',
          \   'copy': {
          \      '+': '/mnt/c/Windows/System32/win32yank.exe -i --crlf',
          \      '*': '/mnt/c/Windows/System32/win32yank.exe -i --crlf',
          \    },
          \   'paste': {
          \      '+': '/mnt/c/Windows/System32/win32yank.exe -o --lf',
          \      '*': '/mnt/c/Windows/System32/win32yank.exe -o --lf',
          \   },
          \   'cache_enabled': 1,
          \ }
endif

noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

    hi IndentBlanklineContextChar cterm=none gui=none guifg=#e5c07b

    augroup hi
      autocmd!
      autocmd BufReadPost * hi illuminatedword cterm=underline gui=underline
      autocmd BufReadPost * hi Folded guibg=#292f3b
      autocmd VimEnter set fillchars+=diff:╱
      autocmd BufReadPost * hi CursorWord cterm=italic gui=bold,underline guifg=none guibg=none
      autocmd BufReadPost * hi MatchWord cterm=italic gui=bold,underline guifg=none guibg=none
      autocmd BufReadPost * hi MatchParen cterm=italic gui=bold,underline guifg=none guibg=none
      autocmd BufReadPost * hi LspReferenceRead cterm=none gui=none guifg=none guibg=none
      autocmd BufReadPost * hi LspReferenceText cterm=none gui=none guifg=none guibg=none
      autocmd BufReadPost * hi LspReferenceWrite cterm=none gui=none guifg=none guibg=none
      autocmd BufReadPost * hi Comment gui=italic
      autocmd BufReadPost * silent! nunmap <leader>fÞ
      autocmd BufReadPost * silent! nunmap <leader>rÞ
      autocmd BufReadPost * silent! nunmap <leader>tÞ
      autocmd BufReadPost * silent! nunmap <leader>rÞ

    augroup end

    map <silent> <enter> :noh<cr>

    " Zoom
    function! s:zoom()
      if winnr('$') > 1
        tab split
      elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
            \ 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
      endif
    endfunction

    nnoremap <silent> <leader>z :call <sid>zoom()<cr>

    omap t <plug>(easymotion-bd-tl)
    vmap t <plug>(easymotion-bd-tl)
    map f <plug>(easymotion-fl)
    map f <plug>(easymotion-fl)

    autocmd User EasyMotionPromptBegin silent! LspStop
    autocmd User EasyMotionPromptEnd silent! LspStart

    " Show syntax highlighting groups for word under cursor
    nmap <F2> :call <SID>SynStack()<CR>
    function! <SID>SynStack()
        if !exists("*synstack")
            return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunc
]]
