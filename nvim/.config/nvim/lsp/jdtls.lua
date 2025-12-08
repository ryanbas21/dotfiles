---@type vim.lsp.Config
return {
  cmd = { "jdtls" },
  filetypes = { "java" },
  root_markers = { "settings.gradle", "settings.gradle.kts", "pom.xml", "build.gradle", "mvnw", "gradlew", "build.gradle.kts", ".git" },
}
