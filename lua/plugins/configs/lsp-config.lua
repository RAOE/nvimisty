local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_default_config = lspconfig.util.default_config
local snippet = require("luasnip.loaders.from_vscode")
local import_util = require("utils.import")
local lsp_attach_config = require("plugins.configs.lsp-attach-config")
local current_path = (...):match("(.-)[^%.]+$")
local path_util = require("utils.path")

-- Snippet configuration
snippet.lazy_load()

-- Merge LSP client capabilities config
lsp_default_config.capabilities =
	vim.tbl_deep_extend("force", lsp_default_config.capabilities, cmp_nvim_lsp.default_capabilities())

-- Enable language servers
require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
})

local language_configs = import_util.require_dir(path_util.get_current_path() .. "ls-configs", "plugins.configs.ls-configs")

-- LSP kay mapping config
vim.api.nvim_create_autocmd("LspAttach", lsp_attach_config)
