# `exist`

The `exist` matcher verifies that a provided element specification exists in the document.

```rspec:html
subject(:document) do
  parse_html('<html><body><div><span class="my-span">my text</span></div></body></html>')
end

it 'verifies that an element exists' do
  expect(document.body.div.span('.my-span')).to exist
end
```
