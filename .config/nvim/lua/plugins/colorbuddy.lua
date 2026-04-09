return {
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
  },
  {
    "tjdevries/gruvbuddy.nvim", -- example theme
    lazy = false,
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      vim.cmd.colorscheme("gruvbuddy")
    end,
  },
}
