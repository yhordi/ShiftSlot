require 'date'
module Bookable
  extend ActiveSupport::Concern

  def build(response)
    shows = []
    response["items"].each do |item|
      shows << Show.new(start: DateTime.parse(item["start"]["dateTime"]), show_end: DateTime.parse(item["end"]["dateTime"]), info: item["summary"])
    end
    {shows: shows, conflicts: find_conflicts(shows)}
  end

  private

  def find_conflicts(imported_shows)
    conflicts = []
    Show.all.each do |show|
      imported_shows.each do |i_show|
        if conflict?(i_show, show)
          conflicts << i_show
          imported_shows.delete(i_show)
        end
      end
    end
    conflicts
  end

  def conflict?(show1, show2)
    show1.info == show2.info || show1.start == show2.start
  end
end
