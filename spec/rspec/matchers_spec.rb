# frozen_string_literal: true

RSpec.describe RSpecHTML::Matchers do
  subject do
    parse_html(fixture(:html, 'basic').read)
    document
  end

  describe 'contain_text' do
    it { is_expected.to contain_text 'example body content' }
    it { is_expected.to_not contain_text 'non-existent body content' }
    its(:p) { is_expected.to contain_text 'Paragraph with spacing' }
  end

  describe 'contain_tag' do
    it { is_expected.to contain_tag :span, class: 'example-class' }
    it { is_expected.to_not contain_tag :span, class: 'example-class', align: 'right' }
  end

  describe 'match_text' do
    it { is_expected.to match_text 'example body content' }
    it { is_expected.to match_text(/example [body]+ content/) }
    it { is_expected.to_not match_text(/example [xyz]+ content/) }
    it { is_expected.to_not match_text(/non-existent body content/) }
    its(:p) { is_expected.to match_text(/Paragraph [a-z]+ spacing/) }
  end
end
