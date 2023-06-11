# `be_checked`

Use the `be_checked` matcher to verify that a checkbox input is checked.

```rspec:html
subject(:document) do
  parse_html('<form><input type="checkbox" checked></form>')
end

it 'renders a checked checkbox input' do
  expect(document.form.input(type: 'checkbox')).to be_checked
end
```
