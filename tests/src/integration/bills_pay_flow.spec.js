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

test("paiement d'une facture: ouverture du modal puis confirmation", async () => {
  await bootApp();
  document.querySelector('#email').value = 'test@digitalbank.fr';
  document.querySelector('#password').value = 'Test1234!';
  document
    .querySelector('#login-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 20));

  document.querySelector('[data-testid="tab-bills"]').click();
  await new Promise((r) => setTimeout(r, 20));

  const btn = document.querySelector('[data-testid^="btn-pay-bill-"]');
  expect(btn).toBeInTheDocument();
  btn.click();
  await new Promise((r) => setTimeout(r, 10));

  const modal = document.querySelector('[data-testid="modal-confirm-payment"]');
  expect(modal.classList.contains('hidden')).toBe(false);

  document.querySelector('[data-testid="btn-confirm-payment"]').click();

  await new Promise((r) => setTimeout(r, 1600));
  const success = document.querySelector('[data-testid="bill-success"]');
  expect(success).toBeInTheDocument();
  expect(success.classList.contains('hidden')).toBe(true);
});
