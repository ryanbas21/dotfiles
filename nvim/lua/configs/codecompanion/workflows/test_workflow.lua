local M = {}

M.test_workflow = {
  strategy = "workflow",
  description = "Write a test suite for the current buffer",
  opts = {
    index = 4,
    mapping = "<Leader>ce",
    modes = { "v", "n" },
    short_name = "test",
    auto_submit = true,
    stop_context_insertion = true,
    user_prompt = true,
  },
  prompts = {
    {
      {
        role = "system",
        content = function(context)
          return "@full_stack_dev You are a senior "
            .. context.filetype
            .. " developer. You write extremely concise, but readable code. You do not sacrifice readability, for being concise. You prefer code readable to all over everything, but you ensure your tests are extremely comprehensive. You only test the contract, of the code, you never touch the internal details. Test the interface, not the implementation. #viewport"
        end,
        opts = {
          auto_submit = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
          auto_submit = true,
        },
      },
      {
        role = "system",
        content = "Given your understanding, @full_stack_dev, write a comprehensive test suite for it using vitest. The tests should cover all use cases. For type tests using vitest, the type files should use the filename of path/to/current/directory/[nameoffile].test-d.ts. For regular tests, the test file structure is path/to/current/directory/[nameoffile].test.ts #viewport #buffer",
        opts = {
          auto_submit = false,
        },
      },
    },
  },
}

return M
