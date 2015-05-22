# encoding: utf-8
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
end
