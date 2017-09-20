require 'date'
module Bookable
  extend ActiveSupport::Concern

  def build(response)
    p response
    shows = []
    response["items"].each do |item|
      if all_day?(item)
        start = item["start"]['date']
        end_date = item["end"]['date']
        shows << Show.new(start: DateTime.parse(start), show_end: DateTime.parse(end_date), info: item["summary"])
      else
        shows << Show.new(start: DateTime.parse(item["start"]["dateTime"]), show_end: DateTime.parse(item["end"]["dateTime"]), info: item["summary"])
      end
    end
    {shows: shows, conflicts: find_conflicts(shows)}
  end

  private

  def all_day?(item)
    !item['start'].has_key?('dateTime')
  end

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
