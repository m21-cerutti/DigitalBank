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

test('affiche une erreur si identifiants invalides', async () => {
  await bootApp();
  document.querySelector('#email').value = 'wrong@example.com';
  document.querySelector('#password').value = 'bad';
  document
    .querySelector('#login-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 5));
  const err = document.querySelector('[data-testid="login-error"]');
  expect(err).toBeInTheDocument();
  expect(err.classList.contains('hidden')).toBe(false);
  expect(err.textContent).toMatch(/incorrect/i);
});
