local g = vim.g
local o = vim.o

-- Colors
o.termguicolors = true

-- Better editor UI
o.number = true
o.numberwidth = 5
o.relativenumber = false
o.signcolumn = 'yes:2'
-- o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.wrap = false
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'

-- Clipboard
o.clipboard = 'unnamedplus'

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

-- Remember 50 items in command line history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
-- o.jumpoptions = 'view'

-- Map <leader> to space
g.mapleader = ','
g.maplocalleader = ','
g.mouse = 'a'

