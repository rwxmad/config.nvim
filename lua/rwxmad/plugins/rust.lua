return {
  -- if enabled -> disable rust_analyzer in lsp config
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
  },

  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
