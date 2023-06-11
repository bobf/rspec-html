# Counters

The [`match_text`](matchers/match_text.html) and [`contain_tag`](matchers/contain_tag.html) matchers support a counting interface to verify the number of occurrences of a given element specification within a document.

The following methods can be added to a `match_text` or `contain_tag` call:

* `#once`
* `#twice`
* `#times(n)`
* `#at_least(:once)`, `#at_least(:twice)`, `#at_least.times(n)`
* `#at_most(:once)`, `#at_most(:twice)`, `#at_most.times(n)`

## Exact Counts

```rspec:html
subject(:document) { parse_html('<div>my div</div>') }

it 'has one div' do
  expect(document.div).to match_text('my div').once
end
```

```rspec:html
subject(:document) { parse_html('<div>my div</div><div>my div</div>') }

it 'has one div' do
  expect(document.div).to match_text('my div').twice
end
```

```rspec:html
subject(:document) { parse_html('<div>my div</div><div>my div</div><div>my div</div>') }

it 'has one div' do
  expect(document.div).to match_text('my div').times(3)
end
```

## Minimum/Maximum Counts

```rspec:html
subject(:document) { parse_html('<div>my div</div><div>my div</div><div>my div</div>') }

it 'has at least two divs' do
  expect(document.div).to match_text('my div').at_least(:twice)
end
```

```rspec:html
subject(:document) { parse_html('<div>my div</div><div>my div</div><div>my div</div>') }

it 'has at most three divs' do
  expect(document.div).to match_text('my div').at_most.times(3)
end
```
