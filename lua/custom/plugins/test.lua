return {
  'klen/nvim-test',
  config = function()
    require('nvim-test').setup()
    require('nvim-test.runners.pytest'):setup { command = '/home/dev/patreon_py/bin/rdev/pytest' }
  end,
}
