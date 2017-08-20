#!/usr/bin/env hy

; ----------------------------------------
; 関数呼び出しサンプル
; ----------------------------------------

(def array [3 1 2])

;; キーワード引数と通常の引数が混合している場合
;;  sorted(array, reverse=True)
(print (apply sorted [array] {"reverse" True}))

;; キーワード引数のみの場合
;; ※ 通常の引数を空として渡す必要があるようである。
;;  array.sort(reverse=True)
(apply (. array sort) [] {"reverse" True})
(print array)
