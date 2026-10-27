local function parse_csv_line(line)
  local row = {}
  line = line:gsub("\r$", "") .. ","
  for field in line:gmatch("([^,]*),") do
    local clean = field:match("^%s*(.-)%s*$"):gsub('^"(.*)"$', "%1")
    table.insert(row, clean)
  end
  return row
end

local function load_csv(filename)
  local list = {}
  for line in io.lines(filename) do
    if line:match("%S") then
      local row = parse_csv_line(line)
      local program = row[1]
      local name = row[2]
      local icon = row[3] or "wezterm.nerdfonts.md_console_line"
      local color = row[4] or "#50A0F0"
      if name and name ~= "" then
        list[program] = {
          program = program,
          name = name,
          icon = icon,
          color = color,
        }
      end
    end
  end
  return list
end

return load_csv
