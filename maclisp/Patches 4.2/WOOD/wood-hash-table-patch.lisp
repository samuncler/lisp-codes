; -*- Mode: Lisp; Package: WOOD; -*-; wood-hash-table-patch.lisp;; Always rehash a hash table after loading it. Use if you need to load; hash tables in MCL 4.x that were saved in MCL 3.x.(in-package :wood)(let ((*warn-if-redefine* nil)      (*warn-if-redefine-kernel* nil))(defun %initialize-hash-table (hash rehashF keytransF compareF vector count locked-additions)  (flet ((convert (f)           (cond ((symbolp f) (symbol-function f))                 ((listp f) (car f))                 (t f))))    (setf (ccl::nhash.rehashF hash) (symbol-function rehashF)          (ccl::nhash.keytransF hash) (convert keytransF)          (ccl::nhash.compareF hash) (convert compareF)          (ccl::nhash.vector hash) vector          (ccl::nhash.count hash) count          (ccl::nhash.locked-additions hash) locked-additions)    ; Rehash all hash tables. Everything hashes differently between 3.x and 4.x    (ccl::needs-rehashing hash)    (when (eq rehashF 'ccl::%no-rehash)      (ccl::%maybe-rehash hash)))))