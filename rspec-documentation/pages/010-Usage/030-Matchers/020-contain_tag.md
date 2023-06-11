# `contain_tag`

The `contain_tag` matcher verifies that an element exists within your document.

The matcher receives a tag name as a `Symbol` and optionally receives a set of keyword arguments that refine the element definition.

```rspec:html
subject(:document) do
  parse_html('<html><body><table><tr><td align="center">td tag</td><tr></table></body></html>')
end

it 'matches an element' do
  expect(document.table).to contain_tag :td, align: 'center'
end
```
