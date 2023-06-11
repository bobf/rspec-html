# `match_text`

The `match_text` matcher filters out any tags and compacts whitespace to make matching strings within your _HTML_ more straightforward.

## Strings

```rspec:html
subject(:document) do
  parse_html '<div>Some     <span>text</span> with   <span>whitespace</span></div>'
end

it 'matches simple strings' do
  expect(document.div).to match_text 'Some text with whitespace'
end
```

## Regular Expressions

```rspec:html
subject(:document) do
  parse_html '<div>Some     <span>text</span> with   <span>whitespace</span></div>'
end

it 'matches simple strings' do
  expect(document.div).to match_text /text.*whitespace/
end
```
