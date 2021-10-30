# frozen_string_literal: true

require 'spec_helper'

describe SlackMarkdown::Filters::StrikeFilter do
  subject do
    filter = SlackMarkdown::Filters::StrikeFilter.new(text)
    filter.call.to_s
  end

  context '~hoge~' do
    let(:text) { '~hoge~' }
    it { should eq '<strike>hoge</strike>' }
  end

  context 'hoge~fuga~poyo' do
    let(:text) { 'hoge~fuga~poyo' }
    it { should eq 'hoge~fuga~poyo' }
  end

  context 'hoge ~fuga~ poyo' do
    let(:text) { 'hoge ~fuga~ poyo' }
    it { should eq 'hoge <strike>fuga</strike> poyo' }
  end
end
