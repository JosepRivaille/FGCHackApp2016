class User < ApplicationRecord

  def add_id_tag(id_tag)
    self.idTag = id_tag
  end

end
