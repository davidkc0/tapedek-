class Report < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true
  belongs_to :user
  validates :user_id, uniqueness: { scope: [:reportable_type, :reportable_id] }
end
