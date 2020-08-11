RSpec.describe RSpecHTML::Matchers do
  subject do
    parse_html(fixture(:html, 'basic').read)
    document
  end

  describe 'contain_text' do
    it { is_expected.to contain_text 'example body content' }
  end

  describe 'contain_tag' do
    it { is_expected.to contain_tag(:span, class: 'example-class') }
  end
end
