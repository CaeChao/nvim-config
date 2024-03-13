local Log = {}

Log.levels = {
  TRACE = 1,
  DEBUG = 2,
  INFO = 3,
  WARN = 4,
  ERROR = 5,
}
vim.tbl_add_reverse_lookup(Log.levels)

function Log:set_level(level)
  if
    not pcall(function()
      local logger_ok, logger = pcall(function()
        return require("structlog").get_logger("Logger")
      end)
      local log_level = Log.levels[level:upper()]
      if logger_ok and logger and log_level then
        for _, pipeline in ipairs(logger.pipelines) do
          pipeline.level = log_level
        end
      end
    end)
  then
    vim.notify("structlog version too old, run `:Lazy sync`")
  end
end

function Log:init()
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return nil
  end

  structlog.configure({
    Logger = {
      pipelines = {
        {
          level = Log.levels.INFO,
          processors = {},
          formatter = structlog.formatters.Format( --
            "%s",
            { "msg" },
            { blacklist = { "level", "logger_name" } }
          ),
          sink = structlog.sinks.NvimNotify(),
        },
        {
          level = Log.levels.WARN,
          processors = {},
          formatter = structlog.formatters.Format( --
            "%s",
            { "msg" },
            { blacklist = { "level", "logger_name" } }
          ),
          sink = structlog.sinks.NvimNotify(),
        },
        {
          level = Log.levels["TRACE"],
          processors = {
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 3, stack_level = 2 }),
            structlog.processors.Timestamper("%F %H:%M:%S"),
          },
          formatter = structlog.formatters.Format(
            "%s [%-5s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" }
          ),
          sink = structlog.sinks.File(self:get_path()),
        },
      },
    },
  })

  local logger = structlog.get_logger("Logger")

  return logger
end

--- Adds a log entry using Plenary.log
---@param level integer [same as vim.log.levels]
---@param msg any
---@param event any
function Log:add_entry(level, msg, event)
  if
    not pcall(function()
      local logger = self:get_logger()
      if not logger then
        return
      end
      logger:log(level, vim.inspect(msg), event)
    end)
  then
    vim.notify("structlog version too old, run `:Lazy sync`")
  end
end

---Retrieves the handle of the logger object
---@return table|nil logger handle if found
function Log:get_logger()
  local logger_ok, logger = pcall(function()
    return require("structlog").get_logger("Logger")
  end)
  if logger_ok and logger then
    return logger
  end

  logger = self:init()

  if not logger then
    return
  end

  self.__handle = logger
  return logger
end

---Retrieves the path of the logfile
---@return string path of the logfile
function Log:get_path()
  return string.format("%s/%s.log", vim.call("stdpath", "cache"), "Logger")
end

---Add a log entry at TRACE level
---@param msg any
---@param event any
function Log:trace(msg, event)
  self:add_entry(self.levels.TRACE, msg, event)
end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function Log:debug(msg, event)
  self:add_entry(self.levels.DEBUG, msg, event)
end

---Add a log entry at INFO level
---@param msg any
---@param event any
function Log:info(msg, event)
  self:add_entry(self.levels.INFO, msg, event)
end

---Add a log entry at WARN level
---@param msg any
---@param event any
function Log:warn(msg, event)
  self:add_entry(self.levels.WARN, msg, event)
end

---Add a log entry at ERROR level
---@param msg any
---@param event any
function Log:error(msg, event)
  self:add_entry(self.levels.ERROR, msg, event)
end

setmetatable({}, Log)

return Log
