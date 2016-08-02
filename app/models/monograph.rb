class Monograph < Subject
  validates :title, :published_date, :creator_list, presence: true # authors, publisher
  
  def full_title(style='harvard')
    "#{creators.order(lname: :asc).map(&:rname).join(', ')}, #{published_date}, #{title}. #{subtitle}. #{place.try(:name)}: #{publisher.try(:name)}" 
  end
end


# Barker, R., Kirk, J. and Munday, R.J., 1988. Narrative analysis. 3rd ed. Bloomington: Indiana University Press.

# Allouche, Jose. ed., 2006. Corporate social resposibility, Volume 1: concepts, accountability and reporting. Basingstoke: Palgrave Macmillan.