# RSpec::HTML

_RSpec::HTML_ provides a simple object interface to HTML responses from [_RSpec Rails_ request specs](https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec).

## Installation

```ruby
gem 'rspec-html', '~> 0.2.0'
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

In request specs, access the HTML document through the provided object interface:

```ruby
RSpec.describe 'something', type: :request do
  it 'does something' do
    get '/'
    expect(document.body).to include 'something'
    expect(document.body).to have_css 'html body div.myclass'
    expect(document.body).to have_xpath '//html/body/div[@class="myclass"]'
    expect(document.body.div(class: 'myclass')['data-something']).to eql 'some-data'
  end
end
```

## Contributing

Feel free to make a pull request.

## License

[MIT License](LICENSE)
