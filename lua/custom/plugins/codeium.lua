return {
  'Exafunction/codeium.vim',
  event = 'InsertEnter',
  -- stylua: ignore
  config = function()
    vim.keymap.set("i", "<End>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
    vim.keymap.set("i", "<PageUp>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
    vim.keymap.set("i", "<PageDown>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
    vim.keymap.set("i", "<Home>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
  end,
}
