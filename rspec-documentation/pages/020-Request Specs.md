# Request Specs

If you're using _RSpec_ `request` specs with _Rails_, a `document` object is available in all specs, wrapping the `response.body` of each request.

```rspec:html
it 'generates a users table' do
  get '/users'
  expect(document.table('.users').td('.email')).to match_text 'user@example.com'
end
```

This is equivalent to:

```rspec:html
let(:document) { parse_html(response.body) }

it 'generates a users table' do
  get '/users'
  expect(document.table('.users').td('.email')).to match_text 'user@example.com'
end
```
