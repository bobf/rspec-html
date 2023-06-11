# Introduction

_RSpec::HTML_ provides a simple object interface to _HTML_ content.

You can use _RSpec::HTML_ to test any _HTML_ produced by your library or application and it works out of the box with [_RSpec Rails_ request specs](https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec).

## Setup

Load `rspec-html` in your `spec_helper.rb`:

```ruby
# spec/spec_helper.rb

require 'rspec/html'
```

## Quick Example

```rspec:html
subject(:document) { parse_html(html) }

let(:html) do
  <<~HTML
  <html>
    <body>
      <div>Some other content</div>
      <div class="my-div">
        My div content
      </div>
    </body>
  </html>
  HTML
end

it 'matches "My div content"' do
  expect(document.html.body.div('.my-div')).to match_text 'My div content'
end
```
