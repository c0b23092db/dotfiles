return {
  'saghen/blink.cmp',
  -- build = 'cargo build --release',
  version = "*",
  lazy = true,
  event = {"InsertEnter","CmdLineEnter"},

  opts_extend = { "sources.default" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "super-tab",
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },

      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then return cmp.accept()
          else return cmp.select_and_accept() end
        end,
        'snippet_forward',
        'fallback'
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono"
    },
    sources = {
      default = { 'snippets','lsp','path','buffer' },
    },
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    completion = {
      documentation = { auto_show = true },
      -- menu = { border = "rounded" },
      -- documentation = { window = { border = 'single' } },
    },
  },
}