vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.cmd("set number")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set mouse=")
vim.cmd("set linebreak")

vim.keymap.set("n", "<C-h>", "<C-w><Left>", {})
vim.keymap.set("n", "<C-j>", "<C-w><Down>", {})
vim.keymap.set("n", "<C-k>", "<C-w><Up>", {})
vim.keymap.set("n", "<C-l>", "<C-w><Right>", {})

vim.keymap.set("n", "<C-s>", ":setlocal spell spelllang=en_au<CR>", {})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
