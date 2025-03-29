local M = {}
M.js_docs = {
  strategy = "workflow",
  description = "Write JS Docs for the given code",
  opts = {
    index = 4,
    modes = { "v" },
    short_name = "js_docs",
    auto_submit = true,
    stop_context_insertion = true,
    user_prompt = true,
  },
  prompts = {
    {
      {
        role = "system",
        content = function(context)
          local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
          return "@full_stack_dev You are a senior"
            .. context.filetype
            .. " developer. You feel that writing good documentation is paramount. Every javascript and typescript function and method you write has JS docs. The docs are accurate, written, and compatible with tools like typedoc. You have proper formatting of the js docs."
        end,
        opts = {
          auto_submit = false,
          contains_code = true,
        },
      },
      {
        role = "user",
        content = function(context)
          local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
          return "@full_stack_dev You are a senior. Apply the code you write to the #buffer"
        end,
        opts = {
          auto_submit = false,
          contains_code = true,
        },
      },
    },
  },
}

return M
