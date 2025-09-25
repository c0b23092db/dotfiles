local wezterm = require("wezterm")

local function get_tab_icon(tab)
-- 拡張子を変更するようにする
  tab = string.gsub(tab:match("[^\\]+$"), ".exe", "")

  local title = "PowerShell 7 (x64)"
  local icon = wezterm.nerdfonts.md_console_line
  local icon_color = "#50A0F0"

  if tab == "pwsh" then
    -- title = "PowerShell 7 (x64)"
    -- icon = wezterm.nerdfonts.md_console_line
    -- icon_color = "#50A0F0"
  elseif tab == "cmd" then
    title = "CommandPrompt"
    icon = wezterm.nerdfonts.md_console_line
    icon_color = "#101010"
  elseif tab == "wslhost" then
    title = "WSL"
    icon = wezterm.nerdfonts.cod_terminal_linux
    icon_color = "#e95420"
  elseif tab == "btm" then
    title = "bottom"
    icon = wezterm.nerdfonts.cod_circuit_board
    icon_color = "#F0F0F0"
  elseif tab == "yazi" then
    title = "yazi"
    icon = wezterm.nerdfonts.cod_folder
    icon_color = "#F9F900"
  elseif tab == "broot" then
    title = "broot"
    icon = wezterm.nerdfonts.cod_folder
    icon_color = "#909000"
  elseif tab == "lazygit" then
    title = "Lazygit"
    icon = wezterm.nerdfonts.dev_git
    icon_color = "#25d580"
-- CLI Editer
  elseif tab == "edit" then
    title = "edit"
    icon = wezterm.nerdfonts.fa_edit
    icon_color = "#66d88b"
  elseif tab == "micro" then
    title = "micro"
    icon = wezterm.nerdfonts.md_alpha_m_box
    icon_color = "#2e3192"
-- Neovim
  elseif  tab == "nvim" or
          tab == "language_server_windows_x64" then
    title = "Neovim"
    icon = wezterm.nerdfonts.custom_neovim
    icon_color = "#30c030"
  elseif tab == "clangd" then
    title = "Neovim"
    icon = wezterm.nerdfonts.dev_c
    icon_color = "#085e9f"
  elseif  tab == "rust-analyzer" or
          tab == "rust-analyzer-proc-macro-srv" then
    title = "Neovim"
    icon = wezterm.nerdfonts.dev_rust
    icon_color = "#f74b00"
  elseif tab == "python" then
    title = "Neovim"
    icon = wezterm.nerdfonts.dev_python
    icon_color = "#ffdd50"
  elseif tab == "lua-language-server" then
    title = "Neovim"
    icon = wezterm.nerdfonts.dev_lua
    icon_color = "#080884"
  else
    title = tab
  end

  return {
    icon = icon,
    icon_color = icon_color,
    title = title,
  }
end

return get_tab_icon