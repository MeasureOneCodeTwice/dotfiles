-- =========================
-- Leader
-- =========================
vim.g.mapleader = " "

-- =========================
-- Options
-- =========================
local opt = vim.opt

opt.showmatch = true
opt.ignorecase = true
opt.mouse = "a"
opt.hlsearch = true
opt.incsearch = true
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.autoindent = true
opt.number = true
opt.relativenumber = true
opt.wildmode = "longest,list"
opt.formatoptions:remove({ "c", "r", "o" })
-- Supposed to fix DSR issue
opt.termguicolors = true
vim.o.background = "dark"
vim.o.ttyfast = true       -- Tells Nvim the connection is fast
vim.o.timeout = true
vim.o.timeoutlen = 300     -- Global timeout
vim.o.ttimeoutlen = 10     -- Specifically for key/escape sequences

-- =========================
-- Keymap
-- =========================
local map = vim.keymap.set

map("n", ";", ":")
map("n", "<leader>p", '"0p')
map("n", "<leader>P", '"0P')
map("n", "<leader>bp", "<cmd>bp<CR>")
map("n", "<leader>bn", "<cmd>bn<CR>")

-- =========================
-- Colorscheme
-- =========================
vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "Gray" })
vim.api.nvim_set_hl(0, "Conceal", { fg = "DarkGray" })

vim.g.indentLine_char = "▏"

-- =========================
-- lazy.nvim bootstrap
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
   vim.system({
     "git",
     "clone",
     "--filter=blob:none",
     "https://github.com/folke/lazy.nvim",
     lazypath,
   }):wait()
end

vim.opt.rtp:prepend(lazypath)

-- =========================
-- Plugins
-- =========================
require("lazy").setup({
   -- basics
   "tpope/vim-surround",
   "tpope/vim-commentary",
   "tpope/vim-repeat",
   "tpope/vim-fugitive",
   "tpope/vim-sleuth",
   "andymass/vim-matchup",
   "mbbill/undotree",

   -- colors
   "rafi/awesome-vim-colorschemes",

   -- LSP + formatting
   "neovim/nvim-lspconfig",
   "stevearc/conform.nvim",
   "esmuellert/nvim-eslint",

   -- treesitter
   { "nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },

   -- telescope
   {
     "nvim-telescope/telescope.nvim",
     dependencies = { "nvim-lua/plenary.nvim" },
   },

   -- file explorer
   "stevearc/oil.nvim",

   -- misc
   "lervag/vimtex",
   "ellisonleao/glow.nvim",
   "andythigpen/nvim-coverage",


   {
     'MeanderingProgrammer/render-markdown.nvim',
     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
   },
})

-- =========================
-- Plugin configs
-- =========================
vim.cmd([[colorscheme gruvbox]])

-- conform
require("conform").setup({
   formatters_by_ft = {
     java = { "google-java-format" },
   },
})

map("n", "<space>f", function()
   require("conform").format({ async = true })
   vim.notify("formatted")
end)

-- LSP
-- vim.lsp.config("clangd", {})
-- vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})

-- vim.lsp.config("jdtls", {
--   cmd = { "jdtls" },
--   root_dir = vim.fs.root(0, { "pom.xml", "build.gradle", ".git" }),
-- })
-- vim.lsp.enable({ "clangd", "pyright", "jdtls", "bashls" })-- diagnostics
vim.lsp.enable({ "bashls" })-- diagnostics

vim.diagnostic.config({
   virtual_text = true,
   underline = true,
   signs = true,
   update_in_insert = false,
})


-- treesitter
require("nvim-treesitter").setup({
   highlight = { enable = true },
})

require("nvim-eslint").setup({
   settings = {
      -- Monorepo: eslint.config.js and its node_modules live in kross/src/,
      -- one level above each package (backend/, webserver/). The default
      -- workingDirectory (workspace/git root) can't see child node_modules,
      -- so pin it to the nearest package.json ancestor per buffer instead.
      workingDirectory = function(bufnr)
         return { directory = vim.fs.root(bufnr, { "package.json" }) }
      end,
   },
})

-- oil
require("oil").setup({
   view_options = {
     show_hidden = true,
   },
})

map("n", "-", require("oil").open, { desc = "Open parent directory" })

-- telescope
require("telescope").setup{
   defaults = {
      layout_config = { 
         height = 0.95,
         width = 0.95,
      },
   }
}

local builtin = require("telescope.builtin")
local function grep_quickfix()
    local qf_items = vim.fn.getqflist()
    local lines = {}
    local seen = {}

    for _, item in ipairs(qf_items) do
        local fname = vim.api.nvim_buf_get_name(item.bufnr)
        if fname ~= "" and not seen[fname] then
            table.insert(lines, fname)
            seen[fname] = true
        end
    end

    if #lines == 0 then
        print("Quickfix list is empty!")
        return
    end

    builtin.live_grep({
        search_dirs = lines,
        prompt_title = "Grep Quickfix List",
    })
end


-- Fugitive
map("n", "<leader>g", ":G ", { desc = "Open fugitive" })

-- Root directory
map("n", "<leader>tr", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>tR", function() builtin.find_files({ hidden = true }) end, { desc = "Find files" })

-- Current director
map("n", "<leader>tc", function() builtin.live_grep{ cwd = vim.fn.expand('%:p:h') } end, { desc = "Search current buffer's folder" })

-- Open buffers
map("n", "<leader>tb", function() builtin.live_grep{ grep_open_files = true} end, { desc = "grep in open buffers" })
map("n", "<leader>tB", builtin.buffers, { desc = "Find files in open buffers" })

-- Quick fix
map("n", "<leader>tq", grep_quickfix, { desc = "Search inside Quickfix files" })
map("n", "<leader>tQ", builtin.quickfix, { desc = "Search files in the quickfix menu" })
