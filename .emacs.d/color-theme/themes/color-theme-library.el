;;; color-theme-library.el --- The real color theme functions

;; Copyright (C) 2005, 2006  Xavier Maillard <zedek@gnu.org>
;; Copyright (C) 2005, 2006  Brian Palmer <bpalmer@gmail.com>

;; Version: 0.0.9
;; Keywords: faces
;; Author: Brian Palmer, Xavier Maillard
;; Maintainer: Xavier Maillard <zedek@gnu.org>
;; URL: http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme

;; This file is not (YET) part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2, or (at your option) any later
;; version.
;;
;; This is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;; Code:
(eval-when-compile
  (require 'color-theme))

(defun color-theme-wombat ()
  "Color theme by Ben Lowery, based off the Wombat Vim theme by Lars H. Nielsen @ http://dengmao.wordpress.com/2007/01/22/vim-color-scheme-wombat/"
  (interactive)
  (color-theme-install
   '(color-theme-wombat
     ((background-color . "#121212")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "#508")
      (foreground-color . "#9090a0"))
     (default ((t (:background "#121212" :foreground "#9090a0"))))
     (border-glyph ((t (nil))))
     (buffers-tab ((t (:background "#121212" :foreground "#9090a0"))))
     (font-lock-builtin-face ((t (:background "#121212" :foreground "#308040"))))
     (font-lock-comment-face ((t (:foreground "#5080a0"))))
     (font-lock-constant-face ((t (:foreground "#a16261"))))
     (font-lock-doc-string-face ((t (:italic t :foreground "#5080a0"))))
     (font-lock-function-name-face ((t (:foreground "#308040"))))
     (font-lock-variable-name-face ((t (:foreground "#308040"))))
     (font-lock-keyword-face ((t (:foreground "#a4a338"))))
     (font-lock-preprocessor-face ((t (:foreground "#a54140"))))
     (font-lock-reference-face ((t (:foreground "#5080a0"))))
     (font-lock-apply-highlight ((t (:background "#6d8824" :foreground "white"))))

     (font-lock-add-keywords ((t (:foreground "#a4a338"))))
     (font-lock-compile-keyword ((t (:foreground "#a4a338"))))
     (font-lock-eval-keywords ((t (:foreground "#a4a338"))))
     (font-lock-choose-keywords ((t (:foreground "#a4a338"))))

     (font-lock-mode-internal ((t (:foreground "#5080a0"))))
     (font-lock-string-face ((t (:foreground "#a16261"))))
     (font-lock-type-face ((t (:foreground "#a4a338"))))

     (font-lock-warning-face ((t (:bold t :foreground "#b03030"))))
     
     (region ((t (:background "#6d8824" :foreground "white"))))
     (mode-line ((t (:background "#313131" :foreground "#9090a0"))))
     (minibuffer-prompt ((t (:foreground "#a4a338"))))
     (minibuffer-completion-contents ((t (:foreground "#308040"))))
     (highline-face ((t (:foreground "white":background "#6d8824"))))
     (italic ((t (nil))))
     (left-margin ((t (nil))))
     (show-paren-match ((t (:background "#b3b3df" :foreground "#9090a0" :bold t))))
     (toolbar ((t (nil))))
     (org-todo ((t (:foreground "#a4a338" :bold t))))
     (org-hide ((t (:foreground "#0b0b0b"))))
     (cperl-nonoverridable-face ((t (:foreground "#a4a338"))))
     (cperl-hash-face((t (:foreground "#308040"))))
     (cperl-highlight-charclass ((t (:foreground "#308040"))))
     (cperl-forward-group-in-re ((t (:foreground "#003030" :background "#121212"))))
     (cperl-backward-to-start-of-continued-exp ((t (:background "#121212" :foreground "#003030"))))
     (cperl-highlight-variables-indiscriminately ((t (nil))))
     (cperl-array-face ((t (:foreground "#308040"))))
     (cperl-val ((t (:foreground "#308040"))))
     (cperl-beautify-regexp-piece ((t (:background "#121212" :foreground "white"))))
)))
