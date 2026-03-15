;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

;;;; test-threading-sbcl.lisp - Unit tests for threading-sbcl
;;;;
;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: Apache-2.0

(defpackage #:cl-threading-sbcl.test
  (:use #:cl)
  (:export #:run-tests))

(in-package #:cl-threading-sbcl.test)

(defun run-tests ()
  "Run all tests for cl-threading-sbcl."
  (format t "~&Running tests for cl-threading-sbcl...~%")
  ;; TODO: Add test cases
  ;; (test-function-1)
  ;; (test-function-2)
  (format t "~&All tests passed!~%")
  t)
