require 'date'
module Bookable
  extend ActiveSupport::Concern

  def build(response)
    shows = []
    response["items"].each do |item|
      p item["start"]
      shows << Show.new(start: DateTime.parse(item["start"]["dateTime"]), show_end: DateTime.parse(item["end"]["dateTime"]), info: item["summary"])
    end
    shows
  end
end
