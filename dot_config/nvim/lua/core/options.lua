# Set :Explore view to 3: tree style listing
vim.cmd("let g:netrw_liststyle = 3")

local set = vim.opt

-- If in Insert, Replace or Visual mode put a message on the last line.
set.showmode = true

-- When a bracket is inserted, briefly jump to the matching one.
set.showmatch = true

-- If the 'ignorecase' option is on, the case of normal letters is ignored.
set.ignorecase = true

-- Override the 'ignorecase' option if the search pattern contains upper case characters.
set.smartcase = true

-- While typing a search command, show where the pattern, as it was typed so far, matches.
set.incsearch = true

-- When there is a previous search pattern, highlight all its matches.
set.hlsearch = true

-- Write the contents of the file, if it has been modified, on each `:next`, `:rewind`, `:last`, `:first`, ...
set.autowrite = true

-- When on a buffer becomes hidden when it is |abandon|ed.
set.hidden = true

-- Highlight the text line of the cursor with CursorLine |hl-CursorLine|.
set.cursorline = true

-- Shows tabs and trailing spaces with specific characters, highlighting them for easy identification.
set.list = true
set.listchars = { tab = "»·", trail = "·", precedes = "<", extends = ">" }

-- If 'modeline' is off or 'modelines' is zero no lines are checked.  See |modeline|.
set.modeline = false
set.modelines = 0

--  Number of spaces that a <Tab> in the file counts for.
set.tabstop = 2

-- Number of spaces to use for each step of (auto)indent.
set.shiftwidth = 2

-- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set.smarttab = true

-- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
set.expandtab = true

-- Copy indent from current line when starting a new line.
set.autoindent = true

-- Do smart autoindenting when starting a new line.  Works for C-like programs, but can also be used for other languages.
set.smartindent = true

-- When on, the mouse pointer is hidden when characters are typed.
set.mousehide = true

-- Disalbe all mouse support
set.mouse = ""

-- If you write to an existing file (but do not append) while the 'backup',
-- 'writebackup' or 'patchmode' option is on, a backup of the original file is made.
set.backup = true

-- When off lines will not wrap and only part of long lines will be displayed.
set.wrap = false

if vim.g.vscode then
  -- Vritual editing doesn't work well with vscode
else
  -- Allow virtual editing in all modes.
  set.virtualedit = "all"
end

-- When this option is set, the screen will not be redrawn while executing macros, registers and other commands that have not been typed.
set.lazyredraw = true

-- Sets the number of command-lines in history
set.history = 999

-- Minimal number of screen lines to keep above and below the cursor.
set.scrolloff = 3

-- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
set.sidescrolloff = 3

-- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
set.wildmenu = true
set.wildmode = { "longest", "list", "full" }

-- Completion menu options
set.completeopt = { "menuone", "noselect" }

-- Maximum width of text that is being inserted.
set.textwidth = 80

-- 'colorcolumn' is a comma-separated list of screen columns that are highlighted with ColorColumn |hl-ColorColumn|.
set.colorcolumn = "+1"

-- Insert two spaces after a '.', '?' and '!' with a join command. Otherwise only one space is inserted.
set.joinspaces = false

-- When on, splitting a window will put the new window right of the current one. |:vsplit|
set.splitright = true

-- When on, splitting a window will put the new window below the current one. |:split|
set.splitbelow = true

set.softtabstop = 2

-- Precede each line with its line number.
set.number = true

-- Show the line number relative to the line with the cursor in front of each line.
set.relativenumber = true

-- Live preview of the search and replace result as you type.
set.inccommand = "nosplit"

-- Keeps the sign column always visible, preventing text shifting when signs appear.
set.signcolumn = "yes"

-- Enables 24-bit RGB color in the |TUI|.
set.termguicolors = true

-- When set to "dark" or "light", adjusts the default color groups for that background type.
set.background = "dark"

--When on, Vim automatically saves undo history to an undo file when writing
--a buffer to a file, and restores undo history from the same file on buffer read.
set.undofile = true

-- Set special directories for nvim in home dir
set.backupdir = vim.fn.expand("~/.nvim/backup//")

-- Set swap file directory in ~/.nvim/swap
set.directory = vim.fn.expand("~/.nvim/swap//")

-- Enable undo files and set the undo directory in ~/.nvim/undo
set.undodir = vim.fn.expand("~/.nvim/undo//")

-- Create the directories automatically if they don't exist
local dirs = { "~/.nvim/backup", "~/.nvim/swap", "~/.nvim/undo" }
for _, dir in ipairs(dirs) do
  if vim.fn.isdirectory(vim.fn.expand(dir)) == 0 then
    vim.fn.mkdir(vim.fn.expand(dir), "p")
  end
end
