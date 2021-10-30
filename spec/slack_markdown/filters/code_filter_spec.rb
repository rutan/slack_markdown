# frozen_string_literal: true

require 'spec_helper'

describe SlackMarkdown::Filters::CodeFilter do
  subject do
    filter = SlackMarkdown::Filters::CodeFilter.new(text)
    filter.call.to_s
  end

  context '`hoge`' do
    let(:text) { '`hoge`' }
    it { should eq '<code>hoge</code>' }
  end

  context '`hoge` fuga `piyo`' do
    let(:text) { '`hoge` fuga `piyo`' }
    it { should eq '<code>hoge</code> fuga <code>piyo</code>' }
  end
end
