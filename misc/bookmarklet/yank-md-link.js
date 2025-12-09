javascript: (function () {
  var s = window.getSelection().toString().trim();
  var t = document.title;
  var u = window.location.href;

  if (s) {
    u = window.location.href.split("#")[0] + "#:~:text=" + encodeURIComponent(s);
    t = t + " | " + s;
  }

  var md = "[" + t.replace(/[\[\]]/g, "\\$&") + "](" + u + ")";
  navigator.clipboard.writeText(md);

  var toast = document.createElement("div");
  toast.textContent = "Yanked " + t;
  toast.style.cssText =
    "position:fixed;bottom:20px;right:20px;background:#333;color:#fff;padding:10px 14px;border-radius:8px;font-size:14px;line-height:1.4;z-index:999999;opacity:0;transition:opacity 0.3s;max-width:300px;word-break:break-word";
  document.body.appendChild(toast);

  setTimeout(function () {
    toast.style.opacity = "1";
  }, 10);

  setTimeout(function () {
    toast.style.opacity = "0";
    setTimeout(function () {
      toast.remove();
    }, 300);
  }, 2000);

  history.replaceState(
    null,
    "",
    window.location.href.split("#")[0] +
      window.location.hash.replace(/#:~:text=.*/, "")
  );

  void 0;
})();