module.exports = {
  env: {
    node: true,
    es2024: true,
    jest: true,
  },
  extends: ['airbnb-base'],
  parserOptions: {
    ecmaVersion: 2024,
  },
  rules: {
    'no-console': 'warn',
    'no-unused-vars': ['error', { argsIgnorePattern: '^_|next' }],
    'consistent-return': 'off',
    'no-underscore-dangle': ['error', { allow: ['_id', '__v'] }],
    'class-methods-use-this': 'off',
    'import/order': ['error', { 'newlines-between': 'always' }],
  },
};
