return {
  table = { { 'All',
    { 'すべて選択 (Select all)', ':call feedkeys("GVgg")' },
    { 'セッションを復元 (Restore session)', ':SessionLoad' },
    { 'セッションを保存 (Save session)', ':SessionSave' },
    { 'セッションを削除して終了 (Delete session and quit)',
      ':call feedkeys(":SessionStop\\<cr>:\\<cr>:qa\\<cr>")' }
  } }
}
