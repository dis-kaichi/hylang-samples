#!/usr/bin/env hy

;; ----------------------------------------
;; クラス定義サンプル
;; ----------------------------------------

(defclass SuperClass []
  [super-field1 "Super Field"])
(defclass SubClass [SuperClass]
  ;; Field
  [sub-field1 "Sub Field1"
   sub-field2 "Sub Field2"
   _x 0
   _y 0]

  ;; Constructor
  (defn --init-- [self sub-field1 sub-field2]
    (setv (. self sub-field1) sub-field1)
    (setv (. self sub-field2) sub-field2))

  ;; Destructor
  (defn --del-- [self]
    (print "Delete!"))

  ;; Method
  (defn sub-method [self]
    (print "Sub Method!"))

  ;; Getter/Setter
  #@(property (defn x [self]))
  #@(x.getter (defn x [self] (. self _x)))
  #@(x.setter (defn x [self x] (setv (. self _x) x)))
  #@(property (defn y [self]))
  #@(y.getter (defn y [self] (. self _y)))
  #@(y.setter (defn y [self y] (setv (. self _y) y)))

  ;; --init--, --del-- 以外の特殊メソッドも利用可能(--str--, --div--等)
  (defn --str-- [self]
    (.format "{0} {1}" (. self sub-field1) (. self sub-field2))))

(defmain
  [&rest args]
  (def ins (SubClass "R" "X"))
  ;; 01. Method呼び出し
  (.sub-method ins)
  ;; 02. フィールド呼び出し
  (print ins.sub-field2)
  ;; 03. SuperClassのフィールド呼び出し
  (print ins.super-field1)
  ;; 04. Getter/Setter
  (setv (. ins x) 10) ;; Set
  (print (. ins x))   ;; Get
  )

