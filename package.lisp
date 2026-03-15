;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: Apache-2.0

;;;; package.lisp
;;;; cl-threading-sbcl package definition

(defpackage #:cl-threading-sbcl
  (:use #:cl)
  (:nicknames #:threading-sbcl)
  (:export
   ;; Thread operations
   #:make-thread
   #:join-thread
   #:thread-alive-p
   #:current-thread
   #:thread-name
   #:all-threads
   #:destroy-thread
   ;; Locks (mutexes)
   #:make-lock
   #:acquire-lock
   #:release-lock
   #:with-lock-held
   ;; Condition variables
   #:make-condition-variable
   #:condition-wait
   #:condition-notify
   #:condition-broadcast
   ;; Semaphores
   #:make-semaphore
   #:semaphore-wait
   #:semaphore-signal
   #:semaphore-count))
