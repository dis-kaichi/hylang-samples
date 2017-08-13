#!/usr/bin/env hy

;; ----------------------------------------
;; コーディングスタイル(Coding Style)
;; ----------------------------------------

;; 本家 : http://docs.hylang.org/en/stable/style-guide.html#coding-style

;; ////////////////////////////////////////////////////////////
;; ここでの記述は本家＋CommonLispからのパクリで構成されており
;; あくまで個人用の指針なので注意。
;; ////////////////////////////////////////////////////////////

;; 01. レイアウト
;;     インデントは半角スペース2つで行う。(タブはNG)
;;     括弧は孤立させない。

;; Good Style
(defn fib [n]
  (if (<=n 2)
    n
    (+ (fib (- n 1)) (fib (- n 2)))))

;; Bad Style
(defn fib [n]
    (if (<=n 2) ;; インデントが半角スペース4つ分になっている
        n
        (+ (fib (- n 1)) (fib (- n 2)))
    ) ;; 括弧が孤立している
)


;; 02. def, setvの使い分け
;;     defはトップレベルで使う（定数定義等）
;;     setvはローカルでの定義・代入、またはトップレベルでの代入で使う
(require [hy.contrib.loop [loop]])
;; Good Style
(def *uppper-bound* 10000)
(defn proj2 [lst]
  (setv (, f s) (, (first lst) (second lst)))
  (* f s))

;; Bad Style
(setv *uppper-bound* 10000) ;; トップレベルなのでdefを使う
(defn proj2 [lst]
  (def (, f s) (, (first lst) (second lst))) ;; defではなくsetvを使う
  (* f s))

(print (proj2 [2 4])) ;; 8

;; 03. 定数、グローバル変数
;;     定数は+XXXX+
;;     グローバル変数は*XXXX*にする
;;     (Common Lispに倣う)
(def +max-loop+ 1000)            ;; 定数(変更させない)
(def *result-array* (* [0] 10))  ;; グローバル変数(変更可能)
(assoc *result-array* 0 20)      ;; 代入

;; 04. 関数呼び出し
;;     ".", "->"をなるべく使うようにする。(個々の処理をなるべく粗結合にする)
;;     オブジェクトのメソッドの直接呼び出しは行わない。
;; Good Style

;; 各メソッドを連鎖的に適用する
(print (-> "1 2 3 4"
           (.split " ")
           ((fn [x] (map int x)))
           list))

(let [x "A B C"]
  (print (-> x (.split " "))))

;; インスタンス変数の呼び出し
(defclass Point []
  [x 0
   y 0]
  (defn --init-- [self x y]
    (setv self.x x)
    (setv self.y y)))
(print (. (Point 1 2) x))

;; Bad Style
(print (list (map int (.split "1 2 3 4" " ")))) ;; 処理結果の依存が強い
(let [x "A B C"]
  (print (x.split " "))) ;; オブジェクトのメソッドの直接呼び出し

(defmain
  [&rest args]
  (print "OK"))

(let [p (Point 1 2)]
  (print p.x))  ;; インスタンス変数の直接呼び出し

;; 05. 命名規則
;;     変数名、メソッドはHyphenCaseで書く("-"で繋ぐ)
;;     クラス名はCamelCase
;;     なるべく省略しないで書く
;;     判定メソッドは"?"を末尾につける(IsXXX, CanXXX等にはしない)
;; Good Style
(let [x-step-counter 0] (print x-step-counter))
(defn separate-with-comma [x]
  (.split x ","))
(defclass LoginUser []
  [name ""
   id ""]
  (defn --init-- [self name id]
    (setv self.name name)
    (setv self.id id)))
(defn human? [x] (!= x "GOD"))

;; Bad Style
(let [x_step_counter 0] (print x_step_counter)) ;; Python Case!
(defn separateWithComma [x] ;; Java Style!
  (.split x ","))
(defn SeparateWithComma [x] ;; C#, C++ etc Style!
  (.split x ","))
(defclass Login_User [] ;; Python Case!
  [name ""
   id ""]
  (defn --init-- [self name id]
    (setv self.name name)
    (setv self.id id)))
(defn is-human [x] (!= x "GOD")) ;; "is-"とはしないようにする
