# encoding: utf-8

require 'html/pipeline'
require 'slack_markdown/filters/ignorable_ancestor_tags'

module SlackMarkdown
  module Filters
    class QuoteFilter < ::HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        html = doc.to_s.gsub(/^&gt;\s*(.+)(?:\n|$)/) do
          "<blockquote>#{$1}\n</blockquote>"
        end
        doc = Nokogiri::HTML.fragment(html)
        doc.search('blockquote + blockquote').each do |node|
          next unless node.previous.name == 'blockquote'
          html = "<blockquote>#{node.previous.inner_html}#{node.inner_html}</blockquote>"
          node.previous.remove
          node.replace(html)
        end
        doc
      end
    end
  end
end
