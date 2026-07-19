(function () {
  function initForm(form) {
    var status = form.querySelector(".subscribe-status");
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var worker = form.getAttribute("data-worker");
      var email = form.querySelector('input[type="email"]').value;
      var tokenEl = form.querySelector('[name="cf-turnstile-response"]');
      var token = tokenEl ? tokenEl.value : "";
      var source = form.getAttribute("data-source") || "";
      status.textContent = "送出中…";
      fetch(worker + "/api/subscribe", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: email, turnstileToken: token, source: source }),
      })
        .then(function (r) { return r.json().then(function (d) { return { ok: r.ok, d: d }; }); })
        .then(function (res) {
          if (res.ok) {
            status.textContent = res.d.already
              ? "你已經訂閱過囉,謝謝!"
              : "太好了!請到信箱點擊確認連結。";
            form.reset();
            if (window.turnstile) window.turnstile.reset();
          } else {
            status.textContent = "訂閱失敗,請確認 email 或稍後再試。";
          }
        })
        .catch(function () { status.textContent = "網路錯誤,請稍後再試。"; });
    });
  }
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".subscribe-form").forEach(initForm);
  });
})();
