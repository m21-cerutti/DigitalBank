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

test('affiche erreur si solde insuffisant', async () => {
  await bootApp();
  document.querySelector('#email').value = 'test@digitalbank.fr';
  document.querySelector('#password').value = 'Test1234!';
  document
    .querySelector('#login-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 20));

  document.querySelector('[data-testid="tab-transfer"]').click();
  await new Promise((r) => setTimeout(r, 20));

  document.querySelector('#amount').value = '999999';
  document
    .querySelector('#transfer-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 10));

  const err = document.querySelector('[data-testid="transfer-error"]');
  expect(err).toBeInTheDocument();
  expect(err.classList.contains('hidden')).toBe(false);
  expect(err.textContent).toMatch(/Solde insuffisant/i);
});
