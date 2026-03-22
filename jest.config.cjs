/** @type {import('jest').Config} */
module.exports = {
  testEnvironment: 'jsdom',
  transform: {
    '^.+\.[jt]sx?$': 'babel-jest',
  },
  setupFilesAfterEnv: ['<rootDir>/tests/src/unit/setup-tests.js'],
  testMatch: ['<rootDir>/tests/src/**/*.spec.js'],
  verbose: true,
};
