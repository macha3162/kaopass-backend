class VisitHistory < ApplicationRecord
  belongs_to :user

  def self.group_count
    #select count, count(*) as total from (select count(1) as count from visit_histories GROUP BY user_id) as b GROUP BY count order by count;


  end
end
