# frozen_string_literal: true

RSpec.describe RSpecHTML::Body do
  subject(:entity) { described_class.new(html) }

  let(:html) { Nokogiri::HTML(fixture(:html, :basic).read) }

  it { is_expected.to be_a described_class }
  it_behaves_like 'searchable'
  it_behaves_like 'nameable'
end
