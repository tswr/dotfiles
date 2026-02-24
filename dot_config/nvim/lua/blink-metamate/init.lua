--- Custom blink.cmp source for Meta's Metamate (CodeCompose).
--- Routes textDocument/inlineCompletions through the blink.cmp completion menu
--- instead of using inline ghost text.
local M = {}

function M.new(opts)
  local self = setmetatable({}, { __index = M })
  self.opts = opts or {}
  return self
end

function M:enabled()
  return require("core.env").is_fbsource()
end

function M:get_completions(ctx, callback)
  local clients = vim.lsp.get_clients({ name = "code-compose", bufnr = ctx.bufnr })
  if #clients == 0 then
    callback()
    return
  end
  local client = clients[1]

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  local request = {
    textDocument = { uri = vim.uri_from_bufnr(ctx.bufnr) },
    position = params.position,
    workDoneToken = {},
    context = { triggerKind = 1, selectedCompletionInfo = vim.NIL },
  }

  local cancelled = false
  local success, req_id = client:request(
    "textDocument/inlineCompletions",
    request,
    function(err, results)
      if cancelled or err or not results or #results == 0 then
        callback()
        return
      end

      local items = {}
      for _, result in ipairs(results) do
        local insert_text = result.insertText
        local lines = vim.split(insert_text, "\n", { plain = true })
        local label = lines[1]
        if #lines > 1 then
          label = label .. " (+" .. (#lines - 1) .. " lines)"
        end

        table.insert(items, {
          label = label,
          kind = vim.lsp.protocol.CompletionItemKind.Text,
          insertText = insert_text,
          insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
          detail = "Metamate",
          data = { metamate_result = result },
        })
      end

      callback({
        is_incomplete_forward = true,
        is_incomplete_backward = true,
        items = items,
      })
    end,
    ctx.bufnr
  )

  return function()
    cancelled = true
    if req_id and client.cancel_request then
      client:cancel_request(req_id)
    end
  end
end

function M:execute(ctx, item, callback, default_implementation)
  if item.data and item.data.metamate_result then
    local result = item.data.metamate_result
    pcall(function()
      local guid = result.command.arguments[1]
      local index = result.command.arguments[2]
      vim.lsp.buf_notify(ctx.bufnr, "cc/received", {
        guid = guid,
        event = "ClientSuggestionInserted",
        ts = vim.fn.localtime(),
        index = index,
        extras = {},
      })
    end)
  end
  default_implementation(ctx, item)
  callback()
end

return M
