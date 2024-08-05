local opt = vim.opt

----------------------------
-- 
----------------------------
opt.laststatus = 2                      -- Staus bar always visible
opt.backspace = 'indent,eol,start'   -- Enable backspace do delete previous characters 
opt.shortmess = 'Imnrwx'
opt.swapfile = false     -- No swapfile
opt.sessionoptions = 'blank,buffers,curdir,folds,globals,localoptions,options,resize,tabpages,winsize,winpos'
opt.clipboard = 'unnamed'  -- Yank/Paste globally
opt.encoding = 'utf-8'                -- The encoding displayed.
opt.fileencoding = 'utf-8'            -- The encoding written to file.
opt.mouse = 'nicr'
opt.timeoutlen = 400



----------------------------
--      Tabs Options      --
----------------------------
opt.autoindent = true                -- Enables auto indenting
opt.smartindent = true               -- Enable Smart Indenting
opt.tabstop = 4                      -- Tab character equals 4 spaces
opt.expandtab = true                 -- Expands Tab's to spaces
opt.shiftwidth=4                     -- Indentation width for autoindent
opt.softtabstop=4                    -- Treat multiple spaces as a tab

opt.switchbuf = "usetab,newtab"      -- User existing tab if exist, otherwise new tab

----------------------------
--     Search Options     --
----------------------------
opt.incsearch = true                 -- Incremental search
opt.ignorecase = true                -- Ignore case in searches
opt.smartcase = true                 -- Disables ignorecase if uppercase characters appear in search term
opt.hls = false                      -- Disables highlighting search results...
vim.keymap.set('n', '<leader>h', ':let &hls=!&hls<CR>')


-----------------------------------
--     Diplay/Color  Options     --
-----------------------------------
opt.showmatch = true                 -- Briefly highlights matching brace/paranthese/bracket's
opt.visualbell = true                -- Enables visual bell, no beeping sound
opt.errorbells = false               -- Disables beeps

opt.ruler = true                     -- Displays cursor position in status line
opt.number = true                    -- Displays line numbers
opt.relativenumber = false           -- Show relative line numbers
opt.numberwidth = 5                  -- Number gutter width

opt.scrolloff=5                      -- 3 lines of offset when scrolling
opt.showcmd = true                   -- Show parcial commands in the status line
opt.showmode = true                  -- Show current mode which VIM is in

opt.wildmode = 'longest:full,full'   -- Tab completion command mode
opt.complete = '.,w,b,u,t'
opt.completeopt = 'longest,menuone'  -- Tab completion insert mode
opt.infercase = true

opt.startofline = false              -- Don't jump to begining of the line

opt.iskeyword = '@,48-57,_,192-255,-,@-@'

opt.whichwrap = '<,>,h,l,b'          -- Allow navigation with line wrapping

-- Alwasy show sign's gutter
--autocmd BufEnter * sign define dummy
--autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')


-- ------------------------------ "
--     Indent Folding Options     "
-- ------------------------------ "
opt.foldenable = true                -- Enables folding
opt.foldtext = 'nvim_treesitter#foldtext()'
opt.foldmethod = "expr"              -- Sets the folding method
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Utilize Treesitter folds
--opt.foldlevel = 20
opt.foldlevelstart = 99              -- Disable automatic folding on start

opt.bufhidden = 'hide'               -- Hide buffer when not in window

-- Automatically fold on file open!
-- vim.cmd.autocmd('BufRead * normal zM')


-- ------------------------------ "
--     Backup Files               "
-- ------------------------------ "
opt.backup = false                   -- Disable bakups of files
opt.writebackup = false              -- Disable writing backup files






-- Tab
opt.showtabline = 2

-- Line Wrapping
opt.wrap = false

-- Cursor Line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
vim.diagnostic.config {
  float = { border = "rounded" }, -- add border to diagnostic popups
}


-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of keyword
opt.iskeyword:append("-")

