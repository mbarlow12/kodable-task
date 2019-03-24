require 'models'
require 'date'

module Controllers

  def self.format_date(date_obj)
    date_obj.strftime('%F')
  end

  def get_all_people
    Models::Person.all
  end

  def get_all_consumptions
    # Models::Pizza.all_pizzas_with_people
    Models::Pizza.all_pizzas_with_people.map do |cons|
      {
        :id => cons.id,
        :type => cons.type,
        :name => cons[:name],
        :eaten_at => cons.eaten_at
      }
    end
  end

  def get_streaks
    streaks = []
    in_streak = false
    last_date = nil
    last_eaten = nil
    idx = 0
    Models::Pizza.pizzas_grouped_by_day.each do |za|
      current_date = za[:eaten_at]
      current_eaten = za[:count]
      streak_hash = {
        date: self.format_date(current_date),
        count: current_eaten
      }

      if last_date
        day_diff = current_date - last_date
        more_eaten = current_eaten > last_eaten
        if more_eaten &&
           (day_diff == 1 || (day_diff == 2 && (current_date - 1).wday == 0))
          # consecutive days or over sunday
          if !in_streak
            streaks.push([
              {
                date: self.format_date(last_date),
                count: last_eaten
              },
              streak_hash
            ])
            in_streak = true
          else
            streaks[idx].push(streak_hash)
          end
        else
          # the days are not consecutive or the amount eaten is less
          in_streak = false
          idx += 1
        end
      end
      last_date, last_eaten = current_date, current_eaten
    end
    i = 0
    return streaks
  end

  def get_month_max(month)
    max_day = nil
    Models::Pizza.pizzas_grouped_by_day.each do |day|
      curr_month = day[:eaten_at].strftime('%B').downcase
      if curr_month == month
        max_day = if max_day then max_day else day end
        if day[:count] > max_day[:count]
          max_day = day
        end
      end
    end
    return { month: month, date: self.format_date(max_day[:eaten_at]), count: max_day[:count] }
  end

  module_function :get_all_people, :get_all_consumptions, :get_streaks, :get_month_max
end
