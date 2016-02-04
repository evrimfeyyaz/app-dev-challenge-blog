module ApplicationHelper
  def format_time_admin(time)
    if time
      content_tag :span, time, data: { time: time.iso8601 }
    else
      "n/a"
    end
  end

  def format_time(time)
    if time
      time_diff_days = (Time.now - time).to_i / 1.day
      
      if time_diff_days < 3
        time_ago_in_words(time).gsub("about", "") + " ago"
      else
        time.to_formatted_s(:month_date_year)
      end
    else
      "n/a"
    end
  end
end
