const js = require('@eslint/js');
const globals = require('globals');
const prettier = require('eslint-config-prettier');
const eslintPluginPrettier = require('eslint-plugin-prettier');

module.exports = [
  // Dossiers à ignorer globalement
  {
    ignores: [
      '**/node_modules/**',
      '**/dist/**',
      '**/build/**',
      '**/coverage/**',
      '**/.venv/**',
      '**/results/**',
    ],
  },

  // Base JavaScript (ES modules par défaut)
  {
    ...js.configs.recommended,
    files: ['**/*.{js,mjs,cjs}'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals: {
        // Si tu es full Node (pas de front), tu peux enlever `...globals.browser`
        ...globals.browser,
        ...globals.node,
      },
    },
    rules: {
      // Tes surcharges éventuelles ici
      // ex: 'no-console': 'warn'
    },
  },

  // Spécifique CommonJS : .cjs en sourceType 'commonjs'
  {
    files: ['**/*.cjs'],
    languageOptions: {
      sourceType: 'commonjs',
    },
  },

  // Intégration Prettier : désactive les règles conflictuelles + lève erreur si non formaté
  prettier,
  {
    plugins: { prettier: eslintPluginPrettier },
    rules: {
      'prettier/prettier': 'error',
    },
  },
];
