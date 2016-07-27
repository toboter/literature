class Subject < ApplicationRecord
  self.inheritance_column = :type 
  has_closure_tree
  
  def self.types
    %w(Monograph InBook Collection InCollection Proceeding InProceeding Journal Issue InJournal Reference InReference Misc)
  end
	
end

class Monograph < Subject
end

class InBook < Subject
end

class Collection < Subject
end

class InCollection < Subject
end

class Proceeding < Subject
end

class InProceeding < Subject
end

class Journal < Subject
end

class Issue < Subject
end

class InJournal < Subject
end

class Reference < Subject
end

class InReference < Subject
end

class Misc < Subject
end






