# frozen_string_literal: true

RSpec.describe RSpecHTML::Matchers do # rubocop:disable RSpec/FilePath
  subject { parse_html(fixture(:html, 'basic').read) }

  describe '#contain_tag' do
    it { is_expected.to contain_tag :span, class: 'example-class' }
    it { is_expected.not_to contain_tag :span, class: 'example-class', align: 'right' }
  end

  describe '#match_text' do
    it { is_expected.to match_text 'example body content' }
    it { is_expected.to match_text(/example [body]+ content/) }
    it { is_expected.not_to match_text(/example [xyz]+ content/) }
    it { is_expected.not_to match_text(/non-existent body content/) }
    its(:span) { is_expected.to match_text 'more example body content' }
    its(:p) { is_expected.to match_text(/Paragraph [a-z]+ spacing/) }

    context 'with unexpected argument' do
      it 'raises ArgumentError' do # rubocop:disable RSpec/MultipleExpectations
        expect { expect('foo').to match_text 'bar' }.to raise_error ArgumentError # rubocop:disable RSpec/ExpectActual
      end
    end
  end

  describe '#once' do
    it { is_expected.to match_text('more example body content').once }
    it { is_expected.to contain_tag(:span, class: 'another-class').once }
    it { is_expected.not_to match_text('example body content').once }
    it { is_expected.not_to match_text('non-existent content').once }
    it { is_expected.not_to contain_tag(:div, class: 'class1').once }
  end

  describe '#twice' do
    it { is_expected.to match_text('example body content').twice }
    it { is_expected.to contain_tag(:div, class: 'class1').twice }
    it { is_expected.not_to match_text('more example body content').twice }
    it { is_expected.not_to match_text('non-existent content').twice }
    it { is_expected.not_to contain_tag(:span, class: 'another-class').twice }
  end

  describe '#times' do
    it { is_expected.to match_text('example body content').times(2) }
    it { is_expected.to match_text('more example body content').times(1) }
    it { is_expected.to contain_tag(:div, class: 'class1').times(2) }
    it { is_expected.not_to match_text('non-existent content').times(1) }
    it { is_expected.not_to contain_tag(:span, class: 'another-class').times(2) }
  end

  describe '#at_least' do
    it { is_expected.to match_text('example body content').at_least.times(2) }
    it { is_expected.to match_text('example body content').at_least(:twice) }
    it { is_expected.to match_text('more example body content').at_least(:once) }
    it { is_expected.to contain_tag(:div, class: 'class1').at_least(:once) }
    it { is_expected.to contain_tag(:div).at_least(:twice) }
  end

  describe '#at_most' do
    it { is_expected.to match_text('example body content').at_most.times(2) }
    it { is_expected.to match_text('example body content').at_most(:twice) }
    it { is_expected.to match_text('more example body content').at_most(:once) }
    it { is_expected.to contain_tag(:div, class: 'class2').at_most(:twice) }
    it { is_expected.to contain_tag(:span, class: 'another-class').at_most(:once) }
    it { is_expected.to contain_tag(:label).at_most.times(6) }
  end

  describe 'custom root element' do
    subject(:root_element) { parse_html(fixture(:html, 'basic').read) }

    it { is_expected.to be_a RSpecHTML::Element }
  end
end
