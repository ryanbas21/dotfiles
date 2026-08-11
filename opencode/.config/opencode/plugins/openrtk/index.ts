import type { Plugin } from "@opencode-ai/plugin"
import { rewrite } from "./rewrite"

export const rtkPlugin: Plugin = async ({ $ }) => {
  // Check rtk is installed at plugin load time
  try {
    await $`which rtk`.quiet()
  } catch {
    console.warn("[openrtk] rtk binary not found in PATH — plugin disabled")
    return {}
  }

  return {
    "tool.execute.before": async (input, output) => {
      // OpenCode may use "bash", "shell", or other names
      const tool = String(input?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      // args may be {command: "..."} or have command nested differently
      const args = output?.args
      if (!args || typeof args !== "object") return

      const command = (args as Record<string, unknown>).command
      const rewritten = rewrite(command)
      if (rewritten) {
        ;(args as Record<string, unknown>).command = rewritten
      }
    },
  }
}

export default rtkPlugin
