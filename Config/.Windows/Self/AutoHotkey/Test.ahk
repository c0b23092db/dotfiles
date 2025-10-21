; https://ahkscript.github.io/ja/docs/v2/lib/_SingleInstance.htm
; スクリプトがすでに実行されているときに、再実行を許可するかどうかを決定します。
#SingleInstance Force
; https://ahkscript.github.io/ja/docs/v2/lib/ProcessSetPriority.htm
; 最初のマッチング処理の優先度を変更します。
ProcessSetPriority("Realtime")

; テスト動作
~sc079 & i::Send("#^{Left}")
~sc079 & o::Send("#^{Right}")
