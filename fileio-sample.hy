#!/usr/bin/env hy

;; ----------------------------------------
;; ライブラリ
;; ----------------------------------------
(import csv)


;; ----------------------------------------
;; 定数
;; ----------------------------------------
;; データファイルパス
(setv +file-path+ "data/matrix001.csv")
(setv +output-path1+ "data/output001.txt")
(setv +output-path2+ "data/output002.csv")

;; ----------------------------------------
;; Functions
;; ----------------------------------------
(defun normal-reader [path]
  ;; 通常のファイル読み込み
  ;; ----------------------------------------
  ;; Inner Functions
  ;; ----------------------------------------
  (defun is-skip-line [line]
    ;; 空行 or 先頭が"#"で始まる場合はTrue
    (or (empty? line) (= (first line) "#")))
  ;; ----------------------------------------
  ;; Main
  ;; ----------------------------------------
  (setv data [])
  (with [[fp (open path)]]
        (for [line (.readlines fp)]
             (setv stripped (.strip line))
             (when (is-skip-line stripped)
               (continue))
             (.append data stripped)))
  data)
(defun csv-reader [path]
  ;; ライブラリを使った読み込み
  ;; ----------------------------------------
  ;; Inner Functions
  ;; ----------------------------------------
  (defun is-skip-line [line]
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
             (when (is-skip-line line)
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
  (print (normal-reader +file-path+))
  (print (csv-reader +file-path+))
  ;; ファイル書き込み
  (setv data [[100 200 300] ["a" "b" "c"]])
  (normal-writer +output-path1+ data)
  (csv-writer +output-path2+ data))

;; ----------------------------------------
;; Main
;; ----------------------------------------
(defmain [&rest args]
  ;; Main Function
  (logic))
