class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :channel

  def time
    created_at.strftime('%-d/%-m/%y %H:%M')
  end

  def serializable_hash(options = {})
    json = super.merge(options)
    json[:time] = time
    return json
  end

end
