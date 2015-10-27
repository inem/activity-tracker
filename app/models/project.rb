class Project < ActiveRecord::Base




  #Убрать дублирование с таким же методом в User
  def clone_repo
    repo = Git.clone("https://github.com/" + self.repo + ".git",
                      self.repo.split("/").join("-"), path: "#{Rails.root}/tmp/projects")
    repo.dir.path
    rescue Git::GitExecuteError
      "#{Rails.root}/tmp/projects/#{self.repo.split('/').join('-')}"
  end

end
