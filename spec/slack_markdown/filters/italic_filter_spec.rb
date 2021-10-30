# frozen_string_literal: true

require 'spec_helper'

describe SlackMarkdown::Filters::ItalicFilter do
  subject do
    filter = SlackMarkdown::Filters::ItalicFilter.new(text)
    filter.call.to_s
  end

  context '_hoge_' do
    let(:text) { '_hoge_' }
    it { should eq '<i>hoge</i>' }
  end

  context 'hoge_fuga_poyo' do
    let(:text) { 'hoge_fuga_poyo' }
    it { should eq 'hoge_fuga_poyo' }
  end

  context 'hoge _fuga_ poyo' do
    let(:text) { 'hoge _fuga_ poyo' }
    it { should eq 'hoge <i>fuga</i> poyo' }
  end
end
