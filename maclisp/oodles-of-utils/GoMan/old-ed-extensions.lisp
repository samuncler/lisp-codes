(defmethod ed-delete-char :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-delete-forward-whitespace :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-delete-whitespace :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-delete-word :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-insert-char :after ((self source-window-embedded-fred-di) char)   (declare (ignore char))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-insert-double-quotes :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-insert-sharp-comment :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-insert-with-style :after ((self source-window-embedded-fred-di) string style &optional pos)   (declare (ignore string style pos))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-kill-backward-sexp :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-kill-forward-sexp :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-kill-line :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-kill-region :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-kill-selection :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-newline-and-indent :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-rubout-char :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-rubout-word :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-self-insert :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self))  t))(defmethod ed-self-transpose-chars :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self))  t))(defmethod ed-self-transpose-sexps :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self))  t))(defmethod ed-self-transpose-words :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self))  t))(defmethod ed-yank :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod ed-yank-pop :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod paste :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self)) t))(defmethod cut :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self))  t))(defmethod clear :after ((self source-window-embedded-fred-di))   (setf (source-buffer-changed-p (document self))  t))