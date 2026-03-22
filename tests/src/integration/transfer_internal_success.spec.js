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

test('virement interne réussi entre deux comptes', async () => {
  await bootApp();
  document.querySelector('#email').value = 'test@digitalbank.fr';
  document.querySelector('#password').value = 'Test1234!';
  document
    .querySelector('#login-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 20));

  document.querySelector('[data-testid="tab-transfer"]').click();
  await new Promise((r) => setTimeout(r, 20));

  const toSelect = document.querySelector('#to-account');
  if (toSelect) {
    const opts = Array.from(toSelect.options).filter((o) => o.value);
    toSelect.value = opts[opts.length - 1].value;
    toSelect.dispatchEvent(new Event('change', { bubbles: true }));
  }

  document.querySelector('#amount').value = '100';
  document
    .querySelector('#transfer-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 1600));

  const success = document.querySelector('[data-testid="transfer-success"]');
  expect(success).toBeInTheDocument();
  expect(success.classList.contains('hidden')).toBe(true);
});
