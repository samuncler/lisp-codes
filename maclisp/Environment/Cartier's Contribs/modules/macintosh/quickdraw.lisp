;;; -*- package: CC -*-;;;;;;; Quickdraw utilities;;;(in-package "CC")(defmacro without-cursor (&body body)  `(unwind-protect       (progn         (#_HideCursor)         ,@body)     (#_ShowCursor)))(defmacro without-events (&body body)  `(unwind-protect       (progn         (setq *eventhook* (function true))         ,@body)     (setq *eventhook* nil)))(defun erase-window (window &optional (color *black-color*))  (with-focused-view window    (with-fore-color color      (#_PaintRect (rref (wptr window) :grafport.portrect)))))(defmethod draw-line ((view view) h1 v1 h2 v2)  (move-to view h1 v1)  (line-to view h2 v2))(defmethod center-rect ((view view) h v width height)  (frame-rect view (- h width) (- v height)                   (+ h width) (+ v height)))(defmethod center-oval ((view view) h v width height)  (frame-oval view (- h width) (- v height)                   (+ h width) (+ v height)))(let ((debug nil))  (defun debug-views ()    (prog1 (setq debug (not debug))      (if debug          (defmethod view-draw-contents :after ((self simple-view))            (with-fore-color *red-color*              (frame-rect self 0 (view-size self))))        (remove-method (function view-draw-contents)                       (find-method (function view-draw-contents)                                    (list :after)                                    (list (find-class 'simple-view)))))      (map-windows (function (lambda (window) (invalidate-view window t)))                   :include-windoids t))))