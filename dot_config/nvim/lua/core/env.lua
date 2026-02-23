local M = {}

local _is_meta_infra = nil

function M.is_meta_infra()
  if _is_meta_infra ~= nil then
    return _is_meta_infra
  end

  local markers = { "/etc/fbwhoami", "/opt/facebook" }
  for _, path in ipairs(markers) do
    if vim.uv.fs_stat(path) then
      _is_meta_infra = true
      return true
    end
  end

  local hostname = (vim.uv.os_gethostname() or ""):lower()
  local patterns = {
    "%.fbinfra%.net$",
    "%.facebook%.com$",
    "%.meta%.com$",
    "%.fb%.com$",
    "^devvm",
    "%.od%.",
  }
  for _, pattern in ipairs(patterns) do
    if hostname:match(pattern) then
      _is_meta_infra = true
      return true
    end
  end

  _is_meta_infra = false
  return false
end

function M.is_fbsource()
  local cwd = vim.fn.getcwd() or ""
  return cwd:find("fbsource", 1, true) ~= nil
end

return M
