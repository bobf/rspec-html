# Selectors

Each method in the chain can receive arguments to specify selectors on attributes of each element.

To select an `<input>` element with a `name` attribute whose value is `email`, pass `name: 'email'` to the `input` method:

## Attribute Selectors

```rspec:html
it 'renders a name field' do
  get '/users/new'
  expect(document.form.input(name: 'user[email]')).to exist
end
```

## CSS Selectors

Since `class` is an attribute just like `name` you can specify the exact `class` string to match elements as `document.table(class: 'table users')`:

However, this test is very fragile - any change to the `class` attribute will cause the test to break, even if the order of the classes changes.

Instead, you can match using _CSS_ selectors by passing a string directly to each element method:

```rspec:html
it 'renders a users table' do
  get '/users'
  expect(document.table('.users')).to exist
end
```

Any valid _CSS_ selector is permitted:

```rspec:html
it 'renders a users table' do
  get '/users'
  expect(document.table('#users-table')).to exist
end
```

```rspec:html
it 'renders a users table' do
  get '/users'
  expect(document.table('tr td[class="name"]')).to exist
end
```
