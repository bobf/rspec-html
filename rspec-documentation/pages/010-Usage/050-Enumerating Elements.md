# Enumerating Elements

Several interfaces exist to assist you if you need to test specifics about the number of elements that match a given element specification.

## `#all`

Use `#all` to retrieve all matched elements:

```rspec:html
subject(:document) { parse_html('<div>div #1</div><div>div #2</div><div>div #3</div>') }

it 'retrieves all matching elements' do
  expect(document.div.all).to all(match_text /div #[0-9]/)
end
```

## `#[]`

Use `#[]` to index a specific element from a matching set. Note that indexing starts at `1`, not `0`, so the first element in a set is `[1]`.

```rspec:html
subject(:document) { parse_html('<div>div #1</div><div>div #2</div><div>div #3</div>') }

it 'retrieves all matching elements' do
  expect(document.div[2]).to match_text 'div #2'
end
```

You can also use `#first` or `#last` if you prefer:

```rspec:html
subject(:document) { parse_html('<div>div #1</div><div>div #2</div><div>div #3</div>') }

it 'retrieves all matching elements' do
  expect(document.div.last).to match_text 'div #3'
end
```

## `#size`

Use `#size` to verify the length of a set of matched elements:

```rspec:html
subject(:document) { parse_html('<div>div #1</div><div>div #2</div><div>div #3</div>') }

it 'retrieves all matching elements' do
  expect(document.div.size).to eql 3
end
```
