function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(
    mode, shortcut, command, { noremap = true, silent = true }
  )
end

function map_loud(mode, shortcut, command)
  vim.api.nvim_set_keymap(
    mode, shortcut, command, { noremap = true, silent = false }
  )
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function nmap_loud(shortcut, command)
  map_loud('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end


------BASICS--------------------------------------------------------------------

vim.opt.scrolloff = 10 -- keep 10 lines above and below the cursor
vim.opt.ignorecase = true -- ignore case when searching
vmap('p', 'pgvy')  -- remember copied text after pasting

vim.opt.equalalways = false -- don't resize windows when splitting

vim.api.nvim_create_autocmd({'BufWinEnter'}, {
  desc = 'return cursor to where it was last time closing the file',
  pattern = '*',
  command = 'silent! normal! g`"zv',
})

vim.opt.exrc = true -- enable per-directory .vimrc and .lua files


------VISUAL--------------------------------------------------------------------

vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show line numbers relative to the current line
vim.opt.showmatch = true -- show the matching for [], {} and ()
vim.opt.showmode = false -- don't show the mode, we have a statusline for that
vim.opt.breakindent = true -- keep indent when breaking lines, used with wrap

-- show special characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', nbsp = '␣' }

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
nmap('<Esc>', ':nohlsearch<CR>')

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup(
    'kickstart-highlight-yank', { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})


------INDENTATION---------------------------------------------------------------

vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = 'lua',
  command = 'setlocal shiftwidth=2 tabstop=2 expandtab',
})

vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = 'python',
  command = 'setlocal colorcolumn=120',
})

vim.opt.tabstop = 4 -- number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent


------MAPPINGS------------------------------------------------------------------

nmap('<', '<<')  -- indent left
nmap('>', '>>')  -- indent right

nmap('<tab>', ':bnext<CR>')  -- switch to next buffer
nmap('<S-tab>', ':bprevious<CR>')  -- switch to previous buffer

nmap('<Up>', ':resize +2<CR>')  -- increase window height
nmap('<Down>', ':resize -2<CR>')  -- decrease window height
nmap('<Left>', ':vertical resize +2<CR>')  -- increase window width
nmap('<Right>', ':vertical resize -2<CR>')  -- decrease window width

imap('<C-Space>', '<C-n><C-p>')  -- autocomplete
imap('<C-J>', '<C-N>')  -- move to next completion item
imap('<C-K>', '<C-P>')  -- move to previous completion item

map('t', '<A-h>', '<C-\\><C-N><C-w>h')  -- move to the left window
map('t', '<A-j>', '<C-\\><C-N><C-w>j')  -- move to the bottom window
map('t', '<A-k>', '<C-\\><C-N><C-w>k')  -- move to the top window
map('t', '<A-l>', '<C-\\><C-N><C-w>l')  -- move to the right window
imap('<A-h>', '<C-\\><C-N><C-w>h')  -- move to the left window
imap('<A-j>', '<C-\\><C-N><C-w>j')  -- move to the bottom window
imap('<A-k>', '<C-\\><C-N><C-w>k')  -- move to the top window
imap('<A-l>', '<C-\\><C-N><C-w>l')  -- move to the right window

vim.g.tmux_navigator_no_mappings = 1

nmap('<A-h>', ':TmuxNavigateLeft<CR>')  -- move to the left tmux pane
nmap('<A-j>', ':TmuxNavigateDown<CR>')  -- move to the bottom tmux pane
nmap('<A-k>', ':TmuxNavigateUp<CR>')  -- move to the top tmux pane
nmap('<A-l>', ':TmuxNavigateRight<CR>')  -- move to the right tmux pane


------LEADER--------------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

nmap('<space>', '<Nop>')  -- unmap space
nmap('<C-Space>', '<Nop>')  -- unmap space

nmap_loud('<leader>b', ':Bwipeout!<CR>')  -- delete buffer
nmap_loud('<leader>s', ':mksession! s.vim<CR>')  -- save session

nmap('<leader>e', ':NERDTreeToggle<CR>')  -- toggle NERDTree
nmap('<leader>r', ':NERDTreeFind<CR>')  -- find file in NERDTree

nmap('<leader>y', '"+y')  -- copy to clipboard
vmap('<leader>y', '"+y')  -- copy to clipboard
nmap('<leader>p', '"+p')  -- paste from clipboard


------PLUGINS-------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- "neovim/nvim-lspconfig",
  -- "HallerPatrick/py_lsp.nvim",
  "moll/vim-bbye",                    --delete buffer without closing window
  "Vimjas/vim-python-pep8-indent",    --python indenting
  "tpope/vim-fugitive",               --git commands
  "scrooloose/nerdtree",              --file tree
  "github/copilot.vim",               --github copilot
  "christoomey/vim-tmux-navigator",   --navigate between tmux panes
  "ggandor/leap.nvim",                --jump using s
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
  },
  {
    "kylechui/nvim-surround",         -- <leader>z]} to change [hello] to {hello}
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert          = '<C-s>z',
          insert_line     = '<C-s>Z',
          normal          = '<leader>z',
          normal_cur      = '<leader>Z',
          normal_line     = '<leader>zz',
          normal_cur_line = '<leader>ZZ',
          visual          = '<leader>z',
          visual_line     = '<leader>Z',
          delete          = '<leader>zd',
          change          = '<leader>zc',
        }
      })
    end
  },
  {
    "windwp/nvim-autopairs",
    config = true,
  },
  {
    "vim-airline/vim-airline",
    dependencies = { 'vim-airline/vim-airline-themes' }
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.7',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { "Wansmer/treesj", dependencies= { "nvim-treesitter/nvim-treesitter" } },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "c",
          "cpp",
          "python",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = false },  
      })
    end
  },
  "habamax/vim-nod",
  -- {
  --   "dccsillag/magma-nvim",
  --   build = ":UpdateRemotePlugins",
  -- }
  {
    'glacambre/firenvim',
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
        vim.fn["firenvim#install"](0)
    end
  },
  {
    -- 'mkusm/nvim-papyrus',
    dir='/home/mk/private/projects/nvim-papyrus',
    config = function()
      vim.g.skyrim_install_path = 'D:\\SteamLibrary\\steamapps\\common\\Skyrim Special Edition'
    end

  }
})

vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never",
            filename = "/tmp/{hostname}_{pathname%10}.py",
        }
    }
}

require('CopilotChat').setup()
nmap('<leader>cc', ':CopilotChat<CR>')
nmap('<leader>cp', ':Copilot panel<CR>')  -- copilot panel
vim.keymap.set('i', '<C-f>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
imap('<C-g>', '<Plug>(copilot-accept-word)')
imap('<C-b>', '<Plug>(copilot-accept-line)')

-- require'lspconfig'.pyright.setup{}
-- require'py_lsp'.setup{}

-- local configs = require('lspconfig/configs')
-- local util = require('lspconfig/util')
-- local path = util.path
-- local function get_python_path(workspace)
--   -- Use activated virtualenv.
--   if vim.env.VIRTUAL_ENV then
--     return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
--   end
--
--   -- Find and use virtualenv in workspace directory.
--   for _, pattern in ipairs({'*', '.*'}) do
--     local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
--     if match ~= '' then
--       return path.join(path.dirname(match), 'bin', 'python')
--     end
--   end
--
--   -- Fallback to system Python.
--   return exepath('python3') or exepath('python') or 'python'
-- end
--
-- require'lspconfig'.pyright.setup({
--   -- ...
--   before_init = function(_, config)
--     config.settings.python.pythonPath = get_python_path(config.root_dir)
--   end
-- })

require'leap'.create_default_mappings()

local builtin = require('telescope.builtin')
local is_inside_work_tree = {}
project_files = function()
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

nmap('<leader>ft', ':Telescope<CR>')
vim.keymap.set('n', '<leader>ff', project_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'find string under cursor' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live grep' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'help tags' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'list buffers' })
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ['dd'] = require('telescope.actions').delete_buffer
      },
    },
  },
}

vim.keymap.set('n', '<leader>m', require('treesj').toggle, { desc = 'toggle split/join' })

nmap('<leader>w', ':WhichKey<CR>')
require("which-key").register(mappings, opts)


------FIRENVIM------------------------------------------------------------------

if vim.g.started_by_firenvim == true then
  vim.o.laststatus = 0
  vim.g.airline_theme = 'firenvim'
  vim.cmd('AirlineToggle')
  vim.o.guifont = 'JetBrainsMono NF:h10'
  -- vim.cmd('NERDTreeToggle')
else
  vim.g["airline_theme"] = 'term'
  -- vim.g["airline_theme"] = 'catppuccin'
  vim.g["airline#extensions#branch#enabled"] = 0  -- disable git branch
  vim.g["airline#extensions#tabline#enabled"] = 1  -- enable list of buffers
  -- don't hide terminal buffers in the list of buffers
  vim.g["airline#extensions#tabline#ignore_bufadd_pat"] = 'tagbar'
  -- show only the tail of filename in the list of buffers
  vim.g["airline#extensions#tabline#fnamemod"] = ':t'

  vim.cmd.colorscheme 'catppuccin'
  vim.cmd.colorscheme 'default'
end
