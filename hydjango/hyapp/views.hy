(import os)
(import [django.shortcuts [render]])
(import [django.http [HttpResponse]])
(import [django.template [RequestContext loader]])

; ----------------------------------------
; HylangでDjangoを書こうテスト
; ----------------------------------------

(defun main [request]
  (setv template (.get_template loader "hyapp_index.html"))
  (setv context (RequestContext request {}))
  (HttpResponse (.render template context)))
