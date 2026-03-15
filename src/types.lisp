;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-threading-sbcl)

;;; Core types for cl-threading-sbcl
(deftype cl-threading-sbcl-id () '(unsigned-byte 64))
(deftype cl-threading-sbcl-status () '(member :ready :active :error :shutdown))
