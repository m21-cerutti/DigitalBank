const fs = require('fs');
const path = require('path');

async function bootApp() {
  const htmlPath = path.resolve(__dirname, '../../../app/index.html');
  const html = fs.readFileSync(htmlPath, 'utf8');
  // extract inline <script>...</script>
  const scriptMatch = html.match(/<script>([\s\S]*?)<\/script>/);
  const script = scriptMatch ? scriptMatch[1] : '';
  // reset DOM (only body is needed)
  document.body.innerHTML = '<div class="app-container" id="app"></div>';
  // execute app script in current jsdom context

  eval(script);
  // fire DOMContentLoaded to trigger initial render
  document.dispatchEvent(new Event('DOMContentLoaded'));
  // wait a tick for render()
  await new Promise((r) => setTimeout(r, 10));
}

test('utilisateur 2FA: mauvaise saisie puis code valide 123456', async () => {
  await bootApp();
  document.querySelector('#email').value = 'marie.martin@email.com';
  document.querySelector('#password').value = 'SecurePass456!';
  document
    .querySelector('#login-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 20));

  // should be on 2FA page
  expect(document.querySelector('[data-testid="btn-verify-2fa"]')).toBeInTheDocument();

  // wrong code
  document.querySelector('[data-testid="2fa-code-0"]').value = '0';
  document.querySelector('[data-testid="2fa-code-1"]').value = '0';
  document.querySelector('[data-testid="2fa-code-2"]').value = '0';
  document.querySelector('[data-testid="2fa-code-3"]').value = '0';
  document.querySelector('[data-testid="2fa-code-4"]').value = '0';
  document.querySelector('[data-testid="2fa-code-5"]').value = '0';
  document.querySelector('[data-testid="btn-verify-2fa"]').click();
  await new Promise((r) => setTimeout(r, 10));
  const err = document.querySelector('[data-testid="2fa-error"]');
  expect(err).toBeInTheDocument();
  expect(err.classList.contains('hidden')).toBe(false);

  // correct code
  ['1', '2', '3', '4', '5', '6'].forEach((v, i) => {
    document.querySelector(`[data-testid="2fa-code-${i}"]`).value = v;
  });
  document.querySelector('[data-testid="btn-verify-2fa"]').click();
  await new Promise((r) => setTimeout(r, 20));
  expect(document.querySelector('[data-testid="header-user-name"]').textContent).toMatch(
    /Marie Martin/
  );
});
