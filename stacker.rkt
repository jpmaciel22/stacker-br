#lang br/quicklang

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (define src-datums (format-datums '(handle ~a) src-lines))
  (define module-datum `(module stacker-mod "stacker.rkt"
                          ,@src-datums))
  (datum->syntax #f module-datum)
  )
(provide read-syntax)
(define-macro (stacker-module-begin HANDLE-EXPR ...)
  #'(#%module-begin
     HANDLE-EXPR ...
     (display (first stack))))
(provide (rename-out [stacker-module-begin #%module-begin]))

(define stack empty)

(define (pop-stack!)
  (define arg (first stack))
  (set! stack (rest stack))
  arg)

(define (push-stack! arg)
  (set! stack (cons arg stack)))

(define (handle [arg #f]) ;; that way we can make the arg optional
  (cond
    [(number? arg) (push-stack! arg)] ;; if its a number push the arg
    [(or (equal? + arg) (equal? * arg))
     (define op-result (arg (pop-stack!) (pop-stack!))) ;; se for alguma operacao, nos damos 2 pop pra pegar os valores e aplicamos em arg com uma expression call
     (push-stack! op-result)]))
(provide  handle)
(provide + *) ;; tem q dar provide nessas funcoes tb mas o quicklang ja tem entao nos pegamos emprestado dele