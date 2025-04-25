return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
  end,
  keys = {
    {
      "<leader>a",
      function()
        local harpoon = require("harpoon")
        harpoon:list():add()
      end,
      desc = "Harpoon [A]dd",
    },
    {
      "<C-e>",
      function()
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end,
      desc = "Harpoon Menu",
    },
    {
      "<C-S-P>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():prev()
      end,
    },
    {
      "<C-S-N>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():next()
      end,
    },
  },
}
