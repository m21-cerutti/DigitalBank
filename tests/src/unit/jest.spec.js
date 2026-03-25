test('fr-FR', () => {
  const f = (n) => n.toLocaleString('fr-FR', { minimumFractionDigits: 2 });
  expect(f(1234.5)).toBe('1 234,50');
});
