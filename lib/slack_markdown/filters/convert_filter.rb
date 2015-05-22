# encoding: utf-8

require 'html/pipeline'
require 'escape_utils'

module SlackMarkdown
  module Filters
    # https://api.slack.com/docs/formatting
    class ConvertFilter < ::HTML::Pipeline::TextFilter
      def call
        html = @text.gsub(/<([^>\|]+)(?:\|([^>]+))?>/) do |match|
          link_data = $1
          link_text = $2
          create_link(link_data, link_text)
        end
        Nokogiri::HTML.fragment(html)
      end

      private

      def create_link(data, override_text = nil)
        klass, link, text =
          case data
          when /\A#(C.+)\z/ # channel
            channel = self.context.include?(:on_slack_channel_id) ? self.context[:on_slack_channel_id].call($1) : nil
            if channel
              ['channel', channel[:url], "##{channel[:text]}"]
            else
              ['channel', data, data]
            end
          when /\A@((?:U|B).+)/ # user or bot
            user = self.context.include?(:on_slack_user_id) ? self.context[:on_slack_user_id].call($1) : nil
            if user
              ['mention', user[:url], "@#{user[:text]}"]
            else
              ['mention', nil, data]
            end
          when /\A@(.+)/ # user name
            user = self.context.include?(:on_slack_user_name) ? self.context[:on_slack_user_name].call($1) : nil
            if user
              ['mention', user[:url], "@#{user[:text]}"]
            else
              ['mention', nil, data]
            end
          when /\A!/ # special command
            ['link', nil, data]
          else # normal link
            ['link', data, data]
          end

        if link
          escaped_link =
            if self.context[:cushion_link] && link.match(/\A([A-Za-z0-9]+:)?\/\//)
              "#{EscapeUtils.escape_html self.context[:cushion_link]}#{EscapeUtils.escape_url link}"
            else
              "#{EscapeUtils.escape_html(link)}"
            end
          "<a href=\"#{escaped_link}\" class=\"#{EscapeUtils.escape_html(klass)}\">#{EscapeUtils.escape_html(override_text || text)}</a>"
        else
          EscapeUtils.escape_html(override_text || text)
        end
      end
    end
  end
end
