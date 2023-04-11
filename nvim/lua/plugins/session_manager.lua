local status_ok, session_manager = pcall(require, "session_manager")
if not status_ok then
    return
end

local status_ok, session_manager_config = pcall(require, "session_manager.config")
if not status_ok then
    return
end

session_manager.setup {
 autoload_mode = session_manager_config.AutoloadMode.CurrentDir
}
