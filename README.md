# Emacs fringe-hide minor mode

Hide buffer left, right or both fringes.  Read mode documentation
or/and source code for more details.  Examples:

```elisp
;; M-x fringe-hide-mode
;; M-x fringe-hide

(fringe-hide-mode  1)
(fringe-hide-mode -1)

(fringe-hide "left")
(fringe-hide "right-margin")
(fringe-hide "both")
(fringe-hide "show")
```
