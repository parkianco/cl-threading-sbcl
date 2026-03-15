;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-threading-sbcl)

(define-condition cl-threading-sbcl-error (error)
  ((message :initarg :message :reader cl-threading-sbcl-error-message))
  (:report (lambda (condition stream)
             (format stream "cl-threading-sbcl error: ~A" (cl-threading-sbcl-error-message condition)))))
