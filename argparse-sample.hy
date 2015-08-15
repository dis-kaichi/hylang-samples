#!/usr/bin/env hy
; ----------------------------------------
; Argparseのサンプル
; ----------------------------------------

(import sys)
(import argparse)

;; Main
(let [[parser (argparse.ArgumentParser)]]
  ; 引数の追加
  (apply parser.add_argument ["-i" "--input"] {"help" "A file path" "metavar" "FILE"})
  ; テスト用のデータ追加 + パース処理
  (setv args (.parse_args parser ["-i" "INPUT-FILE"]))
  ; 表示
  (print args.input)
  (print (.print_help parser))
  )
(print "OK")
