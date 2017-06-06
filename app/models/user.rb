class User < ApplicationRecord

  #extend commentable
  def can_comment?
    true
  end
  #end extend

  def can_edit?
    true
  end

  def can_create?
    true
  end


end
