class Posts < ActiveRecord::Base

  define_index do
    indexes title
    indexes body
  end
end
