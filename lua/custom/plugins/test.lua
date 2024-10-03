return {
  'klen/nvim-test',
  keys = {
    { '<leader>T', "<cmd>TestFile<cr><cr>", desc="Run test file"},
    { '<leader>R', "<cmd>TestNearest<cr><cr>", desc="Run TestNearest"},
  },
  config = function()
    require('nvim-test').setup()
    require('nvim-test.runners.pytest'):setup { command = '/home/dev/patreon_py/bin/rdev/pytest' }
  end,
}
