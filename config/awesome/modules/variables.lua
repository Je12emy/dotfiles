local m = {}

m.terminal = os.getenv("TERMINAL") or "kitty"
m.editor = os.getenv("EDITOR") or "nvim"
m.browser = os.getenv("BROWSER") or "firefox"
m.editor_cmd = m.terminal .. " " .. m.editor
m.mod_key = "Mod4"

return m
