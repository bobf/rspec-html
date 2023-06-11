# Response Inspection

## Browser Inspection

To make debugging a little easier, the output of the parsed document can be loaded into your operating system's default web browser by calling `document.open`.

```ruby
it 'has complex HTML' do
  get '/my/path'
  document.open
end
```

## String Inspection

Alternatively, the document can be printed to `stdout` by calling `puts document`.

```ruby
it 'has complex HTML' do
  get '/my/path'
  puts document
end
```
