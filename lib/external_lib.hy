#!/usr/bin/env hy

;; 注意 : ファイル名は"lib-sample"などの様に
;;        ハイフンを使ってしまうとimport時に読めなくなる(*1)
;;        (*1) ハイフンを自動的にアンダーバーに変えてしまうため

(defn lib-method []
  "LIB-METHOD")
