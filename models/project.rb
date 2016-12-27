class Project < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :spools


  def check_in_use(spoolid)
    projects = current_user.projects
    projects.each do |e|
      if e.spool_ids.include? spoolid
        return true
      end
    end
  end


end
