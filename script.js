document.addEventListener('DOMContentLoaded', () => {
  const status = document.getElementById('status');
  const button = document.getElementById('actionButton');

  const setStatus = (message) => {
    status.textContent = message;
  };

  const isTauri = Boolean(window.__TAURI__ || window.__TAURI_INTERNALS__);
  const isMobileUA = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

  setStatus(isTauri ? 'Rodando com Tauri.' : 'Rodando no navegador.');

  button?.addEventListener('click', () => {
    const env = isTauri ? 'Tauri' : isMobileUA ? 'mobile web' : 'desktop web';
    setStatus(`Hello World a partir do ${env}!`);
  });
});
