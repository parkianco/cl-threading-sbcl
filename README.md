# cl-threading-sbcl

SBCL native threading wrapper using sb-thread with ZERO external dependencies.

## Installation

```lisp
(asdf:load-system :cl-threading-sbcl)
```

## API

### Threads
- `make-thread` - Create and start a thread
- `join-thread` - Wait for thread completion
- `thread-alive-p` - Check if thread is running
- `current-thread` - Get current thread

### Locks (Mutexes)
- `make-lock` - Create a mutex
- `with-lock-held` - Execute with lock held

### Condition Variables
- `make-condition-variable` - Create condition variable
- `condition-wait` - Wait on condition
- `condition-notify` - Signal one waiter
- `condition-broadcast` - Signal all waiters

### Semaphores
- `make-semaphore` - Create semaphore with count
- `semaphore-wait` - Decrement (blocking)
- `semaphore-signal` - Increment

## Example

```lisp
(let ((lock (make-lock))
      (result nil))
  (join-thread
   (make-thread (lambda ()
                  (with-lock-held (lock)
                    (setf result 42)))
                :name "worker"))
  result) ; => 42
```

## License

BSD-3-Clause. Copyright (c) 2024-2026 Parkian Company LLC.
