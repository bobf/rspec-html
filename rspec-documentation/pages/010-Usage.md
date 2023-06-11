# Usage

_RSpec::HTML_ uses method chaining to traverse the Document Object Model (_DOM_).

## Implicit Navigation

Access a `<td>` tag anywhere in the document:

```rspec:html
it 'renders a user name' do
  get '/users'
  expect(document.td('.name')).to match_text 'Example User #1'
end
```

## Explicit Navigation

Or specify the full node tree explicitly to ensure your document's structure:

```rspec:html
it 'renders a user name' do
  get '/users'
  expect(document.body.table.tbody.tr.td('.name')).to match_text 'Example User #1'
end
```
