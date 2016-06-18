#!/usr/bin/env hy

;; ----------------------------------------
;; クラス定義サンプル
;; ----------------------------------------

(defclass SuperClass []
  [super-field1 "SHADOW MOON"])
(defclass SubClass [SuperClass]
  ;; Field
  [sub-field1 "KAMEN-RIDER-BLACK"
   sub-field2 ""]

  ;; Constructor
  (defn --init-- [self x y]
    (setv self.sub-field2 (+ x y)))

  ;; Destructor
  (defn --del-- [self]
    (print "ULTRA-MAN"))

  ;; Method
  (defn sub-method [self]
    (print self.sub-field1)
  ))

(defmain
  [&rest args]
  (def ins (SubClass "R" "X"))
  ;; Method呼び出し
  (.sub-method ins)
  ;; フィールド呼び出し
  (print ins.sub-field2)
  ;; SuperClassのフィールド呼び出し
  (print ins.super-field1)
  )

