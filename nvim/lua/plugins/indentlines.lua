local function setup()
  require('ibl').setup({
    scope = {
      show_start = false,
      show_end = false,
    }
  })
end

return {
  setup = setup
}
