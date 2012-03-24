module ApplicationHelper
  def printed_timestamp(timestamp)
    time = timestamp.to_time
    content_tag :span, class: 'date' do
      if time < Time.now
        distance_of_time_in_words(time, Time.now) + ' ago'
      else
        content_tag(:span, time.to_s(:short), class: "actual")
      end
    end
  end
end
