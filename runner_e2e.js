const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

const projectRoot = path.resolve(__dirname);
const e2eDir = path.join(projectRoot, 'tests', 'src', 'e2e');

function usage() {
  console.error(`Usage:
  node scripts/run.js <commande> [args...]

Exemples :
  node scripts/run.js python -m pip --version
  node scripts/run.js robot -d output .
  node scripts/run.js black --check .
`);
}

const args = process.argv.slice(2);
if (args.length === 0) {
  usage();
  process.exit(1);
}

function quotePosix(a) {
  // entoure chaque arg par des quotes simples en échappant les quotes simples
  return "'" + String(a).replace(/'/g, `'\"'\"'`) + "'";
}
function quoteWin(a) {
  // approche pragmatique : double quotes et échappement des métacaractères
  const s = String(a).replace(/(["^&|<>])/g, '^$1');
  return '"' + s.replace(/"/g, '""') + '"';
}

const isWin = process.platform === 'win32';
const q = isWin ? quoteWin : quotePosix;

// Commande utilisateur complète (cmd + args)
const cmdline = args.join(' ');

// Vérifs chemin
if (!fs.existsSync(e2eDir)) {
  console.error(`Répertoire introuvable: ${e2eDir}`);
  process.exit(1);
}

// Prépare la ligne shell avec activation + exécution
let shell, shellArgs;
if (isWin) {
  // CMD : cd /d, puis call de l'activate.bat, puis commande
  const activate = path.join(e2eDir, '.venv', 'Scripts', 'Activate.ps1');
  const command = `cd ${quoteWin(e2eDir)} && ${activate} && ${cmdline}`;
  shell = 'pwsh';
  shellArgs = ['-Command', command];
} else {
  // Bash : cd, source de l'activate, puis commande
  const activate = path.join(e2eDir, '.venv', 'bin', 'activate');
  const command = `cd ${quotePosix(e2eDir)} && source ${quotePosix(activate)} && ${cmdline}`;
  shell = 'bash';
  shellArgs = ['-lc', command];
}

console.log(`${shell} ${shellArgs}`);
const child = spawn(shell, shellArgs, { stdio: 'inherit' });
child.on('exit', (code) => process.exit(code));
