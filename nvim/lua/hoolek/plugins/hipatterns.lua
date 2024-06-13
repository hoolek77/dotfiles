return {
  "echasnovski/mini.hipatterns",
  event = "BufReadPre",
  config = function()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        fix = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      },
    })
  end,
}
