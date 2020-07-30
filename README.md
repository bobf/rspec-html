# RSpec::HTML

_RSpec::HTML_ provides a simple object interface to HTML responses from [_RSpec Rails_ request specs](https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec).

## Installation

```ruby
gem 'rspec-html', '~> 0.2.1'
```

Bundle
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-html

## Usage

Require the gem in your `spec_helper.rb`:

```
# spec/spec_helper.rb
require 'rspec/html'
```

### Object Interface

The top-level object `document` is available in all tests which reflects the current response body (e.g. in request specs).

If you need to parse _HTML_ manually you can use the provided `parse_html` helper and then access `document` as normal:

```ruby
before { parse_html('<html><body>hello</body></html>') }
it 'says hello' do
  expect(document.body).to include 'hello'
end
```

To navigate the _DOM_ by a sequence of tag names use chained method calls on the `document` object:

#### Tag Traversal
```ruby
expect(document.body.div.span).to include 'some text'
```

#### Attribute Matching
To select an element matching certain attributes pass a hash to any of the chained methods:
```ruby
expect(document.body.div(id: 'my-div').span(align: 'left')).to include 'some text'
```

#### Class Matching
CSS classes are treated as a special case: to select an element matching a specific class (or array of classes) pass the `class` parameter:
```ruby
expect(document.body.div(id: 'my-div').span(class: 'my-class')).to include 'some text'
expect(document.body.div(id: 'my-div').span(class: ['my-class', 'my-other-class'])).to include 'some text'
```

#### Attribute Retrieval
To select an attribute from an element use the hash-style interface:
```ruby
expect(document.body.div.span[:class]).to include 'my-class'
expect(document.body.div.span['data-content']).to include 'my content'
```

#### Indexing a Matching Set
To select an index from a set of matched elements use the array-style interface (the first matching element is `1`, not `0`):
```ruby
expect(document.body.div[1].span[1][:class]).to include 'my-class'
```

#### Element Existence
To test if a matching element was found use the `exist` matcher:
```ruby
expect(document.body.div[1]).to exist
expect(document.body.div[4]).to_not exist
```

#### Length of matched attributes
To test the length of matched elements use the `#size` or `#length` method:
```ruby
expect(document.body.div.size).to eql 3
expect(document.body.div.length).to eql 3
```

#### XPath / CSS Selectors
If you need something more specific you can always use the _Nokogiri_ `#xpath` and `#css` methods on any element:
```ruby
expect(document.body.xpath('//span[@class="my-class"]')).to include 'some text'
expect(document.body.css('span.my-class')).to include 'some text'
```

To simply check that an _XPath_ or _CSS_ selector exists use `have_xpath` and `have_css`:
```ruby
expect(document.body).to have_css 'html body div.myclass'
expect(document.body).to have_xpath '//html/body/div[@class="myclass"]'
```

## Contributing

Feel free to make a pull request.

## License

[MIT License](LICENSE)
