;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; cl-threading-sbcl.asd
;;;; SBCL native threading wrapper with ZERO external dependencies

(asdf:defsystem #:cl-threading-sbcl
  :description "SBCL native threading wrapper using sb-thread"
  :author "Park Ian Co"
  :license "Apache-2.0"
  :version "0.1.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "package")
                             (:file "conditions" :depends-on ("package"))
                             (:file "types" :depends-on ("package"))
                             (:file "cl-threading-sbcl" :depends-on ("package" "conditions" "types")))))))

(asdf:defsystem #:cl-threading-sbcl/test
  :description "Tests for cl-threading-sbcl"
  :depends-on (#:cl-threading-sbcl)
  :serial t
  :components ((:module "test"
                :components ((:file "test-threading-sbcl"))))
  :perform (asdf:test-op (o c)
             (let ((result (uiop:symbol-call :cl-threading-sbcl.test :run-tests)))
               (unless result
                 (error "Tests failed")))))
