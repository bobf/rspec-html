# The `document` Object

For [_RSpec Rails_ `request` specs](request-specs.html) the `document` object is already defined by _RSpec::HTML_ as the parsed response body.

If you are testing _HTML_ in any other context, e.g. for parsing _ActionMailer_ emails, simply define `document` with a `let` or `subject` block that calls the provided `parse_html` helper:

```rspec:html
subject(:document) { parse_html(ActionMailer::Base.deliveries.last.body.decoded) }

it 'contains a welcome message' do
  expect(document.div('.welcome-message')).to match_text 'Welcome to our website!'
end
```
