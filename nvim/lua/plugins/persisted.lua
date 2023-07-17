local status_ok, persisted = pcall(require, "persisted")
if not status_ok then
  return
end

persisted.setup({
  save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
  silent = false,                                                   -- silent nvim message when sourcing session file
  use_git_branch = true,                                            -- create session files based on the branch of the git enabled repository
  autosave = false,                                                 -- automatically save session files when exiting Neovim
  should_autosave = nil,                                            -- function to determine if a session should be autosaved
  autoload = false,                                                 -- automatically load the session for the cwd on Neovim startup
})
