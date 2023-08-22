return {
  table = {
    { 'Buffer',
      { 'すべて選択 (Select all)', ':call feedkeys("GVgg")' }
    },
    { 'Session',
      { 'セッションを復元 (Restore session)', ':SessionRestore' },
      { 'セッションを保存 (Save session)', ':SessionSave' },
      { 'セッションを削除 (Delete session)',
        ':call feedkeys(":DisableAutoSave\\<cr>:SessionDelete\\<cr>")' },
      { 'セッションを削除して終了 (Delete session and quit)',
        ':call feedkeys(":DisableAutoSave\\<cr>:SessionDelete\\<cr>:qa\\<cr>")' }
    }
  }
}
