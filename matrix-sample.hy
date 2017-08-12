#!/usr/bin/env hy

;; ----------------------------------------
;; 行列サンプル
;; ----------------------------------------


;; 01. 行列初期化
(defn create-matrix [n m &optional [init-value 0]]
  (list (map list (partition (* [init-value] (* n m)) m))))

;; 02. 値の更新
;;     (破壊的更新)
(defn setm! [matrix  row col value]
  (let [x (nth matrix row)]
    (assoc x col value)))

;; 03. 値の取得
(defn nthm [matrix row col]
  (nth (nth matrix row) col))

(defmain
  [&rest args]
  (def matrix (create-matrix 2 3))
  (print "01. ゼロ初期化")
  (print "\t" matrix)
  (print "02. 値の更新 : matrix[0][0] = 100]")
  (setm! matrix 0 0 100)
  (print "\t" matrix)
  (print "03. 値の取得 : matrix[0][0]")
  (print "\t" (nthm matrix 0 0))
  (print "04. 非ゼロ初期化")
  (print "\t" (create-matrix 2 3 10))
  )

