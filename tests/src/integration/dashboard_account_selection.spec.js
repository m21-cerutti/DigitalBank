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

test.skip('sélection de compte dans le dashboard', async () => {
  await bootApp();
  document.querySelector('#email').value = 'test@digitalbank.fr';
  document.querySelector('#password').value = 'Test1234!';
  document
    .querySelector('#login-form')
    .dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  await new Promise((r) => setTimeout(r, 20));

  const cards = document.querySelectorAll('.balance-card');
  expect(cards.length).toBeGreaterThan(1);
  cards[1].click();
  await new Promise((r) => setTimeout(r, 10));
  const selected = document.querySelector('.balance-card.selected');
  // TODO Selected added, need compare data-testid
  expect(selected).toBe(cards[1]);
});
