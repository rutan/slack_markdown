# frozen_string_literal: true

require 'html/pipeline'
require 'slack_markdown/filters/ignorable_ancestor_tags'

module SlackMarkdown
  module Filters
    class QuoteFilter < ::HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        html = replace_quote_line(doc.to_s)
        collect_blockquote(html)
      end

      private

      def replace_quote_line(str)
        str.gsub(/^&gt;\s*(.+)(?:\n|$)/) do
          "<blockquote>#{Regexp.last_match(1)}\n</blockquote>"
        end
      end

      def collect_blockquote(html)
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
