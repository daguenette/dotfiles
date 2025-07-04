-- .NET Environment Configuration
vim.env.DOTNET_ROOT = "/usr/local/share/dotnet"
vim.env.DOTNET_HOST_PATH = "/usr/local/share/dotnet/dotnet"
vim.env.DOTNET_MSBUILD_SDK_RESOLVER_CLI_DIR = "/usr/local/share/dotnet"

-- Update PATH to include dotnet
local current_path = vim.env.PATH or ""
if not string.match(current_path, "/usr/local/share/dotnet") then
  vim.env.PATH = "/usr/local/share/dotnet:" .. current_path
end
