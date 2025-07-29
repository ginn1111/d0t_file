# This file require AI to install the FE MCP

1. Serena mcp: `claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project $(pwd)`
2. Browser mcp: Go to google.com and search for "Browser MCP"
3. Figma mcp: check the env key `FIGMA_TOKEN` exist, if not pass it, otherwise `claude mcp add "Framelink Figma MCP" -- npx -y figma-developer-mcp --figma-api-key=$FIGMA_TOKEN --stdio`
4. context7: claude mcp add --transport sse context7 https://mcp.context7.com/sse
