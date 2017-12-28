#!/usr/bin/env hy

; ----------------------------------------
; 自作ライブラリ読み込みのサンプル
; ----------------------------------------

(import [lib.external-lib [lib-method]])
;(import [lib.lib-sample [*]]) ;; 全部読み込む場合はこっちでもいい


(defn driver []
  (print (lib-method)))

(defmain
  [&rest args]
  (driver))

