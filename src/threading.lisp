;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: BSD-3-Clause

;;;; src/threading.lisp
;;;; SBCL native threading implementation

(in-package #:cl-threading-sbcl)

;;; Thread operations

(defun make-thread (function &key (name "anonymous"))
  "Create and start a new thread running FUNCTION."
  (sb-thread:make-thread function :name name))

(defun join-thread (thread)
  "Wait for THREAD to complete and return its result."
  (sb-thread:join-thread thread))

(defun thread-alive-p (thread)
  "Return T if THREAD is still running."
  (sb-thread:thread-alive-p thread))

(defun current-thread ()
  "Return the current thread."
  sb-thread:*current-thread*)

(defun thread-name (thread)
  "Return the name of THREAD."
  (sb-thread:thread-name thread))

(defun all-threads ()
  "Return a list of all threads."
  (sb-thread:list-all-threads))

(defun destroy-thread (thread)
  "Terminate THREAD. Use with caution."
  (sb-thread:terminate-thread thread))

;;; Locks (mutexes)

(defun make-lock (&key (name "anonymous-lock"))
  "Create a new mutex lock."
  (sb-thread:make-mutex :name name))

(defun acquire-lock (lock &key (wait t))
  "Acquire LOCK. If WAIT is nil, return immediately if lock unavailable."
  (sb-thread:grab-mutex lock :waitp wait))

(defun release-lock (lock)
  "Release LOCK."
  (sb-thread:release-mutex lock))

(defmacro with-lock-held ((lock) &body body)
  "Execute BODY with LOCK held."
  `(sb-thread:with-mutex (,lock)
     ,@body))

;;; Condition variables

(defun make-condition-variable (&key (name "anonymous-condvar"))
  "Create a new condition variable."
  (sb-thread:make-waitqueue :name name))

(defun condition-wait (condition-variable lock &key timeout)
  "Wait on CONDITION-VARIABLE, releasing LOCK atomically.
LOCK is reacquired before returning.
If TIMEOUT is provided, wait at most that many seconds."
  (if timeout
      (sb-thread:condition-wait condition-variable lock :timeout timeout)
      (sb-thread:condition-wait condition-variable lock)))

(defun condition-notify (condition-variable)
  "Wake one thread waiting on CONDITION-VARIABLE."
  (sb-thread:condition-notify condition-variable))

(defun condition-broadcast (condition-variable)
  "Wake all threads waiting on CONDITION-VARIABLE."
  (sb-thread:condition-broadcast condition-variable))

;;; Semaphores

(defstruct (semaphore (:constructor %make-semaphore))
  "A counting semaphore."
  (lock (sb-thread:make-mutex :name "semaphore-lock"))
  (condvar (sb-thread:make-waitqueue :name "semaphore-condvar"))
  (count 0 :type fixnum))

(defun make-semaphore (&key (count 0) (name "anonymous-semaphore"))
  "Create a semaphore with initial COUNT."
  (declare (ignore name))
  (%make-semaphore :count count))

(defun semaphore-wait (semaphore &key timeout)
  "Decrement SEMAPHORE, blocking if count is zero.
If TIMEOUT is provided (in seconds), return NIL if timeout expires."
  (let ((deadline (when timeout (+ (get-internal-real-time)
                                   (* timeout internal-time-units-per-second)))))
    (sb-thread:with-mutex ((semaphore-lock semaphore))
      (loop while (zerop (semaphore-count semaphore))
            do (let ((remaining (when deadline
                                  (/ (- deadline (get-internal-real-time))
                                     internal-time-units-per-second))))
                 (when (and remaining (<= remaining 0))
                   (return-from semaphore-wait nil))
                 (sb-thread:condition-wait (semaphore-condvar semaphore)
                                           (semaphore-lock semaphore)
                                           :timeout remaining)))
      (decf (semaphore-count semaphore))
      t)))

(defun semaphore-signal (semaphore &optional (count 1))
  "Increment SEMAPHORE by COUNT, waking waiting threads."
  (sb-thread:with-mutex ((semaphore-lock semaphore))
    (incf (semaphore-count semaphore) count)
    (dotimes (i count)
      (sb-thread:condition-notify (semaphore-condvar semaphore)))))
