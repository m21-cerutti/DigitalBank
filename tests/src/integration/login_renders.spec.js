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

test('affiche la page de connexion par défaut', async () => {
  await bootApp();
  expect(document.querySelector('[data-testid="input-email"]')).toBeInTheDocument();
  expect(document.querySelector('[data-testid="input-password"]')).toBeInTheDocument();
  expect(document.querySelector('[data-testid="btn-login"]')).toBeInTheDocument();
});
