(require 'org-publish)

(defun copy-resources ()
  (if (file-exists-p "build") 
      (delete-directory "build" t))
  (make-directory "build")
  (dolist (dir '("css" "images" "img"))
    (shell-command (concat "ditto " dir " build/" dir))))

(setq org-publish-project-alist
      '(("cd" 
	 :base-directory "."
	 :preparation-function copy-resources
	 :publishing-directory "./build"
	 :style "<link rel=\"stylesheet\" href=\"css/main.css\" type=\"text/css\"/>"
	 :style-include-default t
	 :style-include-scripts t
	 :html-postamble ""
	 :table-of-contents t
	 :preserve-breaks nil
	 :auto-sitemap nil)))

(org-publish-all t)
