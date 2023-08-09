return {
  table = {
    { 'Buffer',
      { 'すべて選択 (Select all)', ':call feedkeys("GVgg")' }
    },
    { 'Session',
      { 'セッションを復元 (Restore session)', ':RestoreSession' },
      { 'セッションを保存 (Save session)',    ':SaveSession' },
      { 'セッションを削除 (Delete session)',
        ':call feedkeys(":DisableAutoSave\\<cr>:DeleteSession\\<cr>")' },
      { 'セッションを削除して終了 (Delete session and quit)',
        ':call feedkeys(":DisableAutoSave\\<cr>:DeleteSession\\<cr>:quit\\<cr>")' }
    }
  }
}
