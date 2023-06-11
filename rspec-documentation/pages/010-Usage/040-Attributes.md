# Attributes

If you need to verify the exact value of an attribute, use `Hash` key lookup syntax by calling `#[]`.

```rspec:html
subject(:document) do
  parse_html('<div><input type="text" value="my-value"></div>')
end

it 'has an input whose value is "my-value"' do
  expect(document.div.input[:value]).to eql 'my-value'
end
```

One particular use case that makes this especially useful is retrieving an anti-CSRF token from a form before submitting a `POST` or `PATCH` request:

```rspec:html
it 'submits a user form' do
  get '/users/new'
  token = document.form.input(name: 'authenticity_token')[:value]
  post '/users', params: { user: { email: 'user@example.com' }, authenticity_token: token }
  expect(document.div('.flash.notice')).to match_text 'User successfully created'
end
```
