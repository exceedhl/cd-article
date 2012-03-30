(require 'org-publish)

(defun copy-resources ()
  (if (file-exists-p "build") 
      (delete-directory "build" t))
  (make-directory "build")
  (dolist (dir '("css" "images"))
    (shell-command (concat "ditto " dir " build/" dir))))

(setq org-publish-project-alist
      '(("cd" 
	 :base-directory "."
	 :preparation-function copy-resources
	 :publishing-directory "./build"
	 :style "<link rel=\"stylesheet\" href=\"css/main.css\" type=\"text/css\"/>"
	 :style-include-default nil
	 :style-include-scripts nil
	 :html-postamble "<div id=\"disqus_thread\"></div>
<script type=\"text/javascript\">
  /**
    * var disqus_identifier; [Optional but recommended: Define a unique identifier (e.g. post id or slug) for this thread] 
    */
  (function() {
   var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
   dsq.src = 'http://huangliangblog.disqus.com/embed.js';
   (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
  })();
</script>
<noscript>Please enable JavaScript to view the <a href=\"http://disqus.com/?ref_noscript=huangliangblog\">comments powered by Disqus.</a></noscript>
<a href=\"http://disqus.com\" class=\"dsq-brlink\">blog comments powered by <span class=\"logo-disqus\">Disqus</span></a>

<script type=\"text/javascript\">
var disqus_shortname = 'huangliangblog';
(function () {
  var s = document.createElement('script'); s.async = true;
  s.src = 'http://disqus.com/forums/huangliangblog/count.js';
  (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
}());
</script>
"
	 :table-of-contents t
	 :preserve-breaks nil
	 :auto-sitemap nil)))

(org-publish-all t)
