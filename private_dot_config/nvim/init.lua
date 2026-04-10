-- Plugins
vim.pack.add({ "https://github.com/EdenEast/nightfox.nvim" })
vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
-- indent-rainbowline removed, using ibl with colored guides instead
vim.pack.add({ "https://github.com/mrjones2014/smart-splits.nvim" })
vim.pack.add({ "https://github.com/mikesmithgh/kitty-scrollback.nvim" })
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
vim.pack.add({ "https://github.com/okuuva/auto-save.nvim" })
vim.pack.add({ "https://github.com/folke/flash.nvim" })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
vim.pack.add({ "https://github.com/folke/which-key.nvim" })
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })
vim.pack.add({ "https://github.com/catppuccin/nvim" })
vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })
vim.pack.add({ "https://github.com/rose-pine/neovim" })

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.fillchars = { vert = "│" }
vim.opt.cmdheight = 0
require("vim._core.ui2").enable({})
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize"
-- statusline handled by lualine

-- Completion
vim.opt.completeopt = "menuone,noselect,popup,fuzzy"

-- Tab: accept inline completion (Copilot), navigate completion menu, or insert tab
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif not vim.lsp.inline_completion.get() then
    return "<Tab>"
  end
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  else
    return "<S-Tab>"
  end
end, { expr = true })

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Close quickfix on select
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<cr>", "<cr>:cclose<cr>", { buffer = true })
  end,
})

-- LSP global config
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Enable LSP servers
vim.lsp.enable({
  "gopls",
  "ruby_lsp",
  "terraformls",
  "lua_ls",
  "bashls",
  "jsonls",
  "yamlls",
  "copilot",
})

-- LspAttach: enable completion + inline completion (Copilot)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    if client:supports_method("textDocument/inlineCompletion") then
      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
    end
  end,
})

-- Colorscheme
require("nightfox").setup({ options = { transparent = true } })
require("catppuccin").setup({ transparent_background = true })
require("kanagawa").setup({ transparent = true })

local pack_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt"
local kitty_themes_dir = vim.fn.expand("~/.config/kitty/themes")

-- Map nvim colorscheme name -> kitty conf path
local kitty_map = {
  -- nightfox
  nightfox     = pack_dir .. "/nightfox.nvim/extra/nightfox/kitty.conf",
  terafox      = pack_dir .. "/nightfox.nvim/extra/terafox/kitty.conf",
  carbonfox    = pack_dir .. "/nightfox.nvim/extra/carbonfox/kitty.conf",
  duskfox      = pack_dir .. "/nightfox.nvim/extra/duskfox/kitty.conf",
  nordfox      = pack_dir .. "/nightfox.nvim/extra/nordfox/kitty.conf",
  dawnfox      = pack_dir .. "/nightfox.nvim/extra/dawnfox/kitty.conf",
  dayfox       = pack_dir .. "/nightfox.nvim/extra/dayfox/kitty.conf",
  -- tokyonight
  ["tokyonight-night"] = pack_dir .. "/tokyonight.nvim/extras/kitty/tokyonight_night.conf",
  ["tokyonight-storm"] = pack_dir .. "/tokyonight.nvim/extras/kitty/tokyonight_storm.conf",
  ["tokyonight-day"]   = pack_dir .. "/tokyonight.nvim/extras/kitty/tokyonight_day.conf",
  ["tokyonight-moon"]  = pack_dir .. "/tokyonight.nvim/extras/kitty/tokyonight_moon.conf",
  -- catppuccin
  ["catppuccin-mocha"]     = kitty_themes_dir .. "/catppuccin-mocha.conf",
  ["catppuccin-macchiato"] = kitty_themes_dir .. "/catppuccin-macchiato.conf",
  ["catppuccin-frappe"]    = kitty_themes_dir .. "/catppuccin-frappe.conf",
  ["catppuccin-latte"]     = kitty_themes_dir .. "/catppuccin-latte.conf",
  -- kanagawa
  kanagawa         = pack_dir .. "/kanagawa.nvim/extras/kitty/kanagawa.conf",
  ["kanagawa-dragon"] = pack_dir .. "/kanagawa.nvim/extras/kitty/kanagawa_dragon.conf",
  ["kanagawa-lotus"]  = pack_dir .. "/kanagawa.nvim/extras/kitty/kanagawa_light.conf",
  -- rose-pine
  ["rose-pine"]      = kitty_themes_dir .. "/rose-pine.conf",
  ["rose-pine-moon"] = kitty_themes_dir .. "/rose-pine-moon.conf",
  ["rose-pine-dawn"] = kitty_themes_dir .. "/rose-pine-dawn.conf",
}

local function set_theme(name)
  vim.cmd.colorscheme(name)
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#4e5157" })
  local kitty_conf = kitty_map[name]
  if kitty_conf and vim.fn.filereadable(kitty_conf) == 1 then
    vim.system({ "kitty", "@", "set-colors", "--all", "--configured", kitty_conf })
  end
  vim.fn.writefile({ name }, vim.fn.stdpath("state") .. "/colorscheme")
end

-- Restore saved theme or default to terafox
local saved = vim.fn.stdpath("state") .. "/colorscheme"
local theme = vim.fn.filereadable(saved) == 1 and vim.fn.readfile(saved)[1] or "terafox"
set_theme(theme)

-- Theme picker: <leader>ct
vim.keymap.set("n", "<leader>ct", function()
  local themes = vim.tbl_keys(kitty_map)
  table.sort(themes)
  vim.ui.select(themes, { prompt = "Select theme:" }, function(choice)
    if choice then set_theme(choice) end
  end)
end, { desc = "Change theme (nvim + kitty)" })

-- Indent guides (colored lines, no background)
local ibl_hooks = require("ibl.hooks")
ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)
require("ibl").setup({
  indent = {
    highlight = { "RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan" },
    char = "│",
  },
  scope = { enabled = false },
})

-- Oil (file explorer)
require("oil").setup()
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File explorer" })

-- fzf-lua (fuzzy finder)
local fzf = require("fzf-lua")
fzf.setup()
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader><leader>", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>", { desc = "Goto Definition" })
vim.keymap.set("n", "<leader>gg", function()
  vim.cmd("tabnew | terminal lazygit")
  vim.cmd("startinsert")
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = 0,
    callback = function()
      vim.cmd("bdelete!")
    end,
  })
end, { desc = "Lazygit" })
vim.keymap.set("n", "grr", "<cmd>FzfLua lsp_references ignore_current_line=true<cr>", { desc = "References" })
vim.keymap.set("n", "gy", "<cmd>FzfLua lsp_typedefs<cr>", { desc = "Goto Type Definition" })

-- Smart splits (kitty integration)
require("smart-splits").setup({
  multiplexer_integration = "kitty",
})
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)

-- Sessions (auto-save on exit, restore with <leader>sr)
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.cmd("mksession! ~/.local/state/nvim/session.vim")
  end,
})
vim.keymap.set("n", "<leader>sr", "<cmd>source ~/.local/state/nvim/session.vim<cr>", { desc = "Restore session" })

-- Window splits and close
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>q", function()
  if #vim.api.nvim_list_wins() > 1 then
    vim.cmd("close")
  else
    vim.cmd("quit")
  end
end, { desc = "Close window or quit" })

-- Gitsigns
require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 1000,
    virt_text = true,
    virt_text_pos = "eol",
  },
  current_line_blame_formatter = "<author>, <author_time:%m-%d-%Y> . <summary>",
})

-- Kitty scrollback
require("kitty-scrollback").setup({
  ksb_custom = {
    paste_window = {
      yank_register_enabled = false,
    },
    keymaps_enabled = true,
    callbacks = {
      after_ready = function()
        vim.api.nvim_create_autocmd("TextYankPost", {
          callback = function()
            vim.defer_fn(function()
              vim.cmd("quitall!")
            end, 50)
          end,
        })
      end,
    },
  },
})

-- Auto-save
require("auto-save").setup({
  condition = function(buf)
    return vim.fn.getbufvar(buf, "&filetype") ~= "harpoon"
  end,
})

-- Flash (motions)
require("flash").setup({
  modes = { search = { enabled = true } },
})
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Treesitter
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("nvim-treesitter").setup({
      auto_install = false,
      ensure_installed = { "ruby", "go", "terraform", "hcl", "bash", "json", "yaml", "lua", "markdown", "markdown_inline" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
})

-- Which-key
require("which-key").setup()

-- Lualine
require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = "",
  },
})
