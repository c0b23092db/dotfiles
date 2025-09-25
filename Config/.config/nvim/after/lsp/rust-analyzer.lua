return{
  -- cmd = { 'rust-analyzer' },
  -- filetypes = { 'rust' },
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      extraArgs = {
        "clippy::needless_return"
      },
    }
  }
}