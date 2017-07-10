class Stage < ActiveRecord::Base
  belongs_to :journey
  belongs_to :stageable, polymorphic: true
end
