;; �����Ƥ��뤹�٤ƤΥХåե���kill����
(defun kill-all-buffers ()
  (interactive)
  (dolist (buf (buffer-list))
	  (kill-buffer buf)))


;; Local Variables:
;; mode : emacs-lisp
;; coding : euc-jp-unix
;; End: