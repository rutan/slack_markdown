# frozen_string_literal: true

require 'spec_helper'

describe SlackMarkdown::Filters::BoldFilter do
  subject do
    filter = SlackMarkdown::Filters::BoldFilter.new(text)
    filter.call.to_s
  end

  context '*hoge*' do
    let(:text) { '*hoge*' }
    it { should eq '<b>hoge</b>' }
  end

  context 'hoge*fuga*poyo' do
    let(:text) { 'hoge*fuga*poyo' }
    it { should eq 'hoge*fuga*poyo' }
  end

  context 'hoge *fuga* poyo' do
    let(:text) { 'hoge *fuga* poyo' }
    it { should eq 'hoge <b>fuga</b> poyo' }
  end
end
