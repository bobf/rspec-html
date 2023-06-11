# XPath

If the provided _DOM_ navigation syntax does not provide a way for you to definitively select the required element, [_XPath_](https://developer.mozilla.org/en-US/docs/Web/XPath) is available via the `#xpath` method which delegates directly to the underlying [`Nokogiri::HTML::Document`](https://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/HTML/Document) object.

```rspec:html
subject(:document) do
  parse_html('<table><tr><td>My content</td></table>')
end

it 'matches using xpath' do
  expect(document.xpath('//table/tr/td').text).to eql 'My content'
end
```
