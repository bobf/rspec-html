# RSpec::HTML

_RSpec::HTML_ provides a simple object interface to HTML responses from [_RSpec Rails_ request specs](https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec).

## Installation

Add the gem to your `Gemfile`:

```ruby
gem 'rspec-html', '~> 0.2.13'
```

And rebuild your bundle:

```bash
$ bundle install
```

## Usage

Require the gem in your `spec_helper.rb`:

```
# spec/spec_helper.rb
require 'rspec/html'
```

Several [matchers](#matchers) are provided to identify text and _HTML_ elements within the _DOM_. These matchers can only be used with the provided [object interface](#object-interface).

### Object Interface
<a name="object-interface"></a>

The top-level object `document` is available in all tests which reflects the current response body (e.g. in request specs).

If you need to parse _HTML_ manually you can use the provided `parse_html` helper and then access `document` as normal:

```ruby
before { parse_html('<html><body>hello</body></html>') }
it 'says hello' do
  expect(document.body).to contain_text 'hello'
end
```

This method can also be used for _ActionMailer_ emails:
```ruby
before { parse_html(ActionMailer::Base.deliveries.last.body.decoded) }
```

To navigate the _DOM_ by a sequence of tag names use chained method calls on the `document` object:

#### Tag Traversal
```ruby
expect(document.body.div.span).to contain_text 'some text'
```

#### Attribute Matching
To select an element matching certain attributes pass a hash to any of the chained methods:
```ruby
expect(document.body.div(id: 'my-div').span(align: 'left')).to contain_text 'some text'
```

Special attributes like `checked` can be found using the `#attributes` method:
```ruby
expect(document.input(type: 'checkbox', name: 'my-name')).attributes).to include 'checked'
```

#### Class Matching
_CSS_ classes are treated as a special case: to select an element matching a set of classes pass the `class` parameter:
```ruby
expect(document.body.div(id: 'my-div').span(class: 'my-class')).to contain_text 'some text'
expect(document.body.div(id: 'my-div').span(class: 'my-class my-other-class')).to contain_text 'some text'
```

Classes can be provided in any order, i.e. `'my-class my-other-class'` is equivalent to `'my-other-class my-class'`.

#### Simple CSS Matching
To use a simple CSS selector when no other attributes are needed, pass a string to the tag method:
```ruby
expect(document.body.div('#my-id.my-class1.my-class2')).to contain_text 'some text'
```

This is effectively shorthand for:
```ruby
expect(document.body.div(id: 'my-id', class: 'my-class1 my-class2')).to contain_text 'some text'
```

#### Text Matching
To select an element that includes a given text string (i.e. excluding mark-up) use the `text` option:
```ruby
expect(document.body.div(text: 'some text').input[:value]).to eql 'some-value'
```

#### Attribute Retrieval
To select an attribute from an element use the hash-style interface:
```ruby
expect(document.body.div.span[:class]).to contain_text 'my-class'
expect(document.body.div.span['data-content']).to contain_text 'my content'
```

#### Retrieve all matching elements
To select all matching elements as an array, use `#all`:
```ruby
expect(document.span.all.map(&:text)).to eql ['foo', 'bar', 'baz']
```

#### Indexing a Matching Set
To select an index from a set of matched elements use the array-style interface (the first matching element is `1`, not `0`):
```ruby
expect(document.body.div[1].span[1][:class]).to contain_text 'my-class'
```

Alternatively, use `#first`, `#last` or, when using _ActiveSupport_, `#second`, `#third`, etc. are also available:

```ruby
expect(document.body.div.first.span.last[:class]).to contain_text 'my-class'
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
expect(document.body.xpath('//span[@class="my-class"]')).to contain_text 'some text'
expect(document.body.css('span.my-class')).to contain_text 'some text'
```

To simply check that an _XPath_ or _CSS_ selector exists use `have_xpath` and `have_css`:
```ruby
expect(document.body).to have_css 'html body div.myclass'
expect(document.body).to have_xpath '//html/body/div[@class="myclass"]'
```

#### Checkboxes

Use `be_checked` to test if a checkbox is checked:
```ruby
expect(document.input(type: 'checkbox')).to be_checked
```

### Custom Matchers
<a name="matchers"></a>

#### match_text

Use the `match_text` matcher to locate text within a _DOM_ element. All mark-up elements are stripped when using this matcher.

This matcher receives either a string or a regular expression.

```ruby
expect(document.body.form).to match_text 'Please enter your password'
expect(document.body.form).to match_text /Please enter your [a-z]+/
```

#### contain_tag

Use the `contain_tag` matcher to locate _DOM_ elements within any given element. This matcher accepts two arguments:

* The tag name of the element you want to match (e.g. `:div`);
* _(Optional)_ A hash of options. All options supported by the [object interface](#object-interface) can be used here.

Without options:
```ruby
expect(document.div(class: 'my-class')).to contain_tag :span
```

With options:
```ruby
expect(document.form(class: 'my-form')).to contain_tag :input, name: 'email', class: 'email-input'
```

## Contributing

Feel free to make a pull request.

## License

[MIT License](LICENSE)
