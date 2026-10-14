# User instructions

- Short sentences. Reduce AI-isms. Clear and to the point. No fluff.
- Session transcripts are exported to Joplin automatically. You don't need to do anything, and you don't need to call the Joplin API or CLI.
  - `~/.copilot/hooks/joplin-session-export.json` runs `~/.copilot/bin/export-session-to-joplin` on every `agentStop` and `sessionEnd`.
  - A launchd job (`com.issyl0.copilot-joplin-export`) runs it with `--sweep` every 15 minutes.
  - Each session is one note, updated in place, with source URL `copilot-session://<session id>`. Sessions in `github/*` repositories go in the `GitHub` notebook. Everything else goes in `Copilot Sessions`.
  - If Joplin isn't running, exports wait in `~/.copilot/joplin-export-queue/` and are sent on the next run.
  - Only if the user asks: export now with `~/.copilot/bin/export-session-to-joplin --sweep`. Remove duplicate notes with `--dedupe`. The log is `~/.copilot/logs/joplin-export.log`.
  - Source lives in `~/.dotfiles/copilot/`. Edit it there, not in `~/.copilot/`.
- Never run tests, linters, builds or scripts locally for github/github. Always run them in a GitHub Codespace (via `gh codespace ssh`).

