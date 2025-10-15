local signs = {
  Error = '❌', -- Icon for errors
  Warn = '⚠️',  -- Icon for warnings
  Info = 'ℹ️',  -- Icon for info
  Hint = '💡',  -- Icon for hints
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup({
            ensure_installed = {"black",}
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "pyright",
            },
            handlers = {
                function(server_name) -- default handler (optional)

                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping.confirm({ select = true}),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        -- Configure Neovim's built-in diagnostics
        vim.diagnostic.config({
          -- Show virtual text (the inline messages at the end of a line)
          virtual_text = {
            prefix = '',
            spacing = 2,
            -- Setting this to false disables the inline text entirely
            -- If it's a table, you can customize it:
            -- virtual_text = {
            --   prefix = '●', -- Change the symbol before the message
            --   severity = vim.diagnostic.severity.HINT, -- Only show HINTs and above
            -- },
            -- For now, let's keep it simple and just enable it:
            -- You can remove this line to use the default settings
            -- Or set it to false to disable it: virtual_text = false
          },
  
          -- Show signs in the sign column (the symbols like 'E' and 'W')
          signs = {
            active = true, -- Make sure signs are active
    
            -- Customize the text for each diagnostic severity level
            text = {
              [vim.diagnostic.severity.ERROR] = '❌', -- Error: A big 'X' or 'fatal' symbol
              [vim.diagnostic.severity.WARN] = '⚠️',  -- Warning: A triangle with an exclamation
              [vim.diagnostic.severity.INFO] = 'ℹ️',  -- Info: A circle with 'i'
              [vim.diagnostic.severity.HINT] = '💡',  -- Hint: A bulb or light
            },
    
            -- You can also set custom highlight groups for the sign text 
            -- and the line number where the sign appears (numhl).
            texthl = {
              [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
              [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
              [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
              [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
            },
            numhl = {
              [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
              [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
              [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
              [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
            },
          },  
          -- Delay updates while in insert mode (less distraction while typing)
          update_in_insert = false,
  
          -- Configuration for the floating window/popup that appears on hover
          float = {
            border = 'single', -- Use a single line border
            source = 'always', -- Always show the source of the diagnostic
            header = '', -- An optional header text or symbol
            -- You can even format the message string
            format = function(diagnostic)
              return string.format("%s [%s]", diagnostic.message, diagnostic.source)
            end,
          },
  
          -- Set the maximum number of diagnostic messages to show per line
          -- This affects virtual_text and the floating window content
          -- max_width = 80,
  
          -- Only show diagnostics with a severity of ERROR or higher
          -- severity_sort = true, -- Show most severe first
  
        })

    end
}
