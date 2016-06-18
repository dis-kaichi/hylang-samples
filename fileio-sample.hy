#!/usr/bin/env hy

;; ----------------------------------------
;; ライブラリ
;; ----------------------------------------
(import csv)


;; ----------------------------------------
;; 定数
;; ----------------------------------------
;; データファイルパス
(setv +FILE-PATH+ "data/matrix001.csv")
(setv +OUTPUT-PATH1+ "data/output001.txt")
(setv +OUTPUT-PATH2+ "data/output002.csv")

;; ----------------------------------------
;; Functions
;; ----------------------------------------
(defun normal-reader [path]
  ;; 通常のファイル読み込み
  ;; ----------------------------------------
  ;; Inner Functions
  ;; ----------------------------------------
  (defun skip-line-p [line]
    ;; 空行 or 先頭が"#"で始まる場合はTrue
    (or (empty? line) (= (first line) "#")))
  ;; ----------------------------------------
  ;; Main
  ;; ----------------------------------------
  (setv data [])
  (with [[fp (open path)]]
        (for [line (.readlines fp)]
             (setv stripped (.strip line))
             (when (skip-line-p stripped)
               (continue))
             (.append data stripped)))
  data)
(defun csv-reader [path]
  ;; ライブラリを使った読み込み
  ;; ----------------------------------------
  ;; Inner Functions
  ;; ----------------------------------------
  (defun skip-line-p [line]
    ;; 空行 or 先頭が"#"で始まる場合はTrue
    (or (empty? line)
        (and (not (empty? (first line)))
             ;; "  #,"この場合に対応させる
             (= (->
                  line
                  first                  ; 先頭データ
                  ((fn [x] (.strip x)))  ; 空白削除
                  first)                 ; 先頭文字
                "#")
             )))
  ;; ----------------------------------------
  ;; Main
  ;; ----------------------------------------
  (setv data [])
  (with [[fp (open path)]]
        (setv reader (.reader csv fp))
        (for [line reader]
             (when (skip-line-p line)
               (continue))
             (.append data line)
             ))
  data)

(defun flip [f a b]
  ;; FLIP関数(関数の引数を入れ替える)
  (print [b a])
  (apply f [b a]))

(defun normal-writer [path data]
  ;; ファイル出力
  (with [[fp (open path "w")]]
        (for [line data]
             (.write fp
                     ;; カンマで繋ぐ & 改行の附与
                     (->> line
                          (map str)
                          list
                          (.join ",")
                          (flip + "\n"))))))

(defun csv-writer [path data]
  ;; CSVファイル出力
  (with [[fp (open path "w")]]
        (setv writer (.writer csv fp {"lineterminator" "\n"}))
        (.writerows writer data)))

(defun logic []
  ;; ファイル読み込み
  (print (normal-reader +FILE-PATH+))
  (print (csv-reader +FILE-PATH+))
  ;; ファイル書き込み
  (setv data [[100 200 300] ["a" "b" "c"]])
  (normal-writer +OUTPUT-PATH1+ data)
  (csv-writer +OUTPUT-PATH2+ data))

;; ----------------------------------------
;; Main
;; ----------------------------------------
(defmain [&rest args]
  ;; Main Function
  (logic))
