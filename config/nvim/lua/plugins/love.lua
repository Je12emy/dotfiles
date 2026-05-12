return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              library = { os.getenv("HOME") .. "/.local/share/LuaAddons" },
              checkThirdParty = false,
            },
          },
        },
      },
    },
  },
}
