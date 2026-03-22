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

test('réinitialisation mot de passe: email existant -> succès', async () => {
  await bootApp();
  document.querySelector('[data-testid="link-forgot-password"]').click();
  await new Promise((r) => setTimeout(r, 20));

  document.querySelector('#reset-email').value = 'test@digitalbank.fr';
  document
    .querySelector('#reset-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 10));

  const ok = document.querySelector('[data-testid="reset-success"]');
  expect(ok).toBeInTheDocument();
  expect(ok.classList.contains('hidden')).toBe(false);
});
