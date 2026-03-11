;;;; cl-threading-sbcl.asd
;;;; SBCL native threading wrapper with ZERO external dependencies

(asdf:defsystem #:cl-threading-sbcl
  :description "SBCL native threading wrapper using sb-thread"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :version "1.0.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "threading")))))
