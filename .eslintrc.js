module.exports = {
  env: {
    browser: true,
    es6: true,
    jquery: true,
  },
  extends: [
    'eslint:recommended',
    'prettier'
  ],
  globals: {
    Atomics: 'readonly',
    SharedArrayBuffer: 'readonly',
    EOC: 'writable'
  },
  parserOptions: {
    ecmaVersion: 2018,
  },
  plugins: [
    'prettier'
  ],
  rules: {
    'prettier/prettier': 'error'
  },
};
