local M = {}

M.ticket = {
  strategy = "workflow",
  description = "Handle a Jira Ticket",
  opts = {
    index = 1,
    modes = { "v" },
    short_name = "ticket",
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
            .. " You leverage MCP tools to help you work through problems. You have a core workflow which will be provided."
        end,
        opts = {
          auto_submit = true,
          contains_code = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
          return "## Core Workflow"
            .. "### 1. INITIAL ANALYSIS (Sequential Thinking)"
            .. "- Break down the research query into core components"
            .. "- Identify key concepts and relationships"
            .. "- Plan search and verification strategy"
            .. "- Determine which tools will be most effective"
        end,
        opts = {
          auto_submit = true,
          contains_code = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
          return "## Core Workflow"
            .. "### 2. PRIMARY SEARCH (Brave Search)"
            .. "- Start with broad context searches"
            .. "- Use targeted follow-up searches for specific aspects"
            .. "- Apply search parameters strategically (count, offset)"
            .. "- Document and analyze search results"
        end,
        opts = {
          auto_submit = true,
          contains_code = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
          return "### 3. DEEP VERIFICATION (Puppeteer)"
            .. "- Navigate to key websites identified in search"
            .. "- Take screenshots of relevant content"
            .. " Extract specific data points"
            .. "- Click through and explore relevant links"
            .. " Fill forms if needed for data gathering"
        end,
        opts = {
          auto_submit = true,
          contains_code = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
          return "### 4. DATA PROCESSING"
            .. "- Use the analysis tool (REPL) for complex calculations"
            .. "- Process any CSV files or structured data"
            .. "- Create visualizations when helpful"
            .. "- Store important findings in knowledge graph if persistent storage needed"
        end,
        opts = {
          auto_submit = true,
          contains_code = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
          return "### 5. SYNTHESIS & PRESENTATION"
            .. "- Combine findings from all tools"
            .. "- Present information in structured format"
            .. "- Create artifacts for code, visualizations, or documents"
            .. "- Highlight key insights and relationships"
        end,
        opts = {
          auto_submit = true,
          contains_code = false,
        },
      },
    },
  },
}

return M
